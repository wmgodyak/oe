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
        $r = self::$db->select("select * from __settings")->all();
        $res = [];
        foreach ($r as $item) {
            $res[$item['block']][$item['id']] = $item;
        }
        return $res;
    }

    public function update()
    {
        $settings = $this->request->post('settings');
        foreach ($settings as $name=>$value) {
            self::$db->update("__settings", ['value' => $value], "name='{$name}' limit 1");
        }

        $this->updateRobotsTxt($settings);
    }

    private function updateRobotsTxt($settings)
    {
        if(!isset($settings['robots_index_sample'])) return;
        if($settings['site_index'] == 1){
            $text = $settings['robots_index_sample'];
            $text = str_replace(['{app}','{appurl}'],[APP, APPURL], $text);
        } else{
            $text = $settings['robots_no_index_sample'];
        }

        file_put_contents(DOCROOT . 'robots.txt', $text);
    }

    public function getVersion()
    {
        return self::$db->query('select version()')->fetchColumn();
    }
}