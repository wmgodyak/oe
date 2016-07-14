<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 17:05
 */

namespace modules\order\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\models
 */
class Order extends Model
{
    public function create($data)
    {
        return $this->createRow('__orders', $data);
    }
}