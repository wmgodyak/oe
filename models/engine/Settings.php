<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 17.03.16 : 9:42
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

class Settings extends Engine
{
    public function get()
    {
        $r = self::$db->select("select * from settings")->all();
        $res = [];
        foreach ($r as $item) {
            $res[$item['group']][$item['id']] = $item;
        }
        return $res;
    }

    public function update()
    {
        $settings = $this->request->post('settings');
        foreach ($settings as $name=>$value) {
            self::$db->update("settings", ['value' => $value], "name='{$name}' limit 1");
        }
    }
}