<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.07.16 : 13:56
 */

namespace modules\breadcrumbs\models;

use system\models\Model;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Breadcrumbs
 * @package modules\breadcrumbs\models
 */
class Breadcrumbs extends Model
{
    /**
     * @param $id
     * @return array
     * @throws \system\core\exceptions\Exception
     */
    public function get($id, $home = true)
    {
        $items = [];
        $home_id = Settings::getInstance()->get('home_id');

        if($home && $id != $home_id){
            $items[] = $this->getItem($home_id);
        }

        if($id == $home_id){
            return $items;
        }

        $item = $this->getItem($id);

        if($item['parent_id'] > 0) {
            $items = array_merge($items, $this->get($item['parent_id'], false));
        } else {
            $categories_id = $this->getRelations($item['id'], 1);
            if($categories_id > 0){
                $_item = $this->getItem($categories_id);

                if($_item['parent_id'] > 0) {
                    $items = array_merge($items, $this->get($_item['parent_id'], false));
                    $items[] = $_item;
                }
            } else {
                $categories_id = $this->getRelations($item['id'], 0);
                if($categories_id > 0){
                    $_item = $this->getItem($categories_id);
                    $items[] = $_item;
                    if($_item['parent_id'] > 0) {
                        $items = array_merge($items, $this->get($_item['parent_id'], false));
                    }
                }
            }
        }

        $items[] = $item;
        return $items;
    }

    private function getItem($id)
    {
        return self::$db->select("
            select c.id, c.parent_id, i.name, i.title
            from __content c
            join __content_info i on i.content_id = c.id and i.languages_id = '{$this->languages_id}'
            where c.id='{$id}'
            limit 1
        ")->row();
    }


    private function getRelations($content_id, $is_main = 0)
    {
        return self::$db
            ->select("select categories_id as id from __content_relationship where content_id={$content_id} and is_main = {$is_main} limit 1")
            ->row('id');
    }
}