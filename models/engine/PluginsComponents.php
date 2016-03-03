<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 15:20
 */

namespace models\engine;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class PluginsComponents
 * @package models\engine
 */
class PluginsComponents extends Model
{
    /**
     * @param $plugins_id
     * @param $components_id
     * @return bool|string
     */
    public static function create($plugins_id, $components_id)
    {
        return self::$db->insert('plugins_components', ['plugins_id' => $plugins_id, 'components_id' => $components_id]);
    }

    /**
     * @param $plugins_id
     * @param $components_id
     * @return int
     */
    public static function delete($plugins_id, $components_id)
    {
        return self::$db->delete("plugins_components", " plugins_id={$plugins_id} and components_id={$components_id} limit 1");
    }

    public static function getID($plugins_id, $components_id)
    {
        return self::$db
            ->select("select id from plugins_components where  plugins_id={$plugins_id} and components_id={$components_id} limit 1")
            ->row('id');
    }

    /**
     * @param $plugins_id
     * @return array
     */
    public static function getComponents($plugins_id)
    {
        $res = [];
        foreach (self::$db->select("select components_id from plugins_components where plugins_id={$plugins_id} ")->all() as $item) {
            $res[$item['components_id']] = $item['components_id'];
        }
        return $res;
    }
}