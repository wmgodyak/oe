<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 21:34
 */

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
     * @param bool $recursive
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($parent_id = 0, $recursive = false)
    {
        $items =  self::$db->select("
          select c.id, c.isfolder, ci.name, ci.title
          from __content c
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id='{$parent_id}' and c.status in ('published', 'hidden')
          ")->all();

        if($recursive){
            foreach ($items as $k=>$item) {
                if($item['isfolder']){
                    $items[$k]['items'] = $this->get($item['id'], $recursive);
                }
            }
        }

        return $items;
    }
}