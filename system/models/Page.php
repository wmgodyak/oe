<?php

namespace system\models;
use system\models\page\Features;

/**
 * Class Page
 * @package system\models
 */
class Page extends Model
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

}