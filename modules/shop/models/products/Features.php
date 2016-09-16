<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:24
 */

namespace modules\shop\models\products;

defined("CPATH") or die();

/**
 * Class Features
 * @package modules\shop\models\products
 */
class Features extends \system\models\Features
{
    /**
     * @param $products_id
     * @param int $parent_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id, $products_id, $parent_id = 0)
    {
        $features = self::$db
            ->select("
                select f.id, f.type, fi.name
                from __content_features cf
                join __features_content fc on fc.content_id={$categories_id} and fc.features_id=cf.features_id
                join __features f on f.id = cf.features_id and f.status = 'published' and f.parent_id={$parent_id} and f.hide = 0
                join __features_info fi on fi.features_id = cf.features_id and fi.languages_id = {$this->languages_id}
                where cf.content_id={$products_id}
                order by abs(fc.position) asc
            ")
            ->all();

        foreach ($features as $k=>$feature) {
            switch($feature['type']){
                case 'select':
                    $features[$k]['values'] = self::$db
                        ->select("
                            select f.id, f.type, fi.name
                            from __content_features cf
                            join __features f on f.id = cf.values_id and f.status = 'published'
                            join __features_info fi on fi.features_id = cf.values_id and fi.languages_id = {$this->languages_id}
                            where cf.content_id={$products_id} and cf.features_id={$feature['id']}
                            ")
                        ->all();
                    break;
                case 'text':
                case 'textarea':
                     $features[$k]['value'] = $this->getTextValues($feature['id'], $products_id, $this->languages_id);
                    break;
                case 'file':
                case 'number':
                     $features[$k]['value'] = $this->getTextValues($feature['id'], $products_id, 0);
                    break;
                case 'folder':
                    $features[$k]['items'] = $this->get($products_id, $feature['id']);
                    break;
            }
        }

        return $features;
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
}