<?php

namespace modules\shop\models\products\variants;

use system\models\Currency;
use system\models\Model;

class ProductsVariantsPrices extends Model
{
    private $currency;
    public function __construct()
    {
        parent::__construct();

        $this->currency = new Currency();
    }

    public function getPrice($variants_id, $group_id)
    {
        $cu_on_site = $this->currency->getOnSiteMeta();
        $cu_main    = $this->currency->getMainMeta();
        return self::$db
            ->select("
              select ROUND( CASE
                WHEN c.currency_id = {$cu_on_site['id']} THEN vp.price
                WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN vp.price * {$cu_on_site['rate']}
                WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN vp.price / cu.rate * {$cu_on_site['rate']}
                END, 2 ) as price
              from __products_variants_prices vp
              join __content c on c.id=vp.content_id
              join __currency cu on cu.id = c.currency_id
              where vp.variants_id={$variants_id} and vp.group_id='{$group_id}'
               limit 1")
            ->row('price');
    }
}