<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:24
 */


namespace modules\shop\models\admin;

use system\models\Model;

defined("CPATH") or die();

class Prices extends Model
{
    /**
     * @param $content_id
     * @param $group_id
     * @param $price
     * @return bool|string
     * @throws \system\core\exceptions\Exception
     */
    public function update($content_id, $group_id, $price)
    {
        $old = self::$db
            ->select("select id, price_old from __products_prices where content_id={$content_id} and group_id={$group_id} limit 1")
            ->row();

        if(empty($old)){
            return $this->createRow
            (
                "__products_prices",
                ['content_id' => $content_id, 'group_id' => $group_id, 'price' => $price, 'price_old' => $old['price_old']]
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
     * @param $content_id
     * @return array
     */
    public function get($content_id)
    {
        $r = self::$db->select("select group_id, price from __products_prices where content_id={$content_id}")->all();
        $res = [];
        foreach ($r as $item) {
            $res[$item['group_id']] = $item['price'];
        }
        return $res;
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