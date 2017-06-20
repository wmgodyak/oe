<?php

namespace modules\catalog\models;

use system\models\Features;
use system\models\Model;


/**
 * Class CategoriesFeatures
 * @package modules\catalog\models
 */
class CategoriesFeatures extends Model
{
    private $selected_features = [];
    private $category_id;
    public $features;
    public $category;

    public function __construct(Features $features, $languages, $category)
    {
        parent::__construct();

        $this->features    = $features;
        $this->languages   = $languages;

        $this->category = $category;
    }

    /**
     * @param $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id)
    {
        if(! $this->category_id) $this->category_id = $categories_id;

        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type
              from __features_content fc
              join __features f on fc.features_id=f.id and f.status='published' and f.on_filter=1
              join __features_info fi on fi.features_id=f.id and fi.languages_id='{$this->languages->id}'
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


        $isfolder = self::$db->select("select isfolder from __content where id = {$categories_id} limit 1")->row('isfolder');

        $in = [];
        if($isfolder){
            $in = $this->subCategories($categories_id);
        }

        $selected = [];

        if(!empty($this->selected_features)){
            foreach ($this->selected_features as $features_code => $a) {

                if($features_code == 'manufacturer'){

                    continue;
                }

                $features_id = $this->features->getIDByCode($features_code);
                if(empty($features_id)) continue;
                $selected[$features_id] = $a;
            }
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
        if($this->category_id > 0 && $categories_id != $this->category_id){
            $categories_id = $this->category_id;

        }
        $items =  self::$db->select("
              select f.id, fi.name, f.code
              from  __features f
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages->id}
              where f.parent_id={$feature['id']} and f.status = 'published'
              order by fi.name asc
           ")->all();
        foreach ($items as $k=>$item) {
            $items[$k]['active'] = isset($this->selected_features[$feature['code']]) && in_array($item['id'], $this->selected_features[$feature['code']]);
            $items[$k]['url']    = $this->makeValueUrl($feature, $item, $categories_id);
            $items[$k]['total']  = $this->totalProducts($item['id']);
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

//        if(!empty($_GET)){
//            $qs = http_build_query($_GET);
//            $url .= '?' . $qs;
//        }

        return $url;
    }


    /**
     * @return array|null
     */
    private function makeMeta()
    {
        $res = [];
        if(empty($this->selected_features)) return null;

        foreach ($this->selected_features as $key => $values) {
            $features_id = $this->features->getIDByCode($key);
            $name = $this->features->getName($features_id);
            $v_names = [];
            foreach ($values as $k=>$values_id) {
                $v_names[] = $this->features->getName($values_id);
            }

            $res[] = ['name' => $name, 'values' => $v_names];
        }

        return $res;
    }

    private function totalProducts($value)
    {
        return 999;
        $this->category->products->clear();

        $this->category->products->category($this->request->param('category_id'));

        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($minp > 0 && $maxp > 0) {
            $this->category->products->where(" and price between {$minp} and {$maxp}");
        } elseif($minp > 0 && $maxp == 0){
            $this->category->products->where(" and price > {$minp}");
        } elseif($minp == 0 && $maxp > 0){
            $this->category->products->where(" and price < {$maxp}");
        }

        $selected = $this->request->param('selected_features');

        $manufacturers_in = [];

        if(!empty($selected)){

            foreach ($selected as $code => $values) {

                if($code == 'manufacturer'){

                    $in = [];
                    foreach ($values as $value) {
                        $id = self::$db->select("select content_id as id from __content_info where url = '$value' and languages_id = '{$this->languages->id}' limit 1")->row('id');
                        if(empty( $id )) continue;

                        $in[] = $id;
                    }

                    if(empty($in)) return ;

                    $in = implode(', ', $in);
                    $this->category->products->where(" and p.manufacturers_id in ($in) ");

                    continue;
                }

                $features_id = self::$db->select("select id from __features where code = '{$code}' limit 1")->row('id');

                if(empty($features_id) || empty($values)) continue;

                $this->category->products->join("join __content_features cf{$features_id} on
                    cf{$features_id}.content_id=c.id
                and cf{$features_id}.features_id = {$features_id}
                and cf{$features_id}.values_id in (". implode(',', $values) .")
                ");

            }

        }


        // todo here $value
//        if(empty($manufacturers_in)){
//            $manufacturers_in[] = $manufacturer['id'];
//        }

        $t = $this->category->products->total();
        $this->category->products->clear();

        return $t['total'];
    }

//    /**
//     * @param $values_id
//     * @param $categories_id
//     * @param array $subcategories
//     * @return array|mixed
//     */
//    private function getValuesCount($values_id, $categories_id, $subcategories = [], $selected = null)
//    {
//        $w = "cr.categories_id='{$categories_id}'";
//        if(!empty($subcategories)){
//            $w = "cr.categories_id in (". implode(',', $subcategories) .")";
//        }
//
//        $join = [];
//        if(!empty($selected)){
//
//            foreach ($selected as $features_id => $values) {
//                if(empty($values)) continue;
//
//                $in = implode(',', $values);
//                $join[] = "join __content_features cf{$features_id} on cf{$features_id}.content_id=cr.content_id and cf{$features_id}.features_id = {$features_id} and cf{$features_id}.values_id in ({$in}) ";
//            }
//        }
//
//        $j = empty($join) ? null : implode('', $join);
//
//        return self::$db
//            ->select("
//              select count(cf.id) as t
//              from __content_relationship cr
//              join __content_features cf on cf.content_id=cr.content_id and cf.values_id={$values_id}
//              join __content c on c.id=cf.content_id and c.status = 'published'
//              {$j}
//              where {$w}
//              ")
//            ->row('t');
//    }

    /**
     * @return array|null
     */
    public function getSelected()
    {
        $res = []; $qs_url = null;

        if(empty($this->selected_features)){
            return null;
        }

        if(!empty($_GET)){
            $qs = http_build_query($_GET);
            $qs_url = '?' . $qs;
        }

        foreach ($this->selected_features as $fc => $a) {

            if($fc == 'manufacturer') continue;

            if(empty($a)){
                continue;
            }

            foreach ($a as $k=>$vid) {
                $url = $this->category_id ;
                $name = "";

                $sp = $this->selected_features;

                if(isset($sp[$fc])){
                    $k = array_search($vid, $sp[$fc]);
                    if($k !== false){
                        $name = $this->features->getName($vid);
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

    /**
     * @param $parent_id
     * @return array
     */
    private function subCategories($parent_id)
    {
        $in = [];
        foreach (self::$db->select("select id, isfolder from __content where parent_id={$parent_id}")->all() as $item)
        {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->subCategories($item['id']));
            }
        }
        return $in;
    }
}