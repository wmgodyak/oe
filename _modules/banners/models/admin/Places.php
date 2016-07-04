<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 17:52
 */

namespace modules\banners\models\admin;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Places
 * @package modules\banners\models\admin
 */
class Places extends Model
{
    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');

        $id = $this->createRow('__banners_places', $data);

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $s = $this->updateRow('__banners_places', $id, $data);
        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__banners_places', " id={$id} limit 1");
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __banners_places where id={$id}")->row($key);
    }

    public static function get()
    {
        return self::$db->select("select id, name, code from __banners_places order by id asc")->all();
    }


}