<?php

namespace modules\catalog\models\products;

use system\models\Frontend;

/**
 * Class Variants
 * @package modules\catalog\models\products
 */
class Variants extends Frontend
{
    private $product_id;
    private $group_id;
    private $currency;

    public function __construct($product_id, $group_id, $currency)
    {
        parent::__construct();

        $this->product_id = $product_id;
        $this->group_id   = $group_id;
        $this->currency   = $currency;
    }

    /**
     * @return mixed
     */
    public function get()
    {
        $variants = self::$db
            ->select("
              select v.id, v.in_stock, v.sku, v.img, cu.symbol, p.currency_id,
               ROUND( CASE
                WHEN p.currency_id = {$this->currency['site']['id']} THEN vp.price
                WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id = {$this->currency['main']['id']} THEN vp.price * {$this->currency['site']['rate']}
                WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id <> {$this->currency['main']['id']} THEN vp.price / cu.rate * {$this->currency['site']['rate']}
               END, 2 ) as price
              from __products_variants v
              join __products p on p.content_id = v.content_id
              join __currency cu on cu.id = p.currency_id
              join __products_variants_prices vp on
                vp.variants_id=v.id and vp.content_id={$this->product_id} and vp.group_id = {$this->group_id}
              where v.content_id={$this->product_id}
            ")
            ->all();

        foreach ($variants as $k=>$variant) {
            $variants[$k]['name'] = $this->makeName($variant['id']);
        }

        return $variants;
    }

    /**
     * @return array|mixed
     */
    public function total()
    {
        return self::$db
            ->select("
              select count(id) as t
              from __products_variants
              where content_id = '{$this->product_id}'
            ")
            ->row('t');
    }

    /**
     * @param $variants_id
     * @return string
     * @throws \system\core\exceptions\Exception
     */
    public function makeName($variants_id)
    {
        $r = self::$db
            ->select("select fi.name
                      from __products_variants_features vf
                      join __features_info fi on fi.features_id=vf.values_id and fi.languages_id='{$this->languages->id}'
                      where vf.variants_id={$variants_id}
                      order by vf.id asc
                    ")
            ->all('name');

        return implode('/', $r);
    }

}