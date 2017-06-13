<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:24
 */


namespace modules\catalog\models\backend;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Prices
 * @package modules\shop\models\admin
 */
class ProductsPrices extends Model
{
    /**
     * @param $product_id
     * @param $group_id
     * @param $price
     * @return bool|string
     */
    public function create($product_id, $group_id, $price)
    {
        return $this->createRow
        (
            "__products_prices",
            ['product_id' => $product_id, 'group_id' => $group_id, 'price' => $price]
        );
    }

    /**
     * @param $product_id
     * @param $group_id
     * @param $price
     * @return bool|string
     * @throws \system\core\exceptions\Exception
     */
    public function update($product_id, $group_id, $price)
    {
        $old = self::$db
            ->select("select id, price_old from __products_prices where product_id={$product_id} and group_id={$group_id} limit 1")
            ->row();

        if(empty($old)){
            return $this->createRow
            (
                "__products_prices",
                ['product_id' => $product_id, 'group_id' => $group_id, 'price' => $price, 'price_old' => $old['price_old']]
            );
        }

        return $this->updateRow
        (
            '__products_prices',
            $old['id'],
            ['price' => $price, 'price_old' => $old['price_old']]
        );
    }

    /**
     * @param $product_id
     * @return array
     */
    public function get($product_id, $currency = null, $main_currency = null)
    {
        if($currency){
            $r = self::$db->select("
                    select pp.group_id, ROUND( CASE
                        WHEN c.currency_id = {$currency['id']} THEN pp.price
                        WHEN c.currency_id <> {$currency['id']} and c.currency_id = {$main_currency['id']} THEN pp.price * {$currency['rate']}
                        WHEN c.currency_id <> {$currency['id']} and c.currency_id <> {$main_currency['id']} THEN pp.price / cu.rate * {$currency['rate']}
                        END, 2 ) as price
                    from __products_prices pp
                    join __content c on c.id={$product_id}
                    join __currency cu on cu.id = c.currency_id
                    where pp.product_id={$product_id}
            ")->all();
        } else {
            $r = self::$db->select("select group_id, price from __products_prices where product_id={$product_id}")->all();
        }

        $res = [];
        foreach ($r as $item) {
            $res[$item['group_id']] = $item['price'];
        }
        return $res;
    }

    /**
     * @param $product_id
     * @param $group_id
     * @return array|mixed
     */
    public function getByGroupId($product_id, $group_id)
    {
        return self::$db
            ->select("select price from __products_prices where product_id={$product_id} and group_id={$group_id} limit 1")
            ->row('price');
    }

    public function getContentData($id)
    {
        return self::$db->select("select * from __content where id={$id} limit 1")->row();
    }

    public function getProductCurrency($products_id)
    {
        return self::$db->select("
          select cy.id, cy.symbol
          from __content co
          join __currency cy on cy.id=co.currency_id
          where co.id={$products_id} limit 1
          ")->row();
    }
}