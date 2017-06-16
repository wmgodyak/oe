<?php

namespace modules\catalog\models;

use system\core\DB;

class Product
{
    public $id;

    private $language;
    public $features;
    public $currency;

    public function __construct($id, $language, $currency, $group_id)
    {
        $this->id       = $id;
        $this->language = $language;
        $this->currency = $currency['site'];

        $this->build($currency, $group_id);
    }

    private function build($currency, $group_id)
    {
        $q = "select
            c.id,
            p.sku, p.in_stock,
          ci.name, ci.title, ci.description,
          crm.categories_id, 
            ROUND (CASE
              WHEN p.currency_id = {$currency['site']['id']} THEN pp.price
              WHEN p.currency_id <> {$currency['site']['id']} and p.currency_id = {$currency['main']['id']} THEN pp.price * {$currency['site']['rate']}
              WHEN p.currency_id <> {$currency['site']['id']} and p.currency_id <> {$currency['main']['id']} THEN pp.price / cu.rate * {$currency['site']['rate']}
            END, 2) as price,
            ROUND ( CASE
              WHEN p.currency_id = {$currency['site']['id']} THEN pp.price_old
              WHEN p.currency_id <> {$currency['site']['id']} and p.currency_id = {$currency['main']['id']} THEN pp.price_old * {$currency['site']['rate']}
              WHEN p.currency_id <> {$currency['site']['id']} and p.currency_id <> {$currency['main']['id']} THEN pp.price_old / cu.rate * {$currency['site']['rate']}
            END, 2) as price_old,
           pp.price as pp_rice,
           IF(p.in_stock = 1, 1, 0) as available
          from __content c
          join __products p on p.content_id=c.id
          join __content_relationship crm on crm.content_id=c.id and crm.is_main = 1
          join __products_prices pp on pp.product_id=c.id and pp.group_id={$group_id}
          join __currency cu on cu.id = p.currency_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->language->id}
          where c.id={$this->id}
          limit 1
          ";

        $row = DB::getInstance()
            ->select($q)
            ->row();

        $row['price'] = round($row['price'], 2);
        $row['price_old'] = round($row['price_old'], 2);

        foreach ($row as $k=>$v) {
            $this->{$k} = $v;
        }

        $this->features = new ProductFeatures($this->id, $row['categories_id'], $this->language);

//        if(!empty($products)){
//            foreach ($products as $k => $product) {
//                $products[$k]['features'] = $this->features->get($product['categories_id'], $product['id']);
//                if($product['has_variants']){
//                    $products[$k]['variants'] = $this->variants->get($product['id'], $this->group_id);
//                }
//            }
//        }

//        return $products;
    }
}