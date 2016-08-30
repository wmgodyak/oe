<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.08.16 : 15:14
 */

namespace modules\order\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class OrdersKits
 * @package modules\order\models
 */
class OrdersKits extends Model
{
    public $products;

    public function __construct()
    {
        parent::__construct();

        $this->products = new OrdersKitsProducts();
    }

    /**
     * @param $orders_id
     * @param $kits_id
     * @param $kits_products_id
     * @param $kits_products_price
     * @param $quantity
     * @return bool|string
     */
    public function create($orders_id, $kits_id, $kits_products_id, $kits_products_price, $quantity)
    {
        return $this->createRow
        (
            '__orders_kits',
            [
                'orders_id'           => $orders_id,
                'kits_id'             => $kits_id,
                'kits_products_id'    => $kits_products_id,
                'kits_products_price' => $kits_products_price,
                'quantity'            => $quantity
            ]
        );
    }
}