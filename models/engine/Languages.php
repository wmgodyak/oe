<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 16:26
 */

namespace models\engine;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class Languages
 * @package models\engine
 */
class Languages extends Model
{
    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id)
    {
        return self::$db->select("select * from languages where id={$id}")->row();
    }

    /**
     * @param string $key
     * @return array|mixed
     */
    public function getDefault($key='*')
    {
        return self::$db->select("select {$key} from languages where is_main=1")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        if($data['is_main'] == 1){
            self::$db->update('languages', ['is_main' => 0]);
        }
        return self::$db->insert('languages', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        if($data['is_main'] == 1){
            self::$db->update('languages', ['is_main' => 0]);
        }
        $s = self::$db->update('languages', $data, " id={$id} limit 1");
        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('languages', " id={$id} limit 1");
    }

    public function get()
    {
        return self::$db->select("select * from languages order by is_main desc, name asc")->all();
    }

}