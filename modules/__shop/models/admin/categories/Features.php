<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:23
 */

namespace modules\shop\models\admin\categories;

defined("CPATH") or die();

/**
 * Class CategoriesFeatures
 * @package modules\shop\models\admin
 */
class Features extends \modules\shop\models\categories\Features
{
    /**
     * @param int $parent_id
     * @param null $content_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($parent_id = 0, $content_id = null, $only_selected = false)
    {
        $w = $content_id ? ", IF(fc.id > 0, 'selected', '') as selected, fc.id as fc_id" : "";
        $jt = $only_selected ? "inner" : "left";
        $j = $content_id ? "{$jt} join __features_content fc on fc.content_id={$content_id} and fc.features_id=f.id" : "";

        $ob = $only_selected ? "abs(fc.position) asc" : "fi.name asc";

        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type {$w}
              from __features f
              {$j}
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id = {$parent_id}
               and f.type <> 'value'
               and f.status='published'
              order by {$ob}
           ")->all();

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($item['id'], $content_id);
            }
        }

        return $items;
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

    public function getTypes()
    {
        return self::$db->enumValues('__features', 'type');
    }

}