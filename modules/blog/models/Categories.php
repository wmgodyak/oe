<?php

namespace modules\blog\models;

use system\models\Content;

/**
 * Class Categories
 * @package modules\blog\models
 */
class Categories extends Content
{
    /**
     * @param int $parent_id
     * @return mixed
     */
    public function get($parent_id = 0)
    {
        $items =  self::$db->select("
          select c.id, c.isfolder, ci.name, ci.title
          from __content c
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id='{$parent_id}' and c.status = 'published'
          ")->all();

        foreach ($items as $k=>$item) {
            $items[$k]['count'] = self::$db
                ->select("select count(id) as t from __content_relationship 
                              where categories_id={$item['id']}
                              ")
                ->row('t');
        }

        return $items;
    }
}