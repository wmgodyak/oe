<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 15:57
 */

namespace modules\order\models\admin;

use system\models\Currency;

defined("CPATH") or die();

/**
 * Class OrdersProducts
 * @package modules\order\models\admin
 */
class OrdersProducts extends \modules\order\models\OrdersProducts
{
    private $currency;
    public function __construct()
    {
        parent::__construct();

        $this->currency = new Currency();
    }

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

    public function get($orders_id)
    {
        return self::$db->select("
          select c.id, ci.name, op.quantity, op.price
          from __orders_products op
          join __content c on c.id = op.products_id
          join __currency cu on cu.id = c.currency_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
          where op.orders_id='{$orders_id}'
          ")->all();
    }

    /**
     * @param $q
     * @param $group_id
     * @param $currency_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function search($q, $group_id, $currency_id)
    {
        $q = implode(' and ', $q);
        $cu_on_site = $this->currency->getMeta($currency_id);
        $cu_main = $this->currency->getMainMeta();

        $items =  self::$db->select("
          select SQL_CALC_FOUND_ROWS  c.id, c.isfolder, ci.name, ci.title, c.in_stock, c.has_variants,
           (CASE
            WHEN c.currency_id = {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price
            WHEN c.currency_id = {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}

            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * '{$cu_on_site['rate']}'
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN 1
            END ) as price,
           pp.price as pprice, '{$cu_on_site['symbol']}' as symbol
          from __content c
          join __products_prices pp on pp.content_id=c.id and pp.group_id='{$group_id}'
          join __currency cu on cu.id = c.currency_id
          join __content_types ct on ct.type = 'product' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
          where {$q} and c.status ='published'
          limit 30
          ")->all();

        return $items;
    }
}