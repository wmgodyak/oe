<?php

namespace modules\megamenu\models;

use system\models\Model;

/**
 * Class Posts
 * @package modules\blog\models
 */
class Megamenu extends Model
{
    public $debug = 0;

    private $where =[];
    private $join =[];

    public function __construct()
    {
        parent::__construct();
    }

    public function setWhere($array)
    {
        if(!empty($array)) {
            foreach($array as $item) {
                $this->where[] = $item;
            }
        }
    }

    public function setJoin($array)
    {
        if(!empty($array)) {
            foreach($array as $item) {
                $this->join[] = $item;
            }
        }
    }

    public function getData()
    {
        $where = empty($this->where) ? "" : ' WHERE '.implode(' AND ', $this->where);
        $join = empty($this->join) ? "" : ' '.implode(' ', $this->join);
        $select = self::$db->select("
            SELECT *
            FROM `__megamenu` AS `main_table`{$join}{$where}",
            $this->debug)->all();
        if(count($select) > 0) {
            return $select[0];
        }
        return $select;
    }

    public function debug($status = false)
    {
        $this->debug = $status;
    }

    /**
     * @return array
     */
    public function get()
    {
//        $join = $this->join;
//        if($this->categories_id > 0){
//            $join[] = "join __content_relationship cr on cr.categories_id={$this->categories_id} and cr.content_id=c.id";
//        }
//
//        $join = implode("\n", $join);
//        $w = empty($this->where) ? "" : implode(' and ', $this->where);
//
//        $r =  self::$db
//            ->select("
//                  select DISTINCT c.id, c.isfolder, c.status, ci.name, ci.title, ci.intro,
//                   UNIX_TIMESTAMP(c.published) as published,
//                   u.id as author_id, concat(u.name, ' ', u.surname) as author_name
//                  from __content c
//                  {$join}
//                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
//                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages->id}'
//                  join __users u on u.id = c.owner_id
//                  where c.status ='published' {$w}
//                  order by {$this->order_by}
//                  limit {$this->start}, {$this->num}
//            ", $this->debug)
//            ->all();
//
//        $res = [];
//
//        foreach ($r as $item) {
//            $item['url']        = $this->app->page->url($item['id']);
//            $item['author']     = ['id' => $item['author_id'], 'name' => $item['author_name']];
//            $item['tags']       = $this->tags->get($item['id']);
//            $item['categories'] = $this->categories($item['id']);
//
//            unset($item['author_id'], $item['author_name']);
//
//            $res[] = $item;
//        }
//        return $res;
    }

    public function categories($post_id)
    {
//        return  $this->relations->getCategoriesFull($post_id);
    }

    /**
     * @return array|mixed
     */
    public function total()
    {
//        $join = $this->join;
//
//        if($this->categories_id > 0){
//            $join[] = "join __content_relationship cr on cr.categories_id={$this->categories_id} and cr.content_id=c.id";
//        }
//
//        $join = implode("\n", $join);
//
//        $w = empty($this->where) ? "" : implode(' and ', $this->where);
//
//        return self::$db
//            ->select("
//                  select count(c.id) as t
//                  from __content c
//                  {$join}
//                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
//                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages->id}'
//                  where c.status = 'published' {$w}
//            ", $this->debug)
//            ->row('t');
    }

    /**
     * @param $post_id
     * @param int $start
     * @param int $num
     * @return array
     */
    public function related($post_id, $num = 5, $start = 0)
    {
//        $this->categories_id = 0;
//        $this->start         = $start;
//        $this->num           = $num;
//        $this->where         = "c.id <> {$post_id}";
//
//        return $this->get();
    }

    /**
     * @param $num
     * @param int $start
     * @return array
     */
    public function popular($num, $start = 0)
    {
//        $this->categories_id = 0;
//        $this->start         = $start;
//        $this->num           = $num;
//        $this->join[] = " join __content_meta cm on cm.content_id=c.id and cm.meta_k = 'views' ";
//
//        $this->where[] = " and c.published >= DATE_ADD(LAST_DAY(DATE_SUB(NOW(), INTERVAL 2 MONTH)), INTERVAL 1 DAY) and c.published <= DATE_SUB(NOW(), INTERVAL 1 MONTH)";
//
//        return $this->get();
    }

    public function collect($post_id)
    {
//        $c = $this->meta->get($post_id, 'views', true);
//        $c++;
//        return $this->meta->update($post_id, 'views', $c);
    }
}