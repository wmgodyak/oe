<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 16:42
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class ContentTypes
 * @package models\engine
 */
class ContentTypes extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $d = self::$db->select("select {$key} from content_types where id={$id} limit 1")->row($key);
        if(isset($d['settings']) && !empty($d['settings'])) $d['settings'] = unserialize($d['settings']);


        if($d['parent_id'] > 0){
            $types_id = $d['parent_id'];
            $subtypes_id = $d['id'];
        } else {
            $types_id    = $d['id'];
            $subtypes_id = 0;
        }

        $d['features'] = $this->getSelectedFeatures($types_id, $subtypes_id);

//        echo $this->getDBErrorMessage();
        return $d;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $s = parent::createRow('content_types', $data);
        if($s>0 && $data['parent_id'] > 0){
            self::$db->update('content_types', ['isfolder'=>1], "id={$data['parent_id']} limit 1");
        }
        return $s;
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        return parent::updateRow('content_types', $id, $data);
    }

    public function delete($id)
    {
        $data = $this->getData($id);

        $s = parent::deleteRow('content_types', $id); // TODO: Change the autogenerated stub

        if($s > 0 && $data['parent_id'] > 0){
            if(! $this->hasChildren($data['parent_id'])){
                parent::updateRow('content_types', $data['parent_id'], ['isfolder' => 0]);
            }
        }

        return $s;
    }

    public function hasChildren($id)
    {
        return self::$db
            ->select("select count(id) as t from content_types where parent_id={$id}")
            ->row('t') > 0;
    }

    public function issetTemplate($parent_id, $type, $id = null)
    {
        $parent_id = (int)$parent_id;
        return self::$db->select("
            select id
            from content_types
            where parent_id={$parent_id} and type='{$type}' ". ($id ? " and id <> $id" : '') ." limit 1")
            ->row('id');
    }

    public function getFeatures()
    {
        return self::$db
            ->select("
                select f.id, i.name
                from features f, features_info i
                where f.status='published' and f.parent_id=0 and i.features_id=f.id and i.languages_id={$this->languages_id}
            ")
            ->all();
    }

    /**
     * @param $types_id
     * @param $subtypes_id
     * @param $features_id
     * @return bool|string
     */
    public function selectFeatures($types_id, $subtypes_id, $features_id)
    {
        $is = self::$db->select("
                select id
                from features_content
                where
                content_types_id    = {$types_id}    and
                content_subtypes_id = {$subtypes_id} and
                features_id         = {$features_id}
                 ")->row('id') > 0;

        if($is) return 0;

        $pos = self::$db->select("
                select MAX(position) as t
                from features_content
                where
                content_types_id    = {$types_id} and
                content_subtypes_id = {$subtypes_id}
                 ")->row('t');

        return $this->createRow
        (
            'features_content',
            [
                'content_types_id'    => $types_id,
                'content_subtypes_id' => $subtypes_id,
                'features_id'         => $features_id,
                'position'            => ++ $pos
            ]
        );
    }

    /**
     * @param $types_id
     * @param $subtypes_id
     * @return mixed
     */
    public function getSelectedFeatures($types_id, $subtypes_id)
    {
        return self::$db
            ->select("
                select fc.features_id as id, f.type, i.name
                from features_content fc
                join features f on f.id=fc.features_id
                join features_info i on i.features_id=f.id and i.languages_id={$this->languages_id}
                where
                content_types_id    = {$types_id} and
                content_subtypes_id = {$subtypes_id}
                order by abs(fc.position) asc
                ")
            ->all();
    }

    public function deleteFeatures($id)
    {
        return $this->deleteRow('features_content', $id);
    }
}