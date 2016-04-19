<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 10:08
 */

namespace models\app;

use models\core\Model;

defined("CPATH") or die();

class Languages extends Model
{
    /**
     * @param string $key
     * @return array|mixed
     */
    public function getDefault($key = '*')
    {
        return self::$db->select("select {$key} from __languages where is_main = 1 limit 1 ")->row($key);
    }

    /**
     * @return mixed
     */
    public function getAll()
    {
        return self::$db->select("select * from __languages")->all();
    }

    /**
     * @param $code
     * @return array|mixed
     */
    public function getIdByCode($code)
    {
        return self::$db->select("select id from __languages where code = '{$code}' limit 1")->row('id');
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __languages where id={$id} limit 1")->row($key);
    }


}