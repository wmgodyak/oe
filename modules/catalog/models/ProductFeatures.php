<?php

namespace modules\catalog\models;

use system\models\Model;

/**
 * Class ProductFeatures
 * @package modules\catalog\models
 */
class ProductFeatures extends Model
{
    private $product_id;
    private $category_id;
    private $language;

    /**
     * ProductFeatures constructor.
     * @param $product_id
     * @param $category_id
     * @param $language
     */
    public function __construct($product_id, $category_id, $language)
    {
        parent::__construct();

        $this->product_id = $product_id;
        $this->category_id = $category_id;
        $this->language = $language;
    }

    /**
     * @param int $parent_id
     * @param null $on_list
     * @return mixed
     */
    public function get($parent_id = 0, $on_list = null)
    {
        $on_list = $on_list ? " and on_list = 1 " : "";
        $q = "
            select f.id, f.type, fi.name
            from __features_content fc
            join __features f on f.id = fc.features_id and f.status = 'published' and f.parent_id={$parent_id} {$on_list} and f.hide = 0
            join __features_info fi on fi.features_id = f.id and fi.language->id = {$this->language->id}
            where fc.content_id={$this->category_id}
            order by abs(fc.position) asc
        ";

        $features = self::$db->select($q)->all();

        if(empty($features)){
            $this->category_id = self::$db
                ->select("select parent_id from __content where id='{$this->category_id}' limit 1")
                ->row('parent_id');

            if($this->category_id > 0){
                return $this->get($parent_id, $on_list);
            }
        }

        // витягнути значення для них відносно товару
        foreach ($features as $k=>$feature) {
            switch($feature['type']){
                case 'select':
                    $features[$k]['values'] = self::$db
                        ->select("
                            select f.id, f.type, fi.name
                            from __content_features cf
                            join __features f on f.id = cf.values_id and f.status = 'published'
                            join __features_info fi on fi.features_id = cf.values_id and fi.language->id = {$this->language->id}
                            where cf.content_id={$this->product_id} and cf.features_id={$feature['id']}
                            ")
                        ->all();
                    break;
                case 'text':
                case 'textarea':
                    $features[$k]['value'] = $this->getTextValues($feature['id'], $this->language->id);
                    break;
                case 'file':
                case 'number':
                    $features[$k]['value'] = $this->getTextValues($feature['id'], 0);
                    break;
                case 'folder':
                    $features[$k]['items'] = $this->get($feature['id'], $on_list);
                    break;
            }
        }

        return $features;
    }

    /**
     * @param $features_id
     * @param null $languages_id
     * @return array|mixed
     */
    public function getTextValues($features_id, $languages_id = null)
    {
        $w = $languages_id ? " and languages_id = {$languages_id} limit 1" : '';

        $q = self::$db->select("
            select value, languages_id
            from __content_features
            where content_id={$this->product_id} and features_id={$features_id} {$w}
            ");

        if($languages_id){
            return  $q->row('value');
        }

        $res = [];

        foreach ($q->all() as $item) {
            $res[$item['language_id']] = $item['value'];
        }

        return $res;
    }

    /**
     * get short features
     * @param $parent_id
     * @return mixed
     */
    public function getOnList($parent_id)
    {
        return $this->get($parent_id, true);
    }
}