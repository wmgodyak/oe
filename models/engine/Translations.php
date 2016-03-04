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
 * Class Translations
 * @package models\engine
 */
class Translations extends Engine
{
    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id)
    {
        $data =  self::$db->select("select * from translations where id={$id}")->row();
        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select value from translations_info where translations_id={$id} and languages_id={$language['id']} limit 1")
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
        $translations = $this->request->post('translations');
        $translations_info = $this->request->post('translations_info');

        $this->beginTransaction();

        $id = $this->createRow('translations', $translations);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($translations_info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['translations_id'] = $id;
           $this->createRow('translations_info', $item);
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
        $translations = $this->request->post('translations');
        $translations_info = $this->request->post('translations_info');
        $this->beginTransaction();
        $this->updateRow('translations', $id, $translations);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($translations_info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from translations_info where translations_id={$id} and languages_id={$this->languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['translations_id'] = $id;
                $this->createRow('translations_info', $item);
            } else {
                $this->updateRow('translations_info', $aid, $item);
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
        return self::$db->delete('translations', " id={$id} limit 1");
    }

    /**
     * @param $code
     * @return bool
     */
    public function is($code)
    {
        return self::$db->select("select id from translations where code = '{$code}' limit 1")->row('id') > 0;
    }

}