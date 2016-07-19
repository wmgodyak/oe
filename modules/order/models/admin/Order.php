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
    private $status;

    public function __construct()
    {
        parent::__construct();

        $this->status = new OrdersStatus();
    }

    /**
     * @param $id
     * @param $manager_id
     * @return bool
     */
    public function delete($id, $manager_id)
    {
       return $this->status->change($id, 2, $manager_id);
    }
}