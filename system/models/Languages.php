<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 10.06.16 : 16:07
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class Languages
 * @package system\models
 */
class Languages extends Model
{
    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id, $key='*')
    {
        return self::$db->select("select * from __languages where id={$id}")->row($key);
    }

    /**
     * @param string $key
     * @return array|mixed
     */
    public function getDefault($key='*')
    {
        return self::$db->select("select {$key} from __languages where is_main=1")->row($key);
    }

    public function getDataByCode($code, $key= '*')
    {
        return self::$db->select("select * from __languages where code='{$code}'")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        if($data['is_main'] == 1){
            self::$db->update('__languages', ['is_main' => 0]);
        }

        return self::$db->insert('__languages', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        if($data['is_main'] == 1){
            self::$db->update('__languages', ['is_main' => 0]);
        }

        $s = self::$db->update('__languages', $data, " id={$id} limit 1");

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__languages', " id={$id} limit 1");
    }

    public function get()
    {
        return self::$db->select("select * from __languages order by is_main desc, name asc")->all();
    }

    public function total()
    {
        return self::$db->select("select count(id) as t from __languages")->row('t');
    }
}