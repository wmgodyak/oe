<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 15:57
 */

namespace modules\order\models\admin;


use modules\users\models\Users;

defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\models\admin
 */
class Order extends \modules\order\models\Order
{
    private $status;
    private $users;

    public function __construct()
    {
        parent::__construct();

        $this->status = new OrdersStatus();
        $this->users = new Users();
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

    public function assignToManager($id, $manager_id)
    {

    }

    public function update($id, $data)
    {
        return $this->updateRow('__orders', $id, $data);
    }
}