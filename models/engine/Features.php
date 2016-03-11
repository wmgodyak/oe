<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 09.03.16
 * Time: 23:12
 */

namespace models\engine;

use models\Engine;

class Features extends Engine
{
    public function createBlank($parent_id)
    {
        self::$db->delete("features", " status='blank' and owner_id={$this->admin['id']}");
        return $this->createRow(
            'features',
            [
                'parent_id' => $parent_id,
                'owner_id'  => $this->admin['id'],
                'code'      => 'feature_' . time()
            ]
        );
    }

    public function getData($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from features where id={$id} limit 1")->row($key);

        if($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] =
                self::$db
                    ->select("select * from features_info where features_id={$id} and languages_id={$language['id']} limit 1")
                    ->row();
        }
        $data['statuses'] = self::$db->enumValues('features', 'status');
        $data['types']    = self::$db->enumValues('features', 'type');
        return $data;
    }

    public function getContentTypes($parent_id)
    {
        $res = [];
        foreach (self::$db->select("select id, name, isfolder from content_types where parent_id={$parent_id}")->all() as $item) {
            if($item['isfolder']){
                $item['items'] = $this->getContentTypes($item['id']);
            }
            $res[] = $item;
        }
        return $res;
    }

    public function getSelectedTypes($features_id)
    {
        $r = [];
        foreach (self::$db->select("select types_id from content_types_features where features_id={$features_id}")->all() as $item) {
            $r[$item['types_id']] = $item['types_id'];
        }
        return $r;
    }
    
    public function update($id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();
        $this->updateRow('features', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from features_info where features_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['features_id'] = $id;
                $this->createRow('features_info', $item);
            } else {
                $this->updateRow('features_info', $aid, $item);
            }
        }
        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        if($data['parent_id'] > 0){
            $this->updateRow('features', $data['parent_id'], ['type' => 'folder']);
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
        if($this->getData($id, 'type') == 'folder') return false;

        return $this->deleteRow('features', $id);
    }

    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return $this->updateRow('features', $id, ['status' => 'published']);
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return $this->updateRow('features', $id, ['status' => 'hidden']);
    }
}