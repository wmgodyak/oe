<?php

namespace modules\catalog\models\backend\products\variants;
use system\models\UsersGroup;

/**
 * Class ProductsVariantsFeatures
 * @package modules\catalog\models\backend\products\variants
 */
class ProductsVariantsPrices extends \modules\catalog\models\products\variants\ProductsVariantsPrices
{
    /**
     * @param $variants_id
     * @param $content_id
     * @param $group_id
     * @param $price
     * @return bool|string
     */
    public function create($variants_id, $content_id, $group_id, $price)
    {
        return $this->createRow
        (
            '__products_variants_prices',
            [
                'variants_id' => $variants_id,
                'content_id'  => $content_id,
                'group_id'    => $group_id,
                'price'       => $price
            ]
        );
    }
    /**
     * @param $content_id
     * @param $variants_id
     * @return array
     */
    public function get($content_id, $variants_id)
    {
        $customersGroup = new UsersGroup();
        $groups = $customersGroup->getItems(0);

        $res = [];
        foreach ($groups as $group) {
            $group['price'] = $this->getPrice($variants_id, $group['id']);
            if(empty($group['price'])){
                $group['price'] = $this->getGroupPrice($content_id, $group['id']);
            }
            $res[] = $group;
        }
        return $res;
    }

    /**
     * @param $content_id
     * @param $group_id
     * @return array|mixed
     */
    private function getGroupPrice($content_id, $group_id)
    {
        return self::$db
            ->select("select price from __products_prices where content_id={$content_id} and group_id={$group_id} limit 1")
            ->row('price');
    }

    /**
     * @param $variants_id
     * @param $group_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getPrice($variants_id, $group_id)
    {
        return self::$db->select("
          select price
          from __products_variants_prices
          where variants_id={$variants_id} and group_id={$group_id}
          limit 1
          ")->row('price');
    }

    /**
     * @param $content_id
     * @param $variants_id
     * @param $group_id
     * @param $price
     * @return bool
     * @throws \system\core\exceptions\Exception
     */
    public function set($content_id, $variants_id, $group_id, $price)
    {
        $aid = self::$db
            ->select("select id from __products_variants_prices where variants_id={$variants_id} and group_id={$group_id}")
            ->row('id');

        if(empty($aid)){
            $this->create($content_id, $variants_id, $group_id, $price);
            return true;
        }

        $this->updateRow('__products_variants_prices', $aid, ['price' => $price]);
        return true;
    }

}