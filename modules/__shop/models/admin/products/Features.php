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
              select f.id, fi.name, f.code, f.type, fc.id as fc_id, f.multiple
              from __features f
              join __features_content fc on fc.content_id='{$categories_id}' and fc.features_id=f.id
              join __features_info fi on fi.features_id=f.id and fi.languages_id='{$this->languages_id}'
              where f.parent_id = '{$parent_id}'
               -- and f.type in ('select', 'folder')
               and f.status='published'
              order by abs(fc.position) asc
           ")->all();

        if(empty($items)){
            $cat_parent_id = self::$db
                ->select("select parent_id from __content where id='{$categories_id}' limit 1")
                ->row('parent_id');
            if($cat_parent_id > 0){
                return $this->get($cat_parent_id, $products_id, $parent_id);
            }
        }

        foreach ($items as $k=>$item) {
            switch($item['type']){
                case 'folder':
                    $items[$k]['items'] = $this->get($categories_id, $products_id, $item['id']);
                    break;
                case 'select':
                    $items[$k]['values'] = $this->getValues($item['id'], $products_id);
                    break;
                case 'text':
                case 'textarea':
                    $items[$k]['values'] = $this->getTextValues($item['id'], $products_id);
                    break;
                case 'file':
                case 'number':
                    $items[$k]['values'] = $this->getTextValues($item['id'], $products_id, 0);
                    break;
            }
        }
        return $items;
    }

    /**
     * @param $features_id
     * @param $content_id
     * @param int $languages_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getTextValues($features_id, $content_id, $languages_id = null)
    {
        $w = $languages_id ? " and languages_id = {$languages_id} limit 1" : '';
        $q = self::$db->select("
            select value, languages_id
            from __content_features
            where content_id={$content_id} and features_id={$features_id} {$w}
            ");

        if($languages_id !== null){
            return  $q->row('value');
        }

        $res = [];

        foreach ($q->all() as $item) {
            $res[$item['languages_id']] = $item['value'];
        }

        return $res;
    }

    public function createValue($admin_id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $data['owner_id'] = $admin_id;

        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($admin_id . 'x' . microtime());
        }

        $id = $this->createRow('__features', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['features_id']     = $id;
            $this->createRow('__features_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
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
              -- and f.type in ('select', 'folder')
               and f.status='published'
              order by abs(fc.position) asc
           ")->all();
    }
}