<?php

namespace modules\blog\models;

use system\models\Content;
use system\models\ContentRelationship;
use system\models\Users;

/**
 * Class Posts
 * @package modules\blog\models
 */
class Posts extends Content
{
    private $relations;
    public  $tags;
    public  $start = 0;
    public  $num = 5;
    public  $where = [];
    public  $join = [];

    private $order_by = " abs(c.id) desc ";

    public $categories_id = 0;

    public $debug = 0;

    public function __construct($type)
    {
        parent::__construct($type);

        $this->tags      = new Tags();
        $this->relations = new ContentRelationship();
    }

    /**
     * @return array
     */
    public function get()
    {
        $join = $this->join;

        if($this->categories_id > 0){
            $join[] = "join __content_relationship cr on cr.categories_id={$this->categories_id} and cr.content_id=c.id";
        }

        $join = empty($join) ? "" : implode("\n", $join);
        $w    = empty($this->where) ? "" : " and " . implode(' and ', $this->where);

        $r =  self::$db
            ->select("
                  select DISTINCT c.id, c.isfolder, c.status, ci.name, ci.title, ci.intro, c.owner_id,
                   UNIX_TIMESTAMP(c.published) as published
                  from __content c
                  {$join}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages->id}'
                  where c.status ='published' {$w}
                  order by {$this->order_by}
                  limit {$this->start}, {$this->num}
            ", $this->debug)
            ->all();

        if(empty($r)) return null;

        $res = [];

        $u = new Users();
        foreach ($r as $item) {
            $item['author']     = $u->getData($item['owner_id']);
            $item['url']        = $this->app->page->url($item['id']);
            $item['tags']       = $this->tags->get($item['id']);
            $item['categories'] = $this->categories($item['id']);
            $item['views']      = (int)$this->meta->get($item['id'], 'views', true);

            unset($item['author_id'], $item['author_name']);

            $res[] = $item;
        }

        if($this->num == 1){
            return $res[0];
        }

        return $res;
    }

    public function categories($post_id)
    {
        return  $this->relations->getCategoriesFull($post_id);
    }

    /**
     * @return array|mixed
     */
    public function total()
    {
        $join = $this->join;

        if($this->categories_id > 0){
            $join[] = "join __content_relationship cr on cr.categories_id={$this->categories_id} and cr.content_id=c.id";
        }

        $join = empty($join) ? "" : implode("\n", $join);
        $w    = empty($this->where) ? "" : " and " . implode(' and ', $this->where);

        return self::$db
            ->select("
                  select count(c.id) as t
                  from __content c
                  {$join}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages->id}'
                  where c.status = 'published' {$w}
            ", $this->debug)
            ->row('t');
    }

    /**
     * @param $post_id
     * @param int $start
     * @param int $num
     * @return array
     */
    public function related($post_id, $num = 5, $start = 0)
    {
//        $this->debug         = 1;
        $this->where       = [];
        $this->categories_id = 0;
        $this->start         = $start;
        $this->num           = $num;
        $this->where[]         = " c.id <> {$post_id} ";

        return $this->get();
    }

    /**
     * @param $num
     * @param int $start
     * @return array
     */
    public function popular($num, $start = 0)
    {
        $this->categories_id = 0;
        $this->start         = $start;
        $this->num           = $num;
        $this->join[]        = " join __content_meta cm on cm.content_id=c.id and cm.meta_k = 'views' ";

        $this->where[]       = " and c.published >= DATE_ADD(LAST_DAY(DATE_SUB(NOW(), INTERVAL 2 MONTH)), INTERVAL 1 DAY) and c.published <= DATE_SUB(NOW(), INTERVAL 1 MONTH)";

        return $this->get();
    }

    public function collect($post_id)
    {
        $c = $this->meta->get($post_id, 'views', true);
        $c++;
        return $this->meta->update($post_id, 'views', $c);
    }

    /**
     * @param $current_post_id
     * @param int $category_id
     * @return array
     */
    public function next($current_post_id, $category_id = 0)
    {
        $this->where         = [];
        $this->where[]       = " c.id > $current_post_id ";
        $this->order_by      = " c.id desc ";
        $this->categories_id = $category_id;
        $this->start         = 0;
        $this->num           = 1;

        return $this->get();
    }

    /**
     * @param $current_post_id
     * @param int $category_id
     * @return array
     */
    public function prev($current_post_id, $category_id = 0)
    {
        $this->where = [];
        $this->where[]       = " c.id < $current_post_id ";
        $this->order_by      = " c.id desc ";
        $this->categories_id = $category_id;
        $this->start         = 0;
        $this->num           = 1;

        return $this->get();
    }
}