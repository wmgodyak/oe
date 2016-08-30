<?php

namespace modules\shop\models\products;

use system\models\Currency;
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
              select ROUND( CASE
                WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
                WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
                WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
                END, 2 ) as price
              from __products_prices pp
              join __content c on c.id={$products_id}
              join __currency cu on cu.id = c.currency_id
              where pp.content_id='{$products_id}' and pp.group_id='{$group_id}'
               limit 1")
            ->row('price');
    }
}