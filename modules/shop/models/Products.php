<?php

namespace modules\shop\models;

use modules\shop\models\categories\Features;
use system\core\Session;
use system\models\Content;
use system\models\Currency;

class Products extends Content
{
    public  $group_id = 7;
    public  $currency_id = 0;
    private $currency;
    private $debug = 0;
    /**
     * Products constructor.
     * @param $type
     * @param int $group_id default group id
     */
    public function __construct()
    {
        parent::__construct('product');

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : $this->group_id;

        $this->currency = new Currency();
    }

    public $start = 0;
    public $num = 15;
    private $total = 0;
    public $categories_id = 0;
    public $categories_in = [];

    private $where    = [];
    private $order_by = [];
    private $join     = [];

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

            $where[] = " (c.sku like '{$val}%' or ci.name like '%{$val}%' ) ";
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
                $this->orderBy('available desc, pp.price asc');
                break;
            case 'expensive':
                $this->orderBy('available desc, pp.price desc');
                break;
            case 'in-stock':
                $this->orderBy('c.in_stock = 1');
                break;
            default: //popular
                $this->orderBy('available desc, c.id desc');
                break;
        }
    }

    private function filter()
    {
        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

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
                }
            } else{
                $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$this->categories_id}");
            }
        }

        $q = $this->request->get('q', 's');
        if($q){
            $this->search();
        }

        if($this->hasError()){
            return false;
        }

        $this->sort();
        $this->filter();

        $ob = ! empty($this->order_by) ? "ORDER BY {$this->order_by}" : '';
        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);
        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $sel = empty($this->sel_fields) ? '' : ','.implode(',', $this->sel_fields);

        if(empty($this->currency_id)){
            $cu_on_site = $this->currency->getOnSiteMeta();
        } else {
            $cu_on_site = $this->currency->getMeta($this->currency_id);
        }

        $cu_main = $this->currency->getMainMeta();
//        $this->debug();

        $items = self::$db->select("
          select SQL_CALC_FOUND_ROWS c.id, ci.name, ci.title, c.in_stock, c.has_variants, crm.categories_id, ci.description, ci.url,
            CASE
              WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END as price,
           pp.price as pprice, '{$cu_on_site['symbol']}' as symbol, '{$cu_on_site['code']}' as currency_code {$sel},
           IF(c.in_stock = 1, 1, 0) as available
          from __content c
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          {$j}
          join __currency cu on cu.id = c.currency_id
          -- join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.types_id = 23 and c.status ='published' {$w}
          {$ob}
          limit {$this->start}, {$this->num}
          ", $this->debug)->all();

        foreach ($items as $k=>$item) {
            $items[$k]['price'] = ceil($item['price']);
        }

        $this->total = self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
        $this->clearQuery();
        return $items;
    }

    public function hits($start, $num)
    {
        if(empty($this->currency_id)){
            $cu_on_site = $this->currency->getOnSiteMeta();
        } else {
            $cu_on_site = $this->currency->getMeta($this->currency_id);
        }

        $cu_main = $this->currency->getMainMeta();

        $items = self::$db->select("
          select DISTINCT c.id, ci.name, ci.title, c.in_stock, c.has_variants, crm.categories_id, ci.description, ci.url,
            CASE
              WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END as price,
           pp.price as pprice, '{$cu_on_site['symbol']}' as symbol, '{$cu_on_site['code']}' as currency_code ,
           IF(c.in_stock = 1, 1, 0) as available
          from __content_meta cm
          join __content c on c.types_id=23 and c.status ='published' and c.in_stock=1
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          join __currency cu on cu.id = c.currency_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where cm.meta_k='hit' and cm.meta_v = 1
          limit {$start}, {$num}
          ", $this->debug)->all();

        foreach ($items as $k=>$item) {
            $items[$k]['price'] = ceil($item['price']);
        }

        return $items;
    }

    public function last($start, $num = 30)
    {
        if(empty($this->currency_id)){
            $cu_on_site = $this->currency->getOnSiteMeta();
        } else {
            $cu_on_site = $this->currency->getMeta($this->currency_id);
        }

        $cu_main = $this->currency->getMainMeta();

        $items = self::$db->select("
          select c.id, ci.name, ci.title, c.in_stock, c.has_variants, crm.categories_id, ci.description, ci.url,
            CASE
              WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
              WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END as price,
           pp.price as pprice, '{$cu_on_site['symbol']}' as symbol, '{$cu_on_site['code']}' as currency_code ,
           IF(c.in_stock = 1, 1, 0) as available
          from __content c
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}
          join __currency cu on cu.id = c.currency_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.types_id=23 and c.status ='published' and c.in_stock=1
          limit {$start}, {$num}
          ", $this->debug)->all();

        foreach ($items as $k=>$item) {
            $items[$k]['price'] = ceil($item['price']);
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

    public function filteredCategories()
    {
        $this->clearQuery();
        $q = $this->request->get('q', 's');
        if($q){
            $this->search();
        }

        $w = empty($this->where) ? '' : 'and ' . implode(' and ', $this->where);

        $items =  self::$db->select("
          select distinct crm.categories_id as id, ci.name, ci.title
          from __content c
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=crm.categories_id and ci.languages_id={$this->languages_id}
          where c.status ='published' {$w}
	      order by ci.name asc
          limit 30
          ")->all();

        $res = [];

        // get parentCategories
        foreach ($items as $k=>$item) {

            $cat = $this->getParentCategory($item['id']);

            if(empty($cat)){
                $res[$item['id']]['cat'] = $cat;
                continue;
            }

            $res[$cat['id']]['cat'] = $cat;
            $res[$cat['id']]['items'][] = $item;
        }

        return $res;
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

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getData($id, $key = 'c.*')
    {
        return self::$db
            ->select("
                select {$key} , ci.name, ci.title
                from __content c
                join __content_info ci on ci.content_id='{$id}' and ci.languages_id='{$this->languages_id}'
                where c.id='{$id}'
                limit 1
            ")
            ->row();
    }

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
        $this->where(" c.in_stock = 1");
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