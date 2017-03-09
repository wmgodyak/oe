<?php

namespace modules\blog\models;

use system\models\Content;
use system\models\ContentRelationship;

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

    public $categories_id = 0;

    public $debug = 0;

    public function __construct()
    {
        parent::__construct('post');

        $this->tags = new Tags();
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

        $join = implode("\n", $join);
        $w = empty($this->where) ? "" : implode(' and ', $this->where);

        $r =  self::$db
            ->select("
                  select DISTINCT c.id, c.isfolder, c.status, ci.name, ci.title, ci.intro,
                   UNIX_TIMESTAMP(c.published) as published,
                   u.id as author_id, concat(u.name, ' ', u.surname) as author_name
                  from __content c
                  {$join}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
                  join __users u on u.id = c.owner_id
                  where c.status ='published' {$w}
                  order by abs(c.id) desc
                  limit {$this->start}, {$this->num}
            ", $this->debug)
            ->all();

        $res = [];

        foreach ($r as $item) {
            $item['author']     = ['id' => $item['author_id'], 'name' => $item['author_name']];
            $item['tags']       = $this->tags->get($item['id']);
            $item['categories'] = $this->categories($item['id']);

            unset($item['author_id'], $item['author_name']);

            $res[] = $item;
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

        $join = implode("\n", $join);

        $w = empty($this->where) ? "" : implode(' and ', $this->where);

        return self::$db
            ->select("
                  select count(c.id) as t
                  from __content c
                  {$join}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
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
    public function related($post_id, $start = 0, $num = 5)
    {
        $this->categories_id = 0;
        $this->start         = $start;
        $this->num           = $num;
        $this->where         = "c.id <> {$post_id}";

        return $this->get();
    }

    public function collect($post_id)
    {
        $c = $this->meta->get($post_id, 'views', true);
        $c++;
        return $this->meta->update($post_id, 'views', $c);
    }
}