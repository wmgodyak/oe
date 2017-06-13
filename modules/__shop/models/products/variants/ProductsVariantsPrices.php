<?php

namespace modules\shop\models\products\variants;

use system\core\Session;
use system\models\Model;

class ProductsVariantsPrices extends Model
{
    private $currency;
    public function __construct()
    {
        parent::__construct();

        $this->currency = Session::get('currency');
    }

    public function getPrice($variants_id, $group_id)
    {
        return self::$db
            ->select("
              select ROUND( CASE
                WHEN c.currency_id = {$this->currency['site']['id']} THEN vp.price
                WHEN c.currency_id <> {$this->currency['site']['id']} and c.currency_id = {$this->currency['main']['id']} THEN vp.price * {$this->currency['site']['rate']}
                WHEN c.currency_id <> {$this->currency['site']['id']} and c.currency_id <> {$this->currency['main']['id']} THEN vp.price / cu.rate * {$this->currency['site']['rate']}
                END, 2 ) as price
              from __products_variants_prices vp
              join __products c on c.id=vp.content_id
              join __currency cu on cu.id = c.currency_id
              where vp.variants_id={$variants_id} and vp.group_id='{$group_id}'
               limit 1")
            ->row('price');
    }
}