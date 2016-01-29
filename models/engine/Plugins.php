<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 14:02
 */

namespace models\engine;

use helpers\PHPDocReader;
use models\core\Model;

defined("CPATH") or die();

class Plugins extends Model
{
    public function create($data, $components)
    {
        $data['controller'] = lcfirst($data['controller']);
        $plugins_id = self::$db->insert('plugins', $data);
        if($plugins_id > 0){
            foreach ($components as $k=>$components_id) {
                PluginsComponents::create($plugins_id, $components_id);
            }
        }

        return $plugins_id;
    }
    /**
     * @param $controller
     * @return bool
     */
    public function isInstalled($controller)
    {
        $controller = lcfirst($controller);
        return self::$db->select("select id from plugins where controller = '{$controller}' limit 1")->row('id') > 0;
    }

    /**
     * @param $controller
     * @param string $key
     * @return array|mixed
     */
    public function data($controller, $key = '*')
    {
        return self::$db->select("select {$key} from plugins where controller = '{$controller}' limit 1")->row($key);
    }


    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getDataByID($id, $key = '*')
    {
        return self::$db->select("select {$key} from plugins where id={$id} limit 1")->row($key);
    }



    /**
     * @param $id
     * @return bool
     */
    public function is($id)
    {
        return self::$db->select("select id from plugins where id = '{$id}' limit 1")->row('id') > 0;
    }


    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return self::$db->update('plugins', ['published' => 1], "id= '{$id}' limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return self::$db->update('plugins', ['published' => 0], "id= '{$id}' limit 1");
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return self::$db->delete('plugins', " id={$id} limit 1");
    }

    /**
     * @param $id
     * @param $data
     * @param $components
     * @return bool
     */
    public function update($id, $data, $components)
    {
        $in = PluginsComponents::getComponents($id);
        foreach ($components as $i=>$components_id) {
            if(in_array($components_id, $in)){
                $k = array_search($components_id, $in);
                unset($k); continue;
            }
            PluginsComponents::create($id, $components_id);
        }
        if(!empty($in)){
            foreach ($in as $i=>$components_id) {
                PluginsComponents::delete($id, $components_id);
            }
        }
        return self::$db->update('plugins', $data, "id = '{$id}' limit 1");
    }

    public function getComponents()
    {
        $res = [];
        foreach (self::$db->select("select id, controller from components where published=1")->all() as $item) {

            $row = PHPDocReader::getMeta('controllers\engine\\' . ucfirst($item['controller']));
            if(!isset($row['name'])) continue;

            $item['name'] = $row['name'];
            $res[] = $item;
        }
        return $res;
    }
}