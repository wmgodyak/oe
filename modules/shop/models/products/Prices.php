<?php

namespace modules\shop\models\products;

use system\models\Model;

/**
 * Class Prices
 * @package modules\shop\models\products
 */
class Prices extends Model
{
    /**
     * @param $products_id
     * @param $group_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($products_id, $group_id)
    {
        return self::$db
            ->select("select price from __products_prices where content_id={$products_id} and group_id={$group_id} limit 1")
            ->row('price');
    }
}