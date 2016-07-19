<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 17:36
 */

namespace modules\order\models\admin;

defined("CPATH") or die();

class Status extends \system\models\Engine
{
    public function get()
    {
        return self::$db
            ->select("
                select s.id, i.status
                from __orders_status s
                join __orders_status_info i on i.status_id=s.id and i.languages_id='{$this->languages_id}'
            ")
            ->all();
    }
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from __orders_status where id={$id}")->row($key);

        if($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select status from __orders_status_info where status_id={$id} and languages_id={$language['id']} limit 1")
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
        $id = $this->createRow('__orders_status', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['status_id'] = $id;
            $this->createRow('__orders_status_info', $item);
        }

        if($this->hasError()){
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

        $s = $this->updateRow('__orders_status', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __orders_status_info where status_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['status_id']       = $id;
                $this->createRow('__orders_status_info', $item);
            } else {
                $this->updateRow('__orders_status_info', $aid, $item);
            }
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__orders_status', " id={$id} limit 1");
    }

    private function changeMain()
    {
        self::$db->update('__orders_status', ['is_main' => 0]);
    }
}