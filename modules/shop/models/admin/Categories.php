<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.08.16 : 12:54
 */


namespace modules\shop\models\admin;


defined("CPATH") or die();

class Categories extends \modules\shop\models\Categories
{
    /**
     * @param int $parent_id
     * @param bool $recursive
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($parent_id = 0, $level = 0)
    {
        $items =  self::$db->select("
          select c.id, c.isfolder, ci.name, ci.title
          from __content c
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id='{$parent_id}' and c.status in ('published', 'hidden')
          ")->all();

        if($level > 0){
            foreach ($items as $k=>$item) {
                if($item['isfolder']){
                    $items[$k]['items'] = $this->get($item['id'], -- $level);
                }
            }
        }

        return $items;
    }
}