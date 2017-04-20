<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 20:59
 */

namespace system\components\contentTypes\models;
/**
 * Class ContentTypes
 * @package system\components\contentTypes\models
 */
class ContentTypes extends \system\models\ContentTypes
{
    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $s = parent::createRow('__content_types', $data);
        if($s>0 && $data['parent_id'] > 0){
            self::$db->update('__content_types', ['isfolder'=>1], "id={$data['parent_id']} limit 1");
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
        return parent::updateRow('__content_types', $id, $data);
    }

    public function delete($id)
    {
        $data = $this->getData($id);

        $s = parent::deleteRow('__content_types', $id); // TODO: Change the autogenerated stub

        if($s > 0 && $data['parent_id'] > 0){
            if(! $this->hasChildren($data['parent_id'])){
                parent::updateRow('__content_types', $data['parent_id'], ['isfolder' => 0]);
            }
        }

        return $s;
    }

    public function hasChildren($id)
    {
        return self::$db
            ->select("select count(id) as t from __content_types where parent_id={$id}")
            ->row('t') > 0;
    }

    public function issetTemplate($parent_id, $type, $id = null)
    {
        $parent_id = (int)$parent_id;
        return self::$db->select("
            select id
            from __content_types
            where parent_id={$parent_id} and type='{$type}' ". ($id ? " and id <> $id" : '') ." limit 1")
            ->row('id');
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
                from __features_content
                where
                content_types_id    = {$types_id}    and
                content_subtypes_id = {$subtypes_id} and
                features_id         = {$features_id}
                 ")->row('id') > 0;

        if($is) return 0;

        $pos = self::$db->select("
                select MAX(position) as t
                from __features_content
                where
                content_types_id    = {$types_id} and
                content_subtypes_id = {$subtypes_id}
                 ")->row('t');

        return $this->createRow
        (
            '__features_content',
            [
                'content_types_id'    => $types_id,
                'content_subtypes_id' => $subtypes_id,
                'features_id'         => $features_id,
                'position'            => ++ $pos
            ]
        );
    }

    public function deleteFeatures($id)
    {
        return $this->deleteRow('__features_content', $id);
    }
}