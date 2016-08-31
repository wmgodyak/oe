<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 15:57
 */

namespace modules\order\models\admin;

defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\models\admin
 */
class Order extends \modules\order\models\Order
{
    public $products;

    public function __construct()
    {
        parent::__construct();

        $this->products = new OrdersProducts();
    }

    /**
     * @param $manager
     * @return bool|string
     */
    public function createBlank($manager)
    {
        self::$db->delete('__orders', "status_id=1 and manager_id={$manager['id']}");
        $c = $this->currency->getOnSiteMeta();
        return $this->createRow
        (
            '__orders',
            [
                'manager_id' => $manager['id'],
                'oid'        => date('ymd-hmsi-'.$manager['id']),
                'languages_id' => $this->languages_id,
                'currency_id' => $c['id'],
                'currency_rate' => $c['rate']
            ]
        );
    }

    /**
     * @param $id
     * @param $manager_id
     * @return bool
     */
    public function delete($id, $manager_id)
    {
       return $this->status->change($id, 4, $manager_id);
    }

    public function assignToManager($id, $manager_id)
    {

    }

    public function getNewCount()
    {
        return self::$db
            ->select("
                select count(o.id) as t
                from __orders_status s
                join __orders o on o.status_id=s.id
                where s.is_main=1")
            ->row('t');
    }

}