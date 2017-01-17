<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.10.16 : 10:10
 */

namespace system\components\nav\models;

use system\models\Backend;

defined("CPATH") or die();

/**
 * Class NavItemsInfo
 * @package system\components\nav\models
 */
class NavItemsInfo extends Backend
{
    /**
     * @param $nav_items_id
     * @param $languages_id
     * @param $data
     * @return bool|string
     */
    public function create($nav_items_id, $languages_id, $data)
    {
        $data['nav_items_id'] = $nav_items_id;
        $data['languages_id'] = $languages_id;
        return parent::createRow('__nav_items_info', $data);
    }

    /**
     * @param $nav_items_id
     * @param $languages_id
     * @param $data
     * @return bool|null|string
     */
    public function update($nav_items_id, $languages_id, $data)
    {
        if(empty($data['name'])) return null;

        $aid =
            self::$db
                ->select("select id from __nav_items_info where nav_items_id={$nav_items_id} and languages_id={$languages_id} limit 1")
            ->row('id');

        if($aid > 0){
            return parent::updateRow('__nav_items_info', $aid, $data);
        }

        return $this->create($nav_items_id, $languages_id, $data);
    }

    /**
     * @param $nav_items_id
     * @return array
     */
    public function getData($nav_items_id)
    {
        $r = self::$db->select("select * from __nav_items_info where nav_items_id={$nav_items_id}")->all();

        $res = [];
        foreach ($r as $row) {
            $res[$row['languages_id']] = $row;
        }

        return $res;
    }
}