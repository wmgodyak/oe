<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.08.16 : 15:19
 */

namespace modules\order\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class OrdersKitsProducts
 * @package modules\order\models
 */
class OrdersKitsProducts extends Model
{
    /**
     * @param $orders_kits_id
     * @param $kits_products_id
     * @param $kits_products_kits_id
     * @param $kits_products_products_id
     * @param $price_original
     * @param $discount
     * @param $price
     * @return bool|string
     */
    public function create
    (
        $orders_kits_id,
        $kits_products_id,
        $kits_products_kits_id,
        $kits_products_products_id,
        $price_original,
        $discount,
        $price
    )
    {
        return $this->createRow
        (
            '__orders_kits_products',
            [
                'orders_kits_id'            => $orders_kits_id,
                'kits_products_id'          => $kits_products_id,
                'kits_products_kits_id'     => $kits_products_kits_id,
                'kits_products_products_id' => $kits_products_products_id,
                'price_original'            => $price_original,
                'discount'                  => $discount,
                'price'                     => $price
            ]
        );
    }

    public function get($orders_kits_id)
    {
        return self::$db
            ->select("
                  select kp.kits_products_products_id as id, c.sku, kp.price_original, kp.discount, kp.price, p.name
                  from __orders_kits_products kp
                  join __content c on c.id= kp.kits_products_products_id
                  join __content_info p on p.content_id = kp.kits_products_products_id and p.languages_id='{$this->languages_id}'
                  where kp.orders_kits_id = '{$orders_kits_id}'
                  ")
            ->all();
    }

}