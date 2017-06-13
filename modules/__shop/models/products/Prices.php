<?php

namespace modules\shop\models\products;

use modules\currency\models\Currency;
use system\models\Model;

/**
 * Class Prices
 * @package modules\shop\models\products
 */
class Prices extends Model
{
    private $currency;
    public function __construct()
    {
        parent::__construct();

        $this->currency = new Currency();
    }

    /**
     * @param $products_id
     * @param $group_id
     * @param null $currency_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($products_id, $group_id, $currency_id = null)
    {
        if( ! $currency_id){
            $cu_on_site = $this->currency->getOnSiteMeta();
        } else {
            $cu_on_site = $this->currency->getMeta($currency_id);
        }

        $cu_main    = $this->currency->getMainMeta();

        return self::$db
            ->select("
              select CASE
                    WHEN p.currency_id = {$cu_on_site['id']} THEN pp.price
                    WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
                    WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
                END as price,
                CASE
                    WHEN p.currency_id = {$cu_on_site['id']} THEN pp.price_old
                    WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price_old * {$cu_on_site['rate']}
                    WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN pp.price_old / cu.rate * {$cu_on_site['rate']}
                END as price_old
              from __products_prices pp
              join __products p on p.content_id={$products_id}
              join __currency cu on cu.id = p.currency_id
              where pp.content_id='{$products_id}' and pp.group_id='{$group_id}'
               limit 1")
            ->row();
    }
}