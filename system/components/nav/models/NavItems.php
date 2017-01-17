<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.10.16 : 10:24
 */

namespace system\components\nav\models;

use system\models\Backend;

defined("CPATH") or die();

/**
 * Class NavItems
 * @package system\components\nav\models
 */
class NavItems extends Backend
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __nav_items where id={$id} limit 1")->row($key);
    }

    /**
     * @param $nav_id
     * @param $items
     * @param int $parent_id
     */
    public function reorder($nav_id, $items, $parent_id = 0)
    {
        foreach ($items as $position => $item) {

            $prev_parent_id = self::$db->select("select parent_id from __nav_items where id={$item['id']} limit 1")->row('parent_id');
            if($prev_parent_id > 0){
                $c = self::$db->select("select count(*) as t from __nav_items where parent_id={$prev_parent_id}")->row('t');
                if($c == 0){
                    $this->updateRow('__nav_items', $prev_parent_id, ['isfolder' => 0]);
                }
            }

            $this->updateRow('__nav_items', $item['id'], ['position' => $position, 'parent_id' => $parent_id]);
            if($parent_id > 0){
                $this->updateRow('__nav_items', $parent_id, ['isfolder' => 1]);    
            }

            if(isset($item['children']) && !empty($item['children'])){
                $this->reorder($nav_id, $item['children'], $item['id']);
            }
        }

        return ! $this->hasError();
    }
}