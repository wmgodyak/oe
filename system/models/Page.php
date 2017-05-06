<?php

namespace system\models;
use system\models\page\Features;

/**
 * Class Page
 * @package system\models
 */
class Page extends Frontend
{
    public $features;

    public function __construct()
    {
        parent::__construct();

        $this->features = new Features();
    }

    /**
     * get children list
     * @param $parent_id
     * @param $level
     * @return mixed
     */
    public function items($parent_id, $level = 0)
    {
        $items = self::$db
            ->select("
              select c.id, c.isfolder, ci.name, ci.title
              from __content c
              join __content_info ci on ci.content_id = c.id and ci.languages_id={$this->languages_id}
              where c.parent_id='{$parent_id}' and c.status='published'
              ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder'] && $level > 0){
                $items[$k]['items'] = $this->items($item['id'], --$level);
            }
        }

        return $items;
    }

    /**
     * @param $parent_id
     * @return mixed
     */
    public function totalItems($parent_id)
    {
        return self::$db
            ->select("
              select count(c.id) as t
              from __content c
              where c.parent_id='{$parent_id}' and c.status='published'
              ")
            ->row('t');
    }

    public function info($id, $key = '*')
    {
        return self::$db
            ->select("
                select {$key} 
                from __content_info 
                where content_id = '{$id}' and languages_id='{$this->languages_id}'
                limit 1
              ")
            -> row($key);
    }
    
    public function name($id)
    {
        return $this->info($id, 'name');
    }

    public function content($id)
    {
        return $this->info($id, 'content');
    }

    public function intro($id)
    {
        return $this->info($id, 'intro');
    }

    public function title($id)
    {
        return $this->info($id, 'title');
    }

    public function data($id, $key = '*')
    {
        return self::$db
            ->select("
                select {$key}
                from __content
                where id = '{$id}'
                limit 1
              ")
            -> row($key);
    }

    /**
     * @param $id
     * @param null $languages_id
     * @return string
     */
    public function url($id, $languages_id = null)
    {
        if(! $languages_id) $languages_id = $this->languages_id;

        $languages = new Languages();

        $url = self::$db
            ->select("select url from __content_info where content_id = '{$id}' and languages_id={$languages_id} limit 1")
            ->row('url');

        if($languages_id == $languages->getDefault('id')){
            return APPURL . $url;
        }

        $code = $languages->getData($languages_id, 'code');

        return APPURL. $code .'/'. $url;
    }

    /**
     * @param $url
     * @param null $languages_id
     * @return array|mixed
     */
    public function getIdByUrl($url, $languages_id = null)
    {
       if(! $languages_id) $languages_id = $this->languages_id;

       return self::$db
            ->select
            ("
                    select i.content_id
                    from __content_info i
                    where i.url = '{$url}' and i.languages_id='{$languages_id}'
                    limit 1
                ")
            ->row('content_id');
    }

    /**
     * @param $id
     * @param null $languages_id
     * @return array|mixed|null
     */
    public function fullInfo($id, $languages_id = null)
    {
        if($languages_id) $this->languages_id = $languages_id;
        $page = self::$db
            ->select("
                select c.*,
                i.languages_id, i.name,i.title,i.h1,i.keywords, i.description,i.content, i.intro,
                 l.code as languages_code,
                 UNIX_TIMESTAMP(c.created) as created,
                 UNIX_TIMESTAMP(c.published) as published
                from __content_info i
                join __content c on c.id=i.content_id
                join __languages l on l.id=i.languages_id
                where c.id={$id} and i.languages_id='{$this->languages_id}'
                limit 1
                ")
            ->row();

        if(empty($page)) return null;

        // page template
        if($page['types_id'] == $page['subtypes_id']){
            $page['template'] = self::$db
                ->select("select type from __content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['type'] = $page['template'];
        } else {
            $type = self::$db
                ->select("select type from __content_types where id={$page['types_id']} limit 1")
                ->row('type');
            $subtype = self::$db
                ->select("select type from __content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['template'] = $type .'/'. $subtype;

            $page['type'] =$type;
        }

        $page['url'] = $this->url($page['id']);

        // cover image
        $page['image'] = $this->images->cover($page['id']);

        // author
        $page['author'] = self::$db
            ->select("select id, name, surname, email, phone, avatar from __users where id='{$page['owner_id']}'")
            ->row();

        return $page;
    }

    public function getRelationMainCategoryID($content_id)
    {
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} order by is_main desc limit 1")
            ->row('categories_id');
    }
}