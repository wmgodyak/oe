<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 20.07.16
 * Time: 17:13
 */

namespace system\models;

class Page extends Model
{
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
              select c.id, c.isfolder, ci.name,ci.title
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

}