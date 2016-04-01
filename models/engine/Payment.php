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
 * Class Payment
 * @package models\engine
 */
class Payment extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from payment where id={$id}")->row($key);

        if($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select name, description from payment_info where payment_id={$id} and languages_id={$language['id']} limit 1")
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

        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);

        $id = $this->createRow('payment', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['payment_id'] = $id;
            $this->createRow('payment_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $delivery = $this->request->post('delivery');
        foreach ($delivery as $k=>$delivery_id) {
            DeliveryPayment::create($delivery_id, $id);
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
        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);
        $s = $this->updateRow('payment', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from payment_info where payment_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['payment_id']     = $id;
                $this->createRow('payment_info', $item);
            } else {
                $this->updateRow('payment_info', $aid, $item);
            }
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }


        $delivery = $this->request->post('delivery');

        $selected = DeliveryPayment::getSelectedDelivery($id);
        foreach ($delivery as $k=>$delivery_id) {
            if(in_array($delivery_id, $selected)){
                unset($selected[$delivery_id]);
                continue;
            }
            DeliveryPayment::create($delivery_id, $id);
        }

        if(!empty($selected)){
            foreach ($selected as $k=>$delivery_id) {
                DeliveryPayment::delete($delivery_id, $id);
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
        return self::$db->delete('payment', " id={$id} limit 1");
    }

    public function pub($id)
    {
        return self::$db->update('payment',['published' => 1], " id={$id} limit 1");
    }

    public function hide($id)
    {
        return self::$db->update('payment',['published' => 0], " id={$id} limit 1");
    }

    public function getSettings($module)
    {
        $s = self::$db->select("select settings from payment where module='{$module}' limit 1 ")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }
}