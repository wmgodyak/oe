<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 17:22
 */

namespace system\components\settings\models;
use system\models\Model;

defined("CPATH") or die();

class Settings extends Model
{
    public function get()
    {
        $r = self::$db->select("select * from __settings where display=1")->all();
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
            \system\models\Settings::getInstance()->set($name, $value);
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