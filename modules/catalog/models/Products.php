<?php

namespace modules\catalog\models;

use system\models\Content;
use system\models\ContentRelationship;
use system\models\Frontend;

class Products extends Frontend
{
    public  $config;
    public  $group_id;
    public  $features;

    private $currency;

    private  $start = 0;
    private  $ipp = 15;

    private $where    = [];
    private $order_by = [];
    private $join     = [];

    private $types_id;

    private $relations;

    public function __construct($config, $currency, $group_id)
    {
        parent::__construct();

        $this->config   = $config;

        $this->ipp= $this->config->ipp;

        $this->currency = $currency;
        $this->group_id = $group_id;

        $this->relations = new ContentRelationship();

        $c = new Content($this->config->type->product);
        $this->types_id = $c->types_id;
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

    /**
     * @param $start
     * @param $ipp
     * @return $this
     */
    public function limit($start, $ipp)
    {
        $this->start = $start;
        $this->ipp   = $ipp;

        return $this;
    }

    public function category($category_id)
    {
        if($this->isFolder($category_id)){
            $in = $this->subCategories($category_id);
            if(! empty($in)){
                $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id in (". implode(',', $in) .")");
            } else {
                $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$category_id}");
            }
        } else {
            $this->join("join __content_relationship cr on cr.content_id=c.id and cr.categories_id = {$category_id}");
        }

        return $this;
    }

    /**
     * @return int
     * @throws \system\core\exceptions\Exception
     */
    public function total()
    {
        $w = empty($this->where) ? '' : ' ' . implode('  ', $this->where);
        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $row =  self::$db
            ->select
            ("
              select count(*) as total, MIN(pp.price) as minp, MAX(pp.price) as maxp
              from __content c
              join __products p on p.content_id=c.id
              join __products_prices pp on pp.product_id=c.id and pp.group_id={$this->group_id}
              {$j}
              join __currency cu on cu.id = p.currency_id
              where c.types_id = {$this->types_id} and c.status ='published' {$w}
              ",
                $this->debug
            )
            ->row();

        $row['minp'] = ceil($row['minp']);
        $row['maxp'] = round($row['maxp']);

        return $row;
    }

    /**
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get()
    {
        $ob = ! empty($this->order_by) ? "ORDER BY {$this->order_by}" : '';
        $w = empty($this->where) ? '' : ' ' . implode('  ', $this->where);

        $j = empty($this->join) ? '' : implode("\r\n", $this->join);

        $r = self::$db
            ->select
            ("
              select c.id, p.in_stock as available
              from __content c
              join __products p on p.content_id=c.id
              join __products_prices pp on pp.product_id=c.id and pp.group_id={$this->group_id}
              {$j}
              join __currency cu on cu.id = p.currency_id
              where c.types_id = {$this->types_id} and c.status ='published' {$w}
              {$ob}
              limit {$this->start}, {$this->ipp}
              ",
                $this->debug
            )
            ->all();

        $this->clear();

        $res = [];
        foreach ($r as $item) {
            $res[$item['id']] = new Product($item['id'], $this->languages, $this->currency, $this->group_id);
        }

        return $res;
    }

    private function isFolder($id)
    {
        return self::$db->select("select isfolder from __content where id={$id} limit 1")->row('isfolder') > 0;
    }

    public function subCategories($parent_id)
    {
        $in = [];
        foreach (self::$db->select("select id, isfolder from __content where parent_id={$parent_id}")->all() as $item)
        {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->subCategories($item['id']));
            }
        }
        return $in;
    }

    public function clear()
    {
        $this->where = [];
        $this->join  = [];

        $this->start = 0;
        $this->ipp = $this->config->ipp;
    }
}