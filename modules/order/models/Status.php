<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 18:13
 */

namespace modules\order\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Status
 * @package modules\order\models
 */
class Status extends Model
{
    /**
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getMainId()
    {
        return self::$db->select("select id from __orders_status where is_main = 1 limit 1")->row('id');
    }
}