<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 19:59
 */

namespace system\components\features\models;

use system\models\Engine;

defined("CPATH") or die();

class Features extends Engine
{
    public function createBlank($parent_id, $owner_id)
    {
        self::$db->delete("__features", " status='blank' and owner_id={$owner_id}");
        return $this->createRow(
            '__features',
            [
                'parent_id' => $parent_id,
                'owner_id'  => $owner_id,
                'code'      => 'feature_' . time()
            ]
        );
    }

    public function getData($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from __features where id={$id} limit 1")->row($key);

        if ($key != '*') return $data;

        foreach ($this->languages as $language) {
            $data['info'][$language['id']] =
                self::$db
                    ->select("select * from __features_info where features_id={$id} and languages_id={$language['id']} limit 1")
                    ->row();
        }

        $data['statuses'] = self::$db->enumValues('__features', 'status');
        $data['types'] = self::$db->enumValues('__features', 'type');
        $data['selected_content'] = $this->getSelectedContent($id);

        foreach ($data['types'] as $k => $type) {
            if ($type == 'value') {
                unset($data['types'][$k]);
            }
        }

        return $data;
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
        $this->updateRow('__features', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __features_info where features_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['features_id'] = $id;
                $this->createRow('__features_info', $item);
            } else {
                $this->updateRow('__features_info', $aid, $item);
            }
        }
        if($this->hasError()){
            $this->rollback();
            return false;
        }

        if(isset($data['parent_id']) && $data['parent_id'] > 0){
            $this->updateRow('__features', $data['parent_id'], ['type' => 'folder']);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function delete($id)
    {
        if($this->getData($id, 'type') == 'folder') return false;

        return $this->deleteRow('__features', $id);
    }

    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return $this->updateRow('__features', $id, ['status' => 'published']);
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return $this->updateRow('__features', $id, ['status' => 'hidden']);
    }

    /*
     * Features Values
     *
     */

    /**
     * @param $owner_id
     * @return bool
     */
    public function createValue($owner_id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $data['owner_id'] = $owner_id;
        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($owner_id . 'x' . microtime());
        }
        $id = $this->createRow('__features', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id'] = $languages_id;
            $item['features_id']  = $id;
            $this->createRow('__features_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function getContentTypes($parent_id)
    {
        return self::$db
            ->select("select id, name, isfolder from __content_types where parent_id={$parent_id}")
            ->all();
    }

    /**
     * @param $types_id
     * @param $subtypes_id
     * @param int $parent_id
     * @return array
     */
    public function getContent($types_id, $subtypes_id, $parent_id = 0)
    {
        $r = self::$db
            ->select("
                select c.id, c.isfolder, i.name
                from __content c, __content_info i
                where c.types_id={$types_id} and c.subtypes_id={$subtypes_id} and c.parent_id={$parent_id}
                 and i.content_id=c.id and i.languages_id={$this->languages_id}
                limit 100 -- блок підвисання
                 ")
            ->all();

        $res = [];
        foreach ($r as $row) {
            if($row['isfolder']) $row['items'] = $this->getContent($types_id, $subtypes_id, $row['id']);
            $res[] = $row;
        }
        return $res;
    }

    public function selectContent($features_id)
    {
        $data = [];
        $data['features_id']         = $features_id;
        $data['content_types_id']    = $this->request->post('content_types_id', 'i');
        $data['content_subtypes_id'] = $this->request->post('content_subtypes_id', 'i');

        $c = $this->request->post('content_id');
        if($c){
            foreach ($c as $k=>$content_id) {
                $content_id = (int)$content_id;
                if(empty($content_id)) continue;

                $data['content_id'] = $content_id;
                $this->createRow('__features_content', $data);
            }
        } else {
            $this->createRow('__features_content', $data);
        }
        $data['content_id'] = $features_id;


        return ! $this->hasError();
    }

    /**
     * @param $features_id
     * @return mixed
     */
    public function getSelectedContent($features_id)
    {
        $res = [];
        foreach (self::$db->select("select * from __features_content where features_id = {$features_id}")->all() as $row) {
            $row['type'] = $this->getTypeName($row['content_types_id']);
            $row['subtype'] = 'Всі';
            $row['content'] = 'Всі';

            if($row['content_subtypes_id'] > 0){
                $row['subtype'] = $this->getTypeName($row['content_subtypes_id']);
            }

            if($row['content_id'] > 0){
                $row['content'] = $this->getContentName($row['content_id']);
            }

            $res[] = $row;
        }
        return $res;
    }

    private function getTypeName($id)
    {
        return self::$db->select("select name from __content_types where id={$id} limit 1")->row('name');
    }
    private function getContentName($id)
    {
        return self::$db
            ->select("select name from __content_info where content_id={$id} and languages_id={$this->languages_id} limit 1")
            ->row('name');
    }

    public function deleteSelectedContent($id)
    {
        return self::deleteRow('__features_content', $id);
    }
}