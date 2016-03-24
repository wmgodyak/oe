<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 14:02
 */

namespace models\engine;

use models\core\Model;

defined("CPATH") or die();

class Modules extends Model
{
    public function create($data)
    {
        $modules_id = self::$db->insert('modules', $data);

        return $modules_id;
    }
    /**
     * @param $controller
     * @return bool
     */
    public function isInstalled($controller)
    {
        $controller = lcfirst($controller);
        return self::$db->select("select id from modules where controller = '{$controller}' limit 1")->row('id') > 0;
    }

    /**
     * @param $controller
     * @param string $key
     * @return array|mixed
     */
    public function data($controller, $key = '*')
    {
        return self::$db->select("select {$key} from modules where controller = '{$controller}' limit 1")->row($key);
    }


    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getDataByID($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from modules where id={$id} limit 1")->row($key);

        if($key != '*') return $data;

        return $data;
    }



    /**
     * @param $id
     * @return bool
     */
    public function is($id)
    {
        return self::$db->select("select id from modules where id = '{$id}' limit 1")->row('id') > 0;
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return self::$db->delete('modules', " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        return self::$db->update('modules', $data, "id = '{$id}' limit 1");
    }
}
