<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 18:32
 */

namespace modules\order\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class OrdersProducts
 * @package modules\order\models
 */
class OrdersProducts extends Model
{
    /**
     * @param $orders_id
     * @param $products_id
     * @param $quantity
     * @param $price
     * @param $variants_id
     * @return bool|string
     */
    public function create($orders_id, $products_id, $quantity, $price, $variants_id)
    {
        return $this->createRow
        (
            '__orders_products',
            [
                'orders_id'   => $orders_id,
                'products_id' => $products_id,
                'quantity'    => $quantity,
                'price'       => $price,
                'variants_id' => $variants_id
            ]
        );
    }
}