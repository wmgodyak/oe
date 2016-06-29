<?php

namespace system\components\features\models;

defined("CPATH") or die();

/**
 * Class Features
 * @package system\components\features\models
 */
class Features extends \system\models\Features
{
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