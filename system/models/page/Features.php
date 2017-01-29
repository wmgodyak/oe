<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 31.10.16 : 11:53
 */

namespace system\models\page;

use system\models\Frontend;

defined("CPATH") or die();

/**
 * Class Features
 * @package system\models\page
 */
class Features extends Frontend
{
    /**
     * @param $content_id
     * @param int $parent_id
     * @return mixed
     */
    public function get($content_id, $parent_id = 0)
    {
        // get type and subtype
        $cdata = self::$db->select("select types_id, subtypes_id from __content where id = {$content_id} limit 1")->row();
        $items =
            self::$db->select("
              select f.id, fi.name, f.code, f.type
              from __features_content fc
              join __features f on  f.id=fc.features_id and f.parent_id = {$parent_id} and f.status='published'
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where fc.content_types_id={$cdata['types_id']} and fc.content_subtypes_id={$cdata['subtypes_id']}
                    and fc.content_id in (0, {$content_id})
              order by abs(fc.position) asc
           ")->all();

        $res = [];

        foreach ($items as $k=>$item) {
            switch($item['type']){
                case 'folder':
                    $item['items'] = $this->get($content_id, $item['id']);
                    break;
                case 'select':
                    $item['values'] = $this->values($content_id, $item['id']);
                    break;
                case 'file':
                case 'number':
                case 'image':
                case 'checkbox':
                    $item['value'] = $this->value($content_id, $item['id']);
                    break;
                default:
                    $item['value'] = $this->value($content_id, $item['id'], $this->languages_id);
                    break;
            }

            $res[$item['code']] = $item;
        }

        return $res;
    }

    /**
     * @param $content_id
     * @param $features_id
     * @return mixed
     */
    private function values($content_id, $features_id)
    {
        return self::$db->select("
              select f.id, fi.name
              from __content_features cf
              join __features f on f.id = cf.values_id and f.type = 'value' and f.status='published'
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where cf.content_id = {$content_id} and cf.features_id={$features_id}
              order by fi.name asc
           ")->all();
    }

    /**
     * @param $content_id
     * @param $features_id
     * @param int $languages_id
     * @return array|mixed
     */
    private function value($content_id, $features_id, $languages_id = 0)
    {
        return self::$db
            ->select("
                 select value
                 from __content_features
                 where content_id={$content_id}
                 and features_id = {$features_id}
                 and languages_id = {$languages_id}
                 limit 1
                 ")
            ->row('value');
    }

    /**
     * @param $code
     * @return array|mixed
     */
    private function getFeatureIdByCode($code)
    {
        return self::$db->select("select id from __features where code like '$code' limit 1")->row('id');
    }

    /**
     * @param $content_id
     * @param $code
     * @return mixed|null
     */
    public function getValues($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->values($content_id, $features_id);
    }

    /**
     * @param $content_id
     * @param $code
     * @param int $languages_id
     * @return array|mixed|null
     */
    public function getValue($content_id, $code, $languages_id = null)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        $languages_id = $languages_id == null ? $this->languages_id : 0;

        return $this->value($content_id, $features_id, $languages_id);
    }
    // 'text','textarea','select','file','folder','value','checkbox','number'
    /**
     * @param $content_id
     * @param $code
     * @return array|mixed|null
     */
    public function getTextValue($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->value($content_id, $features_id, $this->languages_id);
    }

    /**
     * @param $content_id
     * @param $code
     * @return array|mixed|null
     */
    public function getFileValue($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->value($content_id, $features_id);
    }

    /**
     * @param $content_id
     * @param $code
     * @return array|mixed|null
     */
    public function getNumberValue($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->value($content_id, $features_id);
    }

    /**
     * @param $content_id
     * @param $code
     * @return array|mixed|null
     */
    public function getCheckboxValue($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->value($content_id, $features_id);
    }
    /**
     * @param $content_id
     * @param $code
     * @return array|mixed|null
     */
    public function getImageValue($content_id, $code)
    {
        $features_id = $this->getFeatureIdByCode($code);
        if(empty($features_id)) return null;

        return $this->value($content_id, $features_id);
    }

    /**
     * @param $code
     * @return mixed
     */
    public function getName($code)
    {
        return self::$db
            ->select
            ("
              select fi.name
              from __features f
              join __features_info fi on fi.features_id=f.id and fi.languages_id='{$this->languages_id}'
              where f.code = '{$code}'
              limit 1
           ")
            ->all('name');
    }
}