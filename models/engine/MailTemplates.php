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
 * Class MailTemplates
 * @package models\engine
 */
class MailTemplates extends Engine
{
    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id)
    {
        $data =  self::$db->select("select * from mail_templates where id={$id}")->row();
        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select subject, body from mail_templates_info where templates_id={$id} and languages_id={$language['id']} limit 1")
                ->row();
        }
        return $data;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $id = $this->createRow('mail_templates', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['templates_id'] = $id;
           $this->createRow('mail_templates_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $this->beginTransaction();
        $this->updateRow('mail_templates', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from mail_templates_info where templates_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['templates_id'] = $id;
                $this->createRow('mail_templates_info', $item);
            } else {
                $this->updateRow('mail_templates_info', $aid, $item);
            }
        }
        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function delete($id)
    {
        return self::$db->delete('mail_templates', " id={$id} limit 1");
    }

    /**
     * @param $code
     * @param $id
     * @return bool
     */
    public function is($code, $id)
    {
        $w = '';
        if($id){
            $w = " and id<>{$id}";
        }
        return self::$db->select("select id from mail_templates where code = '{$code}' {$w} limit 1")->row('id') > 0;
    }

}