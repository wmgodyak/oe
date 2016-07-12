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
use system\models\Currency;

class Products extends Content
{
    private $group_id = 20;
    private $currency;

    /**
     * Products constructor.
     * @param $type
     * @param int $group_id default group id
     */
    public function __construct($type)
    {
        parent::__construct($type);

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : $this->group_id;

        $this->currency = new Currency();
    }

    public $start = 0;
    public $num = 15;
    public $categories_id = 0;

    private $where    = [];
    private $order_by = [];
    private $join     = [];

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

    private function search()
    {
        // search
        $q = $this->request->get('q', 's');
        if(! $q) return;

        if(strlen($q) < 3){
            $this->setError('Пошуковий запит має містити не менше 3х букв.');
            return;
        }

        $bad_words = [];
        $words = explode(' ', $q);
        foreach($words as $key=>$word) {
            $words[$key] = trim($word);
            if(empty($words[$key])) unset($words[$key]);
        }

        $where = [];
        foreach ($words as $val) {
            if(in_array($val, $bad_words)) continue;
            $val = trim($val);
            $val = strip_tags($val);
            $val = addcslashes($val, '"\'');
            if(empty($val)) continue;
            $where[] = " ci.name like '%{$val}%'";
        }

        if(empty($where)){
            $this->setError('Не займайтесь дурницями.');
            return;
        } else{
            $this->where("(" . implode(" AND ", $where) . ")");
        }
    }

    private function sort()
    {
        $sort = $this->request->get('sort', 's');
        switch($sort){
            case 'cheap':
                $this->orderBy('pp.price asc');
                break;
            case 'expensive':
                $this->orderBy('pp.price desc');
                break;
            case 'in-stock':
                $this->orderBy('c.in_stock = 1');
                break;
            default: //popular
                $this->orderBy('c.id desc');
                break;
        }
    }

    private function filter()
    {
        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($minp > 0 && $maxp > 0) {
            $this->where("price between '{$minp}' and '{$maxp}'");
        } elseif($minp > 0 && $maxp == 0){
            $this->where(" price > '{$minp}'");
        } elseif($minp == 0 && $maxp > 0){
            $this->where(" price < '{$maxp}'");
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

    /**
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get()
    {
        if($this->categories_id > 0){
            $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$this->categories_id}");
        }

        $this->search();

        if($this->hasError()){
            return false;
        }

        $this->sort();
        $this->filter();

        $ob = ! empty($this->order_by) ? "ORDER BY {$this->order_by}" : '';
        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);
        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $cu_on_site = $this->currency->getOnSiteMeta();
        $cu_main    = $this->currency->getMainMeta();

        $items =  self::$db->select("
          select SQL_CALC_FOUND_ROWS  c.id, c.isfolder, ci.name, ci.title,
           ROUND( CASE
            WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END, 2 ) as price,
           pp.price as pprice, '{$cu_on_site['symbol']}' as symbol
          from __content c
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          {$j}
          join __currency cu on cu.id = c.currency_id
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
          {$ob}
          limit {$this->start}, {$this->num}
          ")->all();

        return $items;
    }

    public function getTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }

    public function filteredCategories()
    {
        if($this->categories_id > 0){
            $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$this->categories_id}");
        }
//        $j = empty($this->join) ? '' : implode("\r\n", $this->join);
        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);
        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $items =  self::$db->select("
          select DISTINCT cr.categories_id as id, ci.name, ci.title
          from __content c
          {$j}
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_relationship cr on cr.content_id=c.id
          join __content_info ci on ci.content_id=cr.categories_id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
          order by ci.name asc
          limit {$this->start}, {$this->num}
          ")->all();

        return $items;
    }
}