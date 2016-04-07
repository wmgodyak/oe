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
 * Class Banners
 * @package models\engine
 */
class Banners extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $s = self::$db->select("select {$key} from banners where id={$id}")->row($key);
        $s['size'] = self::$db
            ->select("select width,height from banners_places where id={$s['banners_places_id']} limit 1")
            ->row();
        return $s;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        $data['skey'] = md5(base64_encode(time()));

        if(!empty($data['df'])) {
            $data['df'] = date('Y-m-d', strtotime($data['df']));
        }

        if(!empty($data['dt'])) {
            $data['dt'] = date('Y-m-d', strtotime($data['dt']));
        }

        $id = $this->createRow('banners', $data);
        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        if(!empty($data['df'])) {
            $data['df'] = date('Y-m-d', strtotime($data['df']));
        }

        if(!empty($data['dt'])) {
            $data['dt'] = date('Y-m-d', strtotime($data['dt']));
        }
        $s = $this->updateRow('banners', $id, $data);
        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('banners', " id={$id} limit 1");
    }

    public function getLanguages()
    {
        $r = self::$db->select("select id,name from languages")->all();
        $res = [];
        foreach ($r as $row) {
            $res[$row['id']] = $row['name'];
        }
        return $res;
    }
}