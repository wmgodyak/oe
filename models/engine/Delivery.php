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
 * Class Delivery
 * @package models\engine
 */
class Delivery extends Engine
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

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select name, description from __delivery_info where delivery_id={$id} and languages_id={$language['id']} limit 1")
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
        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);

        $this->beginTransaction();

        $id = $this->createRow('delivery', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['delivery_id'] = $id;
            $this->createRow('delivery_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $payment = $this->request->post('payment');
        foreach ($payment as $k=>$payment_id) {
            DeliveryPayment::create($id, $payment_id);
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

        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);

        $this->beginTransaction();

        $s = $this->updateRow('__delivery', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __delivery_info where delivery_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['delivery_id']     = $id;
                $this->createRow('delivery_info', $item);
            } else {
                $this->updateRow('__delivery_info', $aid, $item);
            }
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $selected = DeliveryPayment::getSelectedPayment($id);
        $payment = $this->request->post('payment');
        foreach ($payment as $k=>$payment_id) {
            if(in_array($payment_id, $selected)){
                unset($selected[$payment_id]);
                continue;
            }
            DeliveryPayment::create($id, $payment_id);
        }
        if(!empty($selected)){
            foreach ($selected as $k=>$payment_id) {
                DeliveryPayment::delete($id, $payment_id);
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
        return self::$db->delete('delivery', " id={$id} limit 1");
    }
    public function pub($id)
    {
        return self::$db->update('__delivery',['published' => 1], " id={$id} limit 1");
    }

    public function hide($id)
    {
        return self::$db->update('__delivery',['published' => 0], " id={$id} limit 1");
    }

    public function getSettings($module)
    {
        $s = self::$db->select("select settings from __delivery where module='{$module}' limit 1 ")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }
}