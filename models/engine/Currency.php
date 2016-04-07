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
 * Class Currency
 * @package models\engine
 */
class Currency extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from currency where id={$id}")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');

        $id = $this->createRow('currency', $data);

        if($id>0 && $data['is_main']) {
            $this->toggleMain($id);
        }

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $s = $this->updateRow('currency', $id, $data);

        if($data['is_main']) {
            $this->toggleMain($id);
        }

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('currency', " id={$id} limit 1");
    }

    private function toggleMain($currency_id)
    {
        self::$db->update('currency',['is_main' => 0]);
        return $this->updateRow('currency', $currency_id, ['is_main' => 1]);
    }

    public static function get()
    {
        return self::$db->select("select id, name, code from currency order by is_main desc, id asc")->all();
    }
}