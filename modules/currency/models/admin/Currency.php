<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 29.06.16
 * Time: 23:50
 */

namespace modules\currency\models\admin;

use system\models\Model;

class Currency extends Model
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __currency where id={$id}")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');

        $id = $this->createRow('__currency', $data);

        if($id>0 && $data['is_main']) {
            $this->toggleMain($id);
        }
        if($id > 0 && $data['on_site']) {
            $this->toggleOnSite($id);
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
        $s = $this->updateRow('__currency', $id, $data);

        if($data['is_main']) {
            $this->toggleMain($id);
        }
        if($data['on_site']) {
            $this->toggleOnSite($id);
        }

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__currency', " id={$id} limit 1");
    }

    private function toggleMain($currency_id)
    {
        self::$db->update('__currency',['is_main' => 0]);
        return $this->updateRow('__currency', $currency_id, ['is_main' => 1]);
    }

    private function toggleOnSite($currency_id)
    {
        self::$db->update('__currency',['on_site' => 0]);
        return $this->updateRow('__currency', $currency_id, ['on_site' => 1]);
    }

    public static function get()
    {
        return self::$db->select("select id, name, code from __currency order by is_main desc, id asc")->all();
    }
}