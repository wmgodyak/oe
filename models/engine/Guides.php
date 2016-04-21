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
 * Class Guides
 * @package models\engine
 */
class Guides extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data =  self::$db->select("select {$key} from __guides where id={$id}")->row($key);

        if($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] = self::$db
                ->select("select * from __guides_info where guides_id={$id} and languages_id={$language['id']} limit 1")
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
        $guides = $this->request->post('guides');
        $guides_info = $this->request->post('guides_info');

        $this->beginTransaction();

        $id = $this->createRow('__guides', $guides);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($guides_info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['guides_id'] = $id;
           $this->createRow('__guides_info', $item);
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
        $guides = $this->request->post('guides');
        $guides_info = $this->request->post('guides_info');

        $this->beginTransaction();
        $this->updateRow('__guides', $id, $guides);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($guides_info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __guides_info where guides_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['guides_id'] = $id;
                $this->createRow('__guides_info', $item);
            } else {
                $this->updateRow('__guides_info', $aid, $item);
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
        return self::$db->delete('__guides', " id={$id} limit 1");
    }
}