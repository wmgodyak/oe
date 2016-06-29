<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 16:30
 */

namespace system\models;

defined("CPATH") or die();

class Currency extends Model
{
    public function get()
    {
        return self::$db->select("select * from __currency order by is_main desc")->all();
    }
}