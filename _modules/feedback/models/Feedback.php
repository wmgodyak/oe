<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 16:42
 */

namespace modules\feedback\models;

use system\models\Model;

defined("CPATH") or die();

class Feedback extends Model
{
    public function create($data)
    {
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        return parent::createRow('__feedbacks', $data);
    }
}