<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 18:08
 */

namespace modules\order\models\admin;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class OrdersStatus
 * @package modules\order\models\admin
 */
class OrdersStatus extends Model
{
    private $history;

    public function __construct()
    {
        parent::__construct();

        $this->history = new StatusHistory();
    }

    /**
     * @param $orders_id
     * @param $status_id
     * @param null $manager_id
     * @param null $comment
     * @return bool
     */
    public function change($orders_id, $status_id, $manager_id = null, $comment = null)
    {
//        $this->beginTransaction();

        $this->updateRow('__orders', $orders_id, ['status_id' => $status_id]);

        $this->history->create($orders_id, $status_id, $manager_id, $comment);

//        if($this->hasError()){
//            $this->rollback();
//
//            return false;
//        }

//        $this->commit();

        return true;
    }
}