<?php

namespace modules\shop\models\admin;

use system\core\Session;
use system\models\ContentRelationship;
use system\models\Model;

/**
 * Class Products
 * @package modules\shop\models\admin
 */
class Products extends Model
{
    private $currency;
    public  $relations;
    private $type = 'product';


    public function __construct()
    {
        parent::__construct();

        $this->currency = Session::get('currency');
        $this->relations = new ContentRelationship();
    }

    /**
     * @param $content_id
     * @param $data
     * @return bool|string
     */
    public function create($content_id, $data)
    {
        $data['content_id'] = $content_id;
        if(empty($data['sku'])){
            $data['sku'] = $content_id;
        }
        return $this->createRow('__products', $data);
    }

    public function update($content_id, $data)
    {
        $aid = self::$db->select("select id from __products where content_id = {$content_id} limit 1")->row('id');
        if(empty($aid)){
            return $this->create($content_id, $data);
        }

        $this->updateRow('__products', $aid, $data);
    }



    /**
     * @param int $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id = 0, $start = 0, $num = 5)
    {
        $w = ''; $j = '';

        if($categories_id > 0){
            $j .= "join __content_relationship cr on cr.categories_id={$categories_id} and cr.content_id=c.id";
        }

        return self::$db
            ->select("
                  select c.id, c.isfolder, c.status, ci.name, ci.title, ci.intro, c.created, u.id as author_id, concat(u.name, ' ', u.surname) as author
                  from __content c
                  {$j}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
                  join __users u on u.id = c.owner_id
                  where {$w} c.status in ('published', 'hidden')
                  order by c.published desc
                  limit {$start}, {$num}
            ")
            ->all();
    }

    public function export($categories_id = 0)
    {
        $join = []; $where = []; $group_id = 0;

        if($categories_id > 0){
            $join[] = "join __content_relationship cr on cr.categories_id={$categories_id} and cr.content_id=c.id";
        }

        $currency_id = $this->request->get('currency_id', 'i');

        if(! $currency_id){
            $this->currency['site'] = $this->currency->getOnSiteMeta();

        } else {
            $this->currency['site'] = $this->currency->getMeta($currency_id);
        }

        if(isset($_GET['group_id']) && $_GET['group_id'] > 0){
            $group_id = $_GET['group_id'];
        }

        $price = "(CASE
            WHEN c.currency_id = {$this->currency['site']['id']} and c.currency_id = {$this->currency['main']['id']} THEN pp.price
            WHEN c.currency_id = {$this->currency['site']['id']} and c.currency_id <> {$this->currency['main']['id']} THEN pp.price / cu.rate * {$this->currency['site']['rate']}

            WHEN c.currency_id <> {$this->currency['site']['id']} and c.currency_id = {$this->currency['main']['id']} THEN pp.price * {$this->currency['site']['rate']}
            WHEN c.currency_id <> {$this->currency['site']['id']} and c.currency_id <> {$this->currency['main']['id']} THEN 1
            END )";

        $_GET['minp'] = isset($_GET['minp']) ? $_GET['minp'] : 0;
        $_GET['maxp'] = isset($_GET['maxp']) ? $_GET['maxp'] : 0;
        if($_GET['minp'] > 0 && $_GET['maxp'] > 0){
            $where[] = " $price between '{$_GET['minp']}' and '{$_GET['maxp']}' ";
        } elseif($_GET['minp'] > 0 && empty($_GET['maxp'])){
            $where[] = " $price >= '{$_GET['minp']}'";
        } elseif(empty($_GET['minp']) && $_GET['maxp'] > 0){
            $where[] = " $price <= '{$_GET['maxp']}'";
        }

        if(isset($_GET['sku']) && strlen($_GET['sku']) > 2){
            $where[]= " c.sku like '{$_GET['sku']}%'";
        }

        if(isset($_GET['extra'])){

            switch($_GET['extra']){
                case 'publsihed':
                    $where[] = " c.status = 'publsihed'";
                    break;
                case 'hidden':
                    $where[] = " c.status = 'hidden'";
                    break;
                case 'noimage':
                    $where[] = " c.id not in (select content_id from e_content_images) ";
                    break;
                default:
//                        $where[] = " c.status in ('published', 'hidden')";
                    break;
            }
        }

        // filter features

        if(isset($_GET['f'])){
            foreach ($_GET['f'] as $features_id => $a) {
                $in = implode(',', $a);

                $join[] = ("__content_features cf{$features_id} on
                        cf{$features_id}.content_id=c.id
                    and cf{$features_id}.features_id = {$features_id}
                    and cf{$features_id}.values_id in (". $in .")
                    ");
            }
        }

        $where = !empty($where) ? 'and ' . implode(' and ', $where)  : null;
        $join = !empty($join) ? implode('', $join) : null;

        return self::$db
            ->select("
                  select c.id, c.sku, ci.name, price, cu.code, c.status, c.created, c.updated
                  from __content c
                  {$join}
                  join __content_types ct on ct.type = 'product' and ct.id=c.types_id
                  join __products_prices pp on pp.content_id=c.id and pp.group_id={$group_id}
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
                  join __currency cu on cu.id = c.currency_id
                  where c.status in ('published', 'hidden') {$where}
                  order by c.published desc
            ")
            ->all();
    }

    public function categoriesChildrenID($parent_id)
    {
        $in = [];
        foreach (self::$db->select("select id, isfolder from __content where parent_id={$parent_id}")->all() as $item)
        {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->categoriesChildrenID($item['id']));
            }
        }
        return $in;
    }

    public function isfolder($id)
    {
        return self::$db->select("select isfolder from __content where id={$id} limit 1")->row('isfolder') > 0;
    }
}