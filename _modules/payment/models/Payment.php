<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\payment\models;

use system\models\Languages;
use system\models\Model;

class Payment extends Model
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from __payment where id={$id}")->row($key);

        if($key != '*') return $data;

        $languages = new Languages();

        foreach ($languages->get() as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select name, description from __payment_info where payment_id={$id} and languages_id={$language['id']} limit 1")
                ->row();
        }
        return $data;
    }

    public function getSettings($module)
    {
        $s = self::$db->select("select settings from __payment where module='{$module}' limit 1 ")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }
}