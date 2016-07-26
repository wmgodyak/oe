<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:23
 */

namespace modules\shop\models\admin\products;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class CategoriesFeatures
 * @package modules\shop\models\admin
 */
class Features extends Model
{
    /**
     * @param $categories_id
     * @param $products_id
     * @param int $parent_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id, $products_id, $parent_id = 0)
    {
        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type, fc.id as fc_id, f.multiple
              from __features f
              join __features_content fc on fc.content_id='{$categories_id}' and fc.features_id=f.id
              join __features_info fi on fi.features_id=f.id and fi.languages_id='{$this->languages_id}'
              where f.parent_id = '{$parent_id}'
               and f.type in ('select', 'folder')
               and f.status='published'
              order by abs(fc.position) asc
           ")->all();

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($categories_id, $products_id, $item['id']);
            } else {
                $items[$k]['values'] = $this->getValues($item['id'], $products_id);
            }
        }

        return $items;
    }

    /**
     * @param $parent_id
     * @param int $content_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getValues($parent_id, $content_id = 0)
    {
        $w = $content_id > 0 ? ", IF(cf.id > 0, 'selected', '') as selected" : '';
        $j = $content_id > 0 ? "left join __content_features cf on cf.content_id = {$content_id} and cf.values_id = f.id" : '';
        return self::$db->select("
              select f.id, fi.name {$w}
              from __features f
              {$j}
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id = {$parent_id} and f.type = 'value' and f.status='published'
              order by abs(f.position) asc, fi.name asc
           ")->all();
    }

    public function getAll($categories_id)
    {
        return
            self::$db->select("
              select f.id, fi.name, f.code, IF(fc.id > 0, 'selected', '' ) as selected
              from __features f
              left join __features_content fc on fc.content_id={$categories_id} and fc.features_id=f.id
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id = 0
               and f.type in ('select', 'folder')
               and f.status='published'
              order by abs(fc.position) asc
           ")->all();
    }
}