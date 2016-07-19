<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 15:57
 */

namespace modules\order\models\admin;

defined("CPATH") or die();

/**
 * Class OrdersProducts
 * @package modules\order\models\admin
 */
class OrdersProducts extends \modules\order\models\OrdersProducts
{
    /**
     * @param $orders_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function amount($orders_id)
    {
        return self::$db
            ->select("select SUM(quantity * price) as t from __orders_products where orders_id = {$orders_id}")
            ->row('t');
    }
}