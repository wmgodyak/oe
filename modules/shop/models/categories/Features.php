<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:24
 */

namespace modules\shop\models\categories;

use system\models\Currency;

defined("CPATH") or die();

/**
 * Class Features
 * @package modules\shop\models\categories
 */
class Features extends \system\models\Features
{
    private $selected_features = [];
    private $currency;
    private $original_cat_id = 0;

    public function __construct()
    {
        parent::__construct();

        $this->currency = new Currency();
    }


    /**
     * @param $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id)
    {
        if($this->original_cat_id == 0){
            $this->original_cat_id = $categories_id;
        }

        $this->parseGetParams();
        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type
              from __features_content fc
              join __features f on fc.features_id=f.id and f.status='published' and f.on_filter=1
              join __features_info fi on fi.features_id=f.id and fi.languages_id='{$this->languages_id}'
              where fc.content_id='{$categories_id}'
              order by abs(fc.position) asc
           ")->all();

        if(empty($items)){

            $cat_parent_id = self::$db
                ->select("select parent_id from __content where id='{$categories_id}' limit 1")
                ->row('parent_id');

            if($cat_parent_id > 0){
                return $this->get($cat_parent_id);
            }
        }

        $in = $this->getSubcategoriesId($categories_id);

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($categories_id);
            } else{
                $items[$k]['values'] = $this->getValues($item, $categories_id, $in);
            }
        }

        return $items;
    }

    /**
     * @param $feature
     * @param $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    private function getValues($feature, $categories_id, $subcategories = [])
    {
       if($this->original_cat_id > 0 && $categories_id != $this->original_cat_id){
           $categories_id = $this->original_cat_id;
       }
       $items =  self::$db->select("
              select f.id, fi.name, f.code
              from  __features f
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id={$feature['id']} and f.status = 'published'
              order by fi.name asc
           ")->all();
        foreach ($items as $k=>$item) {
            $items[$k]['active'] = isset($this->selected_features[$feature['code']]) && in_array($item['id'], $this->selected_features[$feature['code']]);
            $items[$k]['url']    = $this->makeValueUrl($feature, $item, $categories_id);
            $items[$k]['total']  = $this->getValuesCount($item['id'], $categories_id, $subcategories);
        }

        return $items;
    }

    private function makeValueUrl($feature, $value, $categories_id)
    {
        $url = $categories_id ;

        $sp = $this->selected_features;

        if(isset($sp[$feature['code']])){
            $k = array_search($value['id'], $sp[$feature['code']]);
            if($k !== false){
                unset($sp[$feature['code']][$k]);
                if(empty($sp[$feature['code']])) unset($sp[$feature['code']]);
            } else {
                $sp[$feature['code']][] = $value['id'];
            }
        } else {
            $sp[$feature['code']][] = $value['id'];
        }

        $i=0; $f_url = '';
        foreach ($sp as $f => $v) {
            $f_url .= ($i > 0 ? ';': '') . "$f-" . implode(',' , $v);
            $i++;
        }

        if(!empty($f_url)){
            $url .= ';filter/' . $f_url;
        }

        if(!empty($_GET)){
            $qs = http_build_query($_GET);
            $url .= '?' . $qs;
        }

        return $url;
    }

    /**
     * @return array|null
     */
    public function parseGetParams()
    {
        $filter = $this->request->param('filter');
        if(empty($filter)) return null;

        $a = explode(';', $filter);
        foreach ($a as $k=>$f) {
            $b = explode('-', $f);
            if(!isset($b[1]) || empty($b[1])) continue;

            $this->selected_features[$b[0]] = explode(',', $b[1]);
        }

        return $this->selected_features;
    }

    public function makeMeta()
    {
        $res = [];
        $selected = $this->parseGetParams();
        if(empty($selected)) return null;

        foreach ($selected as $key => $values) {
            $features_id = $this->getIDByCode($key);
            $name = $this->getName($features_id);
            $v_names = [];
            foreach ($values as $k=>$values_id) {
                $v_names[] = $this->getName($values_id);
            }

            $res[] = ['name' => $name, 'values' => $v_names];
        }

        return $res;
    }

    public function getFormAction()
    {
        return $_SERVER['REQUEST_URI'];
    }

    /**
     * @param $values_id
     * @param $categories_id
     * @param array $subcategories
     * @return array|mixed
     */
    private function getValuesCount($values_id, $categories_id, $subcategories = [])
    {
        $w = "cr.categories_id='{$categories_id}'";
        if(!empty($subcategories)){
            $w = "cr.categories_id in (". implode(',', $subcategories) .")";
        }
        return self::$db
            ->select("
              select count(cf.id) as t
              from __content_relationship cr
              join __content_features cf on cf.content_id=cr.content_id and cf.values_id={$values_id}
              where {$w}
              ")
            ->row('t');
    }

    public function getSubcategoriesId($parent_id)
    {
        $in = [];

        $r = self::$db
            ->select("select id, isfolder from __content where parent_id={$parent_id} and status='published'")
            ->all();

        foreach ($r as $item) {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->getSubcategoriesId($item['id']));
            }
        }

        return $in;
    }

    public function getMinMaxPrice($categories_id, $group_id)
    {
        $isfolder = self::$db->select("select isfolder from __content where id={$categories_id} limit 1")
            ->row('isfolder');

        $in = [];

        if($isfolder){
            $in = $this->getSubcategoriesId($categories_id);
        }

        $cu_on_site = $this->currency->getOnSiteMeta();
        $cu_main    = $this->currency->getMainMeta();

        $w = $isfolder && !empty($in) ? "cr.categories_id in (". implode(',', $in) .")" : "cr.categories_id='{$categories_id}'";

        return self::$db
            ->select("
              select
              MIN(CASE
            WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END) as minp,
              MAX(CASE
            WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END) as maxp
              from __content_relationship cr
              join __products_prices pp on pp.content_id=cr.content_id and pp.group_id={$group_id}
              join __content c on c.id=cr.content_id
              join __currency cu on cu.id = c.currency_id
              where {$w}
              ")
            ->row();
    }

    /**
     * @param $code
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getIDByCode($code)
    {
        return self::$db->select("select id from __features where code = '{$code}' limit 1")->row('id');
    }
}