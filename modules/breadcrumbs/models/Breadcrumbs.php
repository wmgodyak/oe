<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.07.16 : 13:56
 */

namespace modules\breadcrumbs\models;

use system\models\Model;

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
    public function get($id)
    {
        $items = [];

        $item = self::$db->select("
            select c.id, c.parent_id, i.name, i.title
            from __content c
            join __content_info i on i.content_id = c.id and i.languages_id = '{$this->languages_id}'
            where c.id='{$id}'
            limit 1
        ")->row();

        if($item['parent_id'] > 0) {
            $items = array_merge($items, $this->get($item['parent_id']));
        }

        $items[] = $item;

        return $items;
    }
}