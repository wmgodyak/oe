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
use modules\users\models\Users;
use system\models\Currency;


defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\models
 */
class Order extends Model
{
    protected $status;
    protected $users;
    protected $currency;
    public    $kits;

    public function __construct()
    {
        parent::__construct();

        $this->status = new OrdersStatus();
        $this->users  = new Users();
        $this->currency = new Currency();

        $this->kits = new OrdersKits();
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        return $this->createRow('__orders', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        $data['edited'] = $this->now();
        return $this->updateRow('__orders', $id, $data);
    }

    public function paid($id)
    {
        return $this->update($id, ['paid' => 1]);
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
//                $total += $orders[$k]['products'][$i]['amount'];
                if($product['variants_id'] > 0){
                    $orders[$k]['products'][$i]['variant_name']= $variants->makeName($product['variants_id']);
                }
            }

            $orders[$k]['kits'] = $this->kits->get($order['id']);

            $orders[$k]['amount'] = $this->amount($order['id']);
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

    public function amount($orders_id)
    {
        $s = self::$db->select("select sum(quantity * price) as t from __orders_products where orders_id='{$orders_id}'")
            ->row('t');

        $kits = self::$db->select("select id, quantity, kits_products_price
                                  from __orders_kits
                                  where orders_id='{$orders_id}'
        ")->all();

        foreach ($kits as $kit) {
            $kp = self::$db->select("select sum(price) as t from e_orders_kits_products where orders_kits_id={$kit['id']}")
                ->row('t');
            $s += $kit['quantity'] * ( $kit['kits_products_price'] + $kp ) ;
        }
        return $s;
    }


    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $order = $this->rowData('__orders', $id, $key);

        if($key != '*')
            return $order;

        $order['user'] = $this->users->getData($order['users_id']);

        return $order;
    }

    /**
     * @param $oid
     * @param string $key
     * @return array|mixed
     */
    public function getDataByOID($oid, $key = '*')
    {
        $order = self::$db->select("select {$key} from __orders where oid = '{$oid}' limit 1")->row($key);

        if($key != '*')
            return $order;

        $order['user'] = $this->users->getData($order['users_id']);

        return $order;
    }
}