<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 06.04.16 : 16:40
 */

namespace models\engine\plugins;

use models\core\Model;
use models\engine\CustomersGroup;

defined("CPATH") or die();

class ProductsVariantsPrices extends Model
{
    /**
     * @param $content_id
     * @param $variants_id
     * @param $group_id
     * @param $price
     * @return bool|string
     */
    public function create($content_id, $variants_id, $group_id, $price)
    {
        return self::$db->insert
        (
            'products_variants_prices',
            ['content_id' => $content_id, 'variants_id' => $variants_id, 'group_id' => $group_id, 'price'=> $price]
        );
    }

    public function getPrice($variants_id, $group_id)
    {
        return self::$db->select("
          select price
          from products_variants_prices
          where variants_id={$variants_id} and group_id={$group_id}
          limit 1
          ")->row('price');
    }

    public function set($content_id, $variants_id, $group_id, $price)
    {
        $aid = self::$db
            ->select("select id from products_variants_prices where variants_id={$variants_id} and group_id={$group_id}")
            ->row('id');

        if(empty($aid)){
            $this->create($content_id, $variants_id, $group_id, $price);
            return true;
        }

        $this->updateRow('products_variants_prices', $aid, ['price' => $price]);
        return true;
    }

    /**
     * @param $content_id
     * @param $variants_id
     * @return array
     */
    public function get($content_id, $variants_id)
    {
        $customersGroup = new CustomersGroup();
        $groups = $customersGroup->get();

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
            ->select("select price from products_prices where content_id={$content_id} and group_id={$group_id} limit 1")
            ->row('price');
    }
}