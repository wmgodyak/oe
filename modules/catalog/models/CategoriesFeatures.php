<?php

namespace modules\catalog\models;

use system\core\Session;

/**
 * Class CategoriesFeatures
 * @package modules\catalog\models
 */
class CategoriesFeatures extends \system\models\Features
{
    private $selected_features = [];
    private $currency;
    private $original_cat_id = 0;

    public function __construct()
    {
        parent::__construct();

        $this->currency = Session::get('currency');
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

        $selected = [];
        $_selected = $this->parseGetParams();

        if(!empty($_selected)){
            foreach ($_selected as $features_code => $a) {
                $features_id = $this->getIDByCode($features_code);
                if(empty($features_id)) continue;
                $selected[$features_id] = $a;
            }
        }

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

        $isfolder = self::$db->select("select isfolder from __content where id = {$this->original_cat_id} limit 1")->row('isfolder');
        $in = [];
        if($isfolder){
            $in = $this->getSubcategoriesId($categories_id);
        }

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($categories_id);
            } else{
                $items[$k]['values'] = $this->getValues($item, $categories_id, $in, $selected);
            }
        }

        return $items;
    }

    /**
     * @param $feature
     * @param $categories_id
     * @param array $subcategories
     * @param null $selected
     * @return mixed
     */
    private function getValues($feature, $categories_id, $subcategories = [], $selected = null)
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
            $items[$k]['total']  = $this->getValuesCount($item['id'], $categories_id, $subcategories, $selected);
        }

        return $items;
    }

    /**
     * @param $feature
     * @param $value
     * @param $categories_id
     * @return string
     */
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

    /**
     * @return array|null
     */
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

    /**
     * @return mixed
     */
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
    private function getValuesCount($values_id, $categories_id, $subcategories = [], $selected = null)
    {
        $w = "cr.categories_id='{$categories_id}'";
        if(!empty($subcategories)){
            $w = "cr.categories_id in (". implode(',', $subcategories) .")";
        }

        $join = [];
        if(!empty($selected)){
            foreach ($selected as $features_id => $values) {
                if(empty($values)) continue;

                $in = implode(',', $values);
                $join[] = "join __content_features cf{$features_id} on cf{$features_id}.content_id=cr.content_id and cf{$features_id}.features_id = {$features_id} and cf{$features_id}.values_id in ({$in}) ";
            }
        }

        $j = empty($join) ? null : implode('', $join);

        return self::$db
            ->select("
              select count(cf.id) as t
              from __content_relationship cr
              join __content_features cf on cf.content_id=cr.content_id and cf.values_id={$values_id}
              join __content c on c.id=cf.content_id and c.status = 'published'
              {$j}
              where {$w}
              ")
            ->row('t');
    }

    /**
     * @param $parent_id
     * @return array
     */
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

    /**
     * @param $categories_id
     * @param $group_id
     * @return array|mixed
     */
    public function getMinMaxPrice($categories_id, $group_id)
    {
        $isfolder = self::$db->select("select isfolder from __content where id={$categories_id} limit 1")
            ->row('isfolder');

        $in = [];

        if($isfolder){
            $in = $this->getSubcategoriesId($categories_id);
        }

        $w = $isfolder && !empty($in) ? "cr.categories_id in (". implode(',', $in) .")" : "cr.categories_id='{$categories_id}'";

        return self::$db
            ->select("
              select
              MIN(
                  CASE
                    WHEN p.currency_id = '{$this->currency['site']['id']}' THEN pp.price
                    WHEN p.currency_id <> '{$this->currency['site']['id']}' and p.currency_id = '{$this->currency['main']['id']}' THEN pp.price * '{$this->currency['site']['rate']}'
                    WHEN p.currency_id <> '{$this->currency['site']['id']}' and p.currency_id <> '{$this->currency['main']['id']}' THEN pp.price / cu.rate * '{$this->currency['site']['rate']}'
                  END
                ) as minp,
              MAX(
                  CASE
                    WHEN p.currency_id = '{$this->currency['site']['id']}' THEN pp.price
                    WHEN p.currency_id <> '{$this->currency['site']['id']}' and p.currency_id = '{$this->currency['main']['id']}' THEN pp.price * '{$this->currency['site']['rate']}'
                    WHEN p.currency_id <> '{$this->currency['site']['id']}' and p.currency_id <> '{$this->currency['main']['id']}' THEN pp.price / cu.rate * '{$this->currency['site']['rate']}'
                  END
                ) as maxp
              from __content_relationship cr
              join __products_prices pp on pp.content_id=cr.content_id and pp.group_id='{$group_id}'
              join __products p on p.content_id = cr.content_id
              join __content c on c.id=cr.content_id and c.status = 'published'
              join __currency cu on cu.id = p.currency_id
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


    /**
     * @param $categories_id
     * @return array|null
     */
    public function getSelected($categories_id)
    {
        $res = []; $qs_url = null;
        $_selected = $this->parseGetParams();

        if(empty($_selected)){
            return null;
        }

        if(!empty($_GET)){
            $qs = http_build_query($_GET);
            $qs_url = '?' . $qs;
        }

        foreach ($_selected as $fc => $a) {

            if(empty($a)){
                continue;
            }

            foreach ($a as $k=>$vid) {
                $url = $categories_id ;
                $name = "";

                $sp = $_selected;

                if(isset($sp[$fc])){
                    $k = array_search($vid, $sp[$fc]);
                    if($k !== false){
                        $name = $this->getName($vid);
                        unset($sp[$fc][$k]);
                        if(empty($sp[$fc])) unset($sp[$fc]);
                    } else {
                        $sp[$fc][] = $vid;
                    }
                } else {
                    $sp[$fc][] = $vid;
                }

                $i=0; $f_url = '';
                foreach ($sp as $f => $v) {
                    $f_url .= ($i > 0 ? ';': '') . "$f-" . implode(',' , $v);
                    $i++;
                }

                if(!empty($f_url)){
                    $url .= ';filter/' . $f_url . $qs_url;
                }
                $res[] = [
                    'name' => $name,
                    'url'  => $url
                ];
            }
        }

        return $res;
    }
}