<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\delivery\models;

use system\models\Languages;
use system\models\Model;

class Delivery extends Model
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from __delivery where id={$id}")->row($key);

        if($key != '*') return $data;

        $languages = new Languages();

        foreach ($languages->get() as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select name, description from __delivery_info where delivery_id={$id} and languages_id={$language['id']} limit 1")
                ->row();
        }
        return $data;
    }

    public function getSettings($module)
    {
        $s = self::$db->select("select settings from __delivery where module='{$module}' limit 1 ")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }

    public function get()
    {
        return self::$db
            ->select("select d.id, d.module, d.free_from,d.price, i.name
                      from __delivery d
                      join __delivery_info i on i.delivery_id=d.id and i.languages_id={$this->languages_id}
                      where d.published=1
                      order by i.name asc
                      ")
            ->all();
    }
}