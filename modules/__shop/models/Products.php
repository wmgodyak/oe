<?php

namespace modules\shop\models;

use modules\shop\models\categories\Features;
use modules\shop\models\products\variants\ProductsVariants;
use system\core\Session;
use modules\shop\models\products\Prices;
use system\models\Content;
use system\models\ContentRelationship;

/**
 * Class Products
 * @package modules\shop\models
 */
class Products extends Content
{
    public  $group_id = 0;
    private $currency;
    private $debug = 0;
    public  $features;
    
    public $start = 0;
    public $num = 15;
    private $total = 0;
    public $categories_id = 0;
    public $categories_in = [];

    private $where    = [];
    private $order_by = [];
    private $join     = [];

    private $variants;

    private $kits;
    private $prices;
    private $relations;


    /**
     * Products constructor.
     */
    public function __construct()
    {
        parent::__construct('product');

        $user = Session::get('user');

        $this->group_id = isset($user['group_id']) ?
            $user['group_id'] :
            $this->settings['modules']['Shop']['config']['group_id'];

        $this->currency   = Session::get('currency');
        
        $this->features   = new \modules\shop\models\products\Features();

        $this->variants   = new ProductsVariants();
        $this->kits       = new \modules\shop\models\products\Kits();
        $this->prices     = new Prices();
        $this->relations  = new ContentRelationship();
    }

    public function debug($status = 1)
    {
        $this->debug = $status;

        return $this;
    }

    public function clearQuery()
    {
        $this->where = [];
        $this->join = [];
    }

    public function where($q)
    {
        $this->where[] = $q;
        return $this;
    }

    public function orderBy($ob)
    {
        $this->order_by = $ob;
        return $this;
    }

    public function join($join)
    {
        $this->join[] = $join;

        return $this;
    }

    public function sort()
    {
        $sort = $this->request->get('sort', 's');
        switch($sort){
            case 'cheap':
                $this->orderBy('available desc, pp.price asc');
                break;
            case 'expensive':
                $this->orderBy('available desc, pp.price desc');
                break;
            case 'in-stock':
                break;
            default: //popular
                $this->orderBy('available desc, c.id desc');
                break;
        }
    }

    public function filter()
    {
        $price = $this->request->get('price');

        if(empty($price)) return;

        $minp = 0; $maxp = 0;

        if(preg_match('/([0-9]+)\-([0-9]+)/',$price, $a)){
            if(isset($a[1])) $minp = $a[1];
            if(isset($a[2])) $maxp = $a[2];
        }

        if($minp > 0 && $maxp > 0) {
            $this->where("price between {$minp} and {$maxp}");
        } elseif($minp > 0 && $maxp == 0){
            $this->where(" price > {$minp}");
        } elseif($minp == 0 && $maxp > 0){
            $this->where(" price < {$maxp}");
        }

        // filter features
        $features = new Features();

        $sf = $features->parseGetParams();
        if($sf){
            foreach ($sf as $code => $values) {
                $features_id = $features->getIDByCode($code);
                if(empty($features_id) || empty($values)) continue;

                $this->join("join __content_features cf{$features_id} on
                        cf{$features_id}.content_id=c.id
                    and cf{$features_id}.features_id = {$features_id}
                    and cf{$features_id}.values_id in (". implode(',', $values) .")
                    ");
            }
        }
    }

    private $sel_fields = [];

    public function fields( $field )
    {
        $this->sel_fields[] = $field;

        return $this;
    }

    /**
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get()
    {
        if( !empty($this->categories_in)){
            $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id in (". implode(',', $this->categories_in) .")");
        } else if($this->categories_id > 0){
            if($this->isfolder($this->categories_id)){
                $in = $this->categoriesChildrenID($this->categories_id);
                if(! empty($in)){
                    $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id in (". implode(',', $in) .")");
                } else {
                    $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$this->categories_id}");
                }
            } else {
                $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$this->categories_id}");
            }
        }

        $ob = ! empty($this->order_by) ? "ORDER BY {$this->order_by}" : '';
        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);

        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $sel = empty($this->sel_fields) ? '' : ','.implode(',', $this->sel_fields);

        $products = self::$db->select("
          select SQL_CALC_FOUND_ROWS c.id,
            p.sku, p.quantity, p.in_stock, p.has_variants,
          ci.name, ci.title, crm.categories_id, ci.description,
            ROUND (CASE
              WHEN p.currency_id = {$this->currency['site']['id']} THEN pp.price
              WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id = {$this->currency['main']['id']} THEN pp.price * {$this->currency['site']['rate']}
              WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id <> {$this->currency['main']['id']} THEN pp.price / cu.rate * {$this->currency['site']['rate']}
            END, 2) as price,
            ROUND ( CASE
              WHEN p.currency_id = {$this->currency['site']['id']} THEN pp.price_old
              WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id = {$this->currency['main']['id']} THEN pp.price_old * {$this->currency['site']['rate']}
              WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id <> {$this->currency['main']['id']} THEN pp.price_old / cu.rate * {$this->currency['site']['rate']}
            END, 2) as price_old,
           pp.price as pp_rice, '{$this->currency['site']['symbol']}' as symbol, '{$this->currency['site']['code']}' as currency_code {$sel},
           IF(p.in_stock = 1, 1, 0) as available
          from __content c
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __products p on p.content_id=c.id
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          {$j}
          join __currency cu on cu.id = p.currency_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
          {$ob}
          limit {$this->start}, {$this->num}
          ", $this->debug)->all();

        if(!empty($products)){
            foreach ($products as $k => $product) {
                $products[$k]['features'] = $this->features->get($product['categories_id'], $product['id']);
                if($product['has_variants']){
                    $products[$k]['variants'] = $this->variants->get($product['id'], $this->group_id);
                }
            }
        }
        
        $this->total = self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
        $this->clearQuery();

        return $products;
    }

    public function data($id)
    {
        $product = self::$db->select("select * from __products where content_id={$id} limit 1")->row();
        unset($product['id'], $product['content_id']);

        $product['categories_id'] = $this->relations->getMainCategoriesId($id);

        $product['currency'] = $this->currency['site'];

        $prices = $this->prices->get($id, $this->group_id, $this->currency['site']['id']);
        $product['price']        = $prices['price'];
        $product['price_old']    = $prices['price_old'];

        $product['features'] = $this->features->get($product['categories_id'], $id);

        if($product['has_variants']){
            $product['variants'] = $this->variants->get($id, $this->group_id);
        }

        return $product;
    }

    public function kits($products_id)
    {
        $items = $this->kits->get($products_id);
        foreach ($items as $i=>$row) {
            $items[$i]['amount']      = 0;
            $items[$i]['original_amount'] = 0;
            $items[$i]['save_amount'] = 0;

            foreach ($row['products'] as $k=>$product) {
                $price = $this->prices->get($product['products_id'], $this->group_id, $this->currency['site']['id']);

                $items[$i]['products'][$k]['original_price'] = $price['price'];
                $items[$i]['products'][$k]['price']          = $items[$i]['products'][$k]['original_price'] - ($items[$i]['products'][$k]['original_price'] / 100 * $product['discount']);
                $items[$i]['products'][$k]['save_price']     = $items[$i]['products'][$k]['original_price'] - $items[$i]['products'][$k]['price'];

                $items[$i]['amount']          += round($items[$i]['products'][$k]['price'], 2);
                $items[$i]['original_amount'] += round($items[$i]['products'][$k]['original_price'], 2);
                $items[$i]['save_amount']     += round($items[$i]['products'][$k]['save_price'], 2);
            }
        }

        return $items;
    }

    /**
     * @param $start
     * @param $num
     * @return $this
     */
    public function limit($start, $num)
    {
        $this->start = $start;
        $this->num   = $num;

        return $this;
    }

    public function getTotal()
    {
        return $this->total;
//        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }

    /*
    public function search()
    {
        // search
        $q = $this->request->get('q');
        if(! $q) return null;

        if(strlen($q) < 3){
            $this->setError('Пошуковий запит має містити не менше 3х букв.');
            return null;
        }

        $bad_words = [];
        $words = explode(' ', $q);
        foreach($words as $key=>$word) {
            $words[$key] = trim($word);
            if(empty($words[$key])) unset($words[$key]);
        }

        $where_or = [];
        $where = [];
        $q = htmlentities($q, ENT_QUOTES, 'UTF-8');

        $where[]  = " p.sku like '{$q}%' ";
        $where[]  = " ci.name like '%{$q}%' ";
        $where[]  = " ci.content like '%{$q}%' ";

        if(empty($where)){
            $this->setError('Не займайтесь дурницями.');
            return;
        } else {
            $this->where("("  . implode(" OR ", $where_or) ." ". implode(" or ", $where) . ") ");
        }
    }

    public function filteredCategories()
    {
        $this->clearQuery();
        $q = $this->request->get('q', 's');
        if($q){
            $this->search();
        }

        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);

        $items =  self::$db->select("
          select distinct crm.categories_id as id, cat.name, cat.title
          from __content c
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          join __content_info cat on cat.content_id=crm.categories_id and cat.languages_id={$this->languages_id}
          where c.status ='published' {$w}
	      order by ci.name asc
          limit 30
          ")->all();

//        d($items);die;

        $res = [];

        // get parentCategories
        foreach ($items as $k=>$item) {

            $cat = $this->getParentCategory($item['id']);

            if(empty($cat)){
                $res[$item['id']]['cat'] = $cat;
                continue;
            }

            $item['t'] = $this->countFilteredProducts($item['id']);

            $res[$cat['id']]['cat'] = $cat;
            $res[$cat['id']]['items'][] = $item;
        }

        return $res;
    }

    private function countFilteredProducts($cat_id)
    {
        $this->clearQuery();
        $q = $this->request->get('q', 's');
        if($q){
            $this->search();
        }

        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);

        return self::$db->select("
          select count(c.id) as t
          from __content c
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1 and crm.categories_id={$cat_id}
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
          ")->row('t');
    }

    private function getParentCategory($id)
    {
        return self::$db->select("
          select c.parent_id as id, ci.name, ci.title
          from __content c
          join __content_info ci on ci.content_id=c.parent_id and ci.languages_id={$this->languages_id}
          where c.id={$id} and c.status ='published'
	      ")->row();
    }

    */


    private function isfolder($id)
    {
        return self::$db->select("select isfolder from __content where id={$id} limit 1")->row('isfolder') > 0;
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

    public function similar($product)
    {
        if(empty($product['features'])) return null;
        $this->clearQuery();
        $this->where("crm.categories_id = {$product['categories_id']}");
        $this->where(" p.in_stock = 1");
        $i=0;
        foreach ($product['features'] as $feature) {
            $this->join("join __content_features cf{$i} on cf{$i}.features_id={$feature['id']}
                and cf{$i}.content_id=c.id
                ");
            $i++;
        }

        $this->limit(0, 9);
        return $this->get();
    }
}