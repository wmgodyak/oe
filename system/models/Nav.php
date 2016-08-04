<?php

namespace system\models;
/**
 * Class Nav
 * @package system\models
 */
class Nav extends Model
{
    /**
     * @param $code
     * @param int $level
     * @return mixed
     */
    public function get($code, $level = 0)
    {
        $items = self::$db
            ->select("
              select c.id, c.isfolder, ci.name,ci.title
              from __nav n
              join __nav_items ni on ni.nav_id = n.id
              join __content c on c.id=ni.content_id and c.status='published'
              join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
              where n.code = '{$code}'
              order by abs(ni.position) asc
              ")
            ->all();

        if($level == 0){
            return $items;
        }

        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->items($item['id'], --$level);
            }
        }

        return $items;
    }

    /**
     * @param $parent_id
     * @param $level
     * @return mixed
     */
    private function items($parent_id, $level)
    {
        $items = self::$db
            ->select("
              select c.id, c.isfolder, ci.name,ci.title
              from __content c on c.id=ni.content_id and c.status='published'
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              where c.parent_id={$parent_id}
              ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder'] && $level > 0){
                $items[$k]['items'] = $this->items($item['id'], --$level);
            }
        }

        return $items;
    }

}