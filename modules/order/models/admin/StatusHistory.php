<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 19.07.16 : 17:59
 */

namespace modules\order\models\admin;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class StatusHistory
 * @package modules\order\models\admin
 */
class StatusHistory extends Model
{
    /**
     * @param $orders_id
     * @param $status_id
     * @param null $manager_id
     * @param null $comment
     * @return bool|string
     */
    public function create($orders_id, $status_id, $manager_id = null, $comment = null)
    {
        return $this->createRow
        (
            '__orders_status_history',
            [
                'orders_id'  => $orders_id,
                'status_id'  => $status_id,
                'manager_id' => $manager_id,
                'comment'    => $comment
            ]
        );
    }
}