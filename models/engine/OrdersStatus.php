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
 * Class OrdersStatus
 * @package models\engine
 */
class OrdersStatus extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from orders_status where id={$id}")->row($key);

        if($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select status from orders_status_info where status_id={$id} and languages_id={$language['id']} limit 1")
                ->row();
        }
        return $data;
    }

    /**
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $this->beginTransaction();

        if($data['is_main'] == 1){
            $this->changeMain();
        }
        $id = $this->createRow('orders_status', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['status_id'] = $id;
            $this->createRow('orders_status_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $info = $this->request->post('info');
        $data = $this->request->post('data');

        $this->beginTransaction();

        if($data['is_main'] == 1){
            $this->changeMain();
        }

        $s = $this->updateRow('orders_status', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from orders_status_info where status_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['status_id']       = $id;
                $this->createRow('orders_status_info', $item);
            } else {
                $this->updateRow('orders_status_info', $aid, $item);
            }
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('orders_status', " id={$id} limit 1");
    }

    private function changeMain()
    {
        self::$db->update('orders_status', ['is_main' => 0]);
    }

}