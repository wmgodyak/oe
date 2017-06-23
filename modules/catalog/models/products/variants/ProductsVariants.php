<?php

namespace modules\catalog\models\products\variants;

use system\core\Session;
use system\models\Model;

/**
 * Class ProductsVariants
 * @package modules\catalog\models\products\variants
 */
class ProductsVariants extends Model
{
    private $currency;

    public function __construct()
    {
        parent::__construct();

        $this->currency = Session::get('currency');
    }

    /**
     * @param $content_id
     * @param $group_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id, $group_id)
    {
        $variants = self::$db
            ->select("
              select v.id, v.in_stock, v.img, p.currency_id,
               ROUND( CASE
                WHEN p.currency_id = {$this->currency['site']['id']} THEN vp.price
                WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id = {$this->currency['main']['id']} THEN vp.price * {$this->currency['site']['rate']}
                WHEN p.currency_id <> {$this->currency['site']['id']} and p.currency_id <> {$this->currency['main']['id']} THEN vp.price / cu.rate * {$this->currency['site']['rate']}
               END, 2 ) as price
              from __products_variants v
              join __products p on p.content_id = v.content_id
              join __currency cu on cu.id = p.currency_id
              join __products_variants_prices vp on
                vp.variants_id=v.id and vp.content_id={$content_id} and vp.group_id = {$group_id}
              where v.content_id={$content_id}
            ")
            ->all();

        foreach ($variants as $k=>$variant) {
            $variants[$k]['name'] = $this->makeName($variant['id']);
        }

        return $variants;
    }

    /**
     * @param $content_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function total($content_id)
    {
        return self::$db
            ->select("
              select count(id) as t
              from __products_variants
              where content_id = '{$content_id}'
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
                      join __features_info fi on fi.features_id=vf.values_id and fi.languages_id='{$this->languages_id}'
                      where vf.variants_id={$variants_id}
                      order by vf.id asc
                    ")
            ->all('name');

        return implode('/', $r);
    }
}