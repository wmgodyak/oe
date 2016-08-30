<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.06.16 : 17:14
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class FeaturesContent
 * @package system\models
 */
class FeaturesContent extends Model
{
    public function create($data)
    {
        return self::$db->insert("__features_content", $data);
    }

    public function get($features_id, $content_types_id = null, $content_subtypes_id = null, $content_id = null)
    {
        $w = [];
        $w[] = "features_id = $features_id";

        if($content_types_id)
            $w[] = "content_types_id = $content_types_id";
        if($content_subtypes_id)
            $w[] = "content_subtypes_id = $content_subtypes_id";
        if($content_id)
            $w[] = "content_id = $content_id";

        $where = implode(' and ', $w);

        return self::$db->select("select * from __features_content where $where")->all();
    }

    public function getTypeName($id)
    {
        return self::$db->select("select name from __content_types where id={$id} limit 1")->row('name');
    }

    public function getContentName($id)
    {
        return self::$db
            ->select("select name from __content_info where content_id={$id} and languages_id={$this->languages_id} limit 1")
            ->row('name');
    }


    public function getContentTypes($parent_id)
    {
        return self::$db
            ->select("select id, name, isfolder from __content_types where parent_id={$parent_id}")
            ->all();
    }

    public function delete($id)
    {
        return parent::deleteRow('__features_content', $id);
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

    public function reorder($el)
    {
        foreach ($el as $position => $id) {
            $this->updateRow('__features_content', $id, ['position' => $position]);
        }
    }


    public function getContentData($content_id)
    {
        return self::$db->select("select * from __content where id={$content_id} limit 1")->row();
    }

    public function getSelectedFeatures($content_id)
    {
        return self::$db->select("select features_id from __features_content where content_id={$content_id}")->all('features_id');
    }

    /**
     * @param $content_id
     * @param $features
     * @return int
     * @throws \system\core\exceptions\Exception
     */
    public function deleteSelectedFeatures($content_id, $features)
    {
        $in = implode(',', $features);
        return self::$db->delete('__features_content', " content_id={$content_id} and features_id in ({$in})");
    }
}