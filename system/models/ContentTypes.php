<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 10:52
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class ContentTypes
 * @package system\models
 */
class ContentTypes extends Backend
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $d = self::$db->select("select {$key} from __content_types where id='{$id}' limit 1")->row($key);

        if($key != '*') return $d;

        if(isset($d['settings']) && !empty($d['settings'])) $d['settings'] = unserialize($d['settings']);

        if($d['parent_id'] > 0){
            $types_id = $d['parent_id'];
            $subtypes_id = $d['id'];
        } else {
            $types_id    = $d['id'];
            $subtypes_id = 0;
        }

        $d['features']     = $this->getSelectedFeatures($types_id, $subtypes_id);
        $d['images_sizes'] = $this->getSelectedImagesSizes($id);
        return $d;
    }

    private function getSelectedImagesSizes($types_id)
    {
        return self::$db
            ->select("select images_sizes_id from __content_types_images_sizes where types_id={$types_id}")
            ->all('images_sizes_id');
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
                from __features_content fc
                join __features f on f.id=fc.features_id
                join __features_info i on i.features_id=f.id and i.languages_id={$this->languages_id}
                where
                content_types_id    = {$types_id} and
                content_subtypes_id = {$subtypes_id}
                order by abs(fc.position) asc
                ")
            ->all();
    }

    public function get($parent_id = 0)
    {
        return self::$db
            ->select("
                select id, name, parent_id, isfolder
                from __content_types
                where parent_id={$parent_id}
                order by is_main desc
                ")
            ->all();
    }
}