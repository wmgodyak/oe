<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\shop\models;

use modules\shop\models\categories\Features;
use system\core\Session;
use system\models\Content;

class Products extends Content
{
    private $group_id;

    /**
     * Products constructor.
     * @param $type
     * @param int $group_id default group id
     */
    public function __construct($type, $group_id)
    {
        parent::__construct($type);

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : $group_id;
    }

    /**
     * @param $categories_id
     * @param int $start
     * @param int $num
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id, $start = 0, $num = 5)
    {
        $w = []; $ob = ''; $j = '';
        $sort = $this->request->get('sort', 's');
        switch($sort){
            case 'cheap':
                $ob = 'pp.price asc';
                break;
            case 'expensive':
                $ob = 'pp.price desc';
                break;
            case 'in-stock':
                $w[] = 'c.in_stock = 1';
                break;
            default: //popular
                $ob = 'c.id desc';
                break;
        }

        // filter prices

        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($minp > 0 && $maxp > 0) {
            $w[] = "price between '{$minp}' and '{$maxp}'";
        } elseif($minp > 0 && $maxp == 0){
            $w[] = " price > '{$minp}'";
        } elseif($minp == 0 && $maxp > 0){
            $w[] = " price < '{$maxp}'";
        }

        // filter features
        $features = new Features();

        $sf = $features->parseGetParams();
        if($sf){
            foreach ($sf as $code => $values) {
                $features_id = $features->getIDByCode($code);
                if(empty($features_id) || empty($values)) continue;

                $j[] = "join __content_features cf{$features_id} on
                        cf{$features_id}.content_id=c.id
                    and cf{$features_id}.features_id = {$features_id}
                    and cf{$features_id}.values_id in (". implode(',', $values) .")
                    ";
            }
        }

        $ob = ! empty($ob) ? "ORDER BY {$ob}" : '';
        $w = empty($w) ? '' : 'and ' . implode(' and ', $w);
        $j = empty($j) ? '' : implode("\r\n", $j);

        $items =  self::$db->select("
          select SQL_CALC_FOUND_ROWS  c.id, c.isfolder, ci.name, ci.title, pp.price, cu.symbol
          from __content c
          join __content_relationship cr on cr.content_id=c.id and cr.categories_id={$categories_id}
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          {$j}
          join __currency cu on cu.id = c.currency_id
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
          {$ob}
          limit {$start}, {$num}
          ")->all();

        return $items;
    }

    public function getTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }
}