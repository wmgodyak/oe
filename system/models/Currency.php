<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 16:30
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class Currency
 * @package system\models
 */
class Currency extends Model
{
    /**
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get()
    {
        return self::$db->select("select * from __currency order by is_main desc")->all();
    }

    /**
     * @param $code
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getIdByCode($code)
    {
        return self::$db->select("select id from __currency where code = '$code' limit 1")->row('id');
    }
}