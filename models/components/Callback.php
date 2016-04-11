<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 11.04.16 : 10:14
 */

namespace models\components;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class Callback
 * @package models\components
 */
class Callback extends Model
{
    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        return $this->createRow('callbacks', $data);
    }
}