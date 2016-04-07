<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 16:26
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class BannersPlaces
 * @package models\engine
 */
class BannersPlaces extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from banners_places where id={$id}")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');

        $id = $this->createRow('banners_places', $data);

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $s = $this->updateRow('banners_places', $id, $data);
        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('banners_places', " id={$id} limit 1");
    }

    public static function get()
    {
        return self::$db->select("select id, name, code from banners_places order by is_main desc, id asc")->all();
    }

    /**
     * @param $banners_places_id
     * @return array|mixed
     */
    public static function getTotalBanners($banners_places_id)
    {
        return self::$db
            ->select("select count(id) as t from banners where banners_places_id={$banners_places_id}")
            ->row('t');
    }
}