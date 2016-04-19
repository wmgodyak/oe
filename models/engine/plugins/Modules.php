<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.03.16 : 17:41
 */

namespace models\engine\plugins;

use models\Engine;

defined("CPATH") or die();

class Modules extends Engine
{
    public function get()
    {
        return self::$db->select("select id, controller from __modules")->all();
    }

    public function getPageSettings($id)
    {
        $s = self::$db->select("select settings from __content where id={$id} limit 1")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }
}