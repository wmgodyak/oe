<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 17:05
 */

namespace modules\order\models;

use modules\order\models\admin\OrdersStatus;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\models
 */
class Order extends Model
{
    private $ordersStatus;

    public function __construct()
    {
        parent::__construct();

        $this->ordersStatus = new OrdersStatus();
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
//        $data['status_id'] = isset($data['status_id']) ? $data['status_id'] : 1;
        $id = $this->createRow('__orders', $data);
//        $this->ordersStatus->change($id, $data['status_id']);

        return $id;
    }

    /**
     * @param $users_id
     * @param int $start
     * @param int $num
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function history($users_id, $start = 0, $num = 5)
    {
        $variants = new \modules\shop\models\products\variants\ProductsVariants();

        $orders = self::$db
            ->select("
                select o.id,o.oid, o.created, osi.status, o.paid, o.status_id,o.payment_id
                from __orders o
                join __orders_status_info osi on osi.status_id=o.status_id and osi.languages_id={$this->languages_id}
                where o.users_id={$users_id}
                order by o.id desc
                limit {$start}, {$num}
              ")
            ->all();

        foreach ($orders as $k=>$order) {
            $total = 0;
            $orders[$k]['products'] =
                self::$db
                    ->select("
                        select op.products_id as id, i.name, op.variants_id, op.quantity, op.price
                        from __orders_products op
                        join __content_info i on i.content_id=op.products_id and i.languages_id={$this->languages_id}
                        where op.orders_id='{$order['id']}'
                    ")
                    ->all();

            foreach ($orders[$k]['products'] as $i=>$product) {
                $orders[$k]['products'][$i]['amount'] = $product['quantity'] * $product['price'];
                $total += $orders[$k]['products'][$i]['amount'];
                if($product['variants_id'] > 0){
                    $orders[$k]['products'][$i]['variant_name']= $variants->makeName($product['variants_id']);
                }
            }
            $orders[$k]['amount'] = $total;
        }

        return $orders;
    }

    public function total($users_id)
    {
        return self::$db
            ->select("
                select count(id) as t
                from __orders o
                where o.users_id={$users_id}
              ")
            ->row('t');
    }

}