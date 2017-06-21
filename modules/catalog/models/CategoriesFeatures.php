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
    public  $features;
    public  $category;
    private $current_category;

    public function __construct(Features $features, $languages, $category, $current_category)
    {
        parent::__construct();

        $this->features    = $features;
        $this->languages   = $languages;

        $this->category = $category;

        $this->current_category = $current_category;
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

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($categories_id);
            } else{
                $items[$k]['values'] = $this->getValues($item, $categories_id);
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
    private function getValues($feature, $categories_id)
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

        $filtered = $this->request->param('filtered_features');

        foreach ($items as $k=>$item) {
            $active = false;

            if(!empty($filtered)){
                foreach ($filtered as $ff) {
                    foreach ($ff['values'] as $fv) {
                        if($fv['id'] == $item['id']) $active = true;
                    }
                }
            }

            $items[$k]['active'] = $active;
            $items[$k]['url']    = $this->makeUrl($feature, $item, $categories_id);
            $items[$k]['total']  = $this->totalProducts($feature, $item);
        }

        return $items;
    }

    /**
     * @param $feature
     * @param $value
     * @return string
     */
    private function makeUrl($feature, $value)
    {
        $url = $this->request->param('category_url');

        $used = false;

        $filtered = $this->request->param('filtered_features');

        $f_url = [];

        if(!empty($filtered)){

            foreach ($filtered as $ff) {
                $fuv = [];
                foreach ($ff['values'] as $fv) {

                    if($fv['id'] == $value['id']) {
                        $used = true;
                        continue;
                    }
                    $fuv[] = $fv['id'];
                }

                if(empty($fuv)) continue;

                $f_url[$ff['code']] = $fuv;
            }
        }

        if( !$used ){
            if(!isset($f_url[$feature['code']])) {
                $f_url[$feature['code']] = [];
            }
            $f_url[$feature['code']][] = $value['id'];
        }

        // manufacturers
        $manufacturers = $this->request->param('filtered_manufacturers');

        if(!empty($manufacturers)){

            $in = [];
            foreach ($manufacturers as $manufacturer) {

                $in[] = $manufacturer['url'];
            }

            if(! empty($in)){
                $f_url['manufacturer'] = $in;
            }
        }

        // build url

        if(!empty($f_url)){
            $url .= "/filter/";
            foreach ($f_url as $code => $values) {
                $url .= "$code-" . implode(',', $values) . ';';
            }
        }

        $url = rtrim($url, ';');

        // prices
        $prices = $this->request->param('filtered_prices');

        if(!empty($prices['minp']) || !empty($prices['maxp'])){
            $url .= "?minp={$prices['minp']}&maxp={$prices['maxp']}";
        }

        return $url;
    }

    private function totalProducts($feature, $value)
    {
//        $this->category->products->debug();
        $this->category->products->clear();

        $this->category->products->category($this->category_id);

        $selected = $this->request->param('filtered_features');

        if(!empty($selected)){

            foreach ($selected as $feat) {
                if($feat['id'] == $feature['id']) continue;

                $values = [];
                foreach ($feat['values'] as $v) {
                    $values[] = $v['id'];
                }

                $this->category->products->join("
                join __content_features cf{$feat['id']} on
                    cf{$feat['id']}.content_id=c.id
                and cf{$feat['id']}.features_id = {$feat['id']}
                and cf{$feat['id']}.values_id in (". implode(',', $values) .")
                ");
            }
        }

        $this->category->products->join("
                        join __content_features cf{$feature['id']} on
                            cf{$feature['id']}.content_id=c.id
                        and cf{$feature['id']}.features_id = {$feature['id']}
                        and cf{$feature['id']}.values_id = {$value['id']}
                        ");



        $prices = $this->request->param('filtered_prices');

        if($prices['minp'] > 0 && $prices['maxp'] > 0) {
            $this->category->products->where(" and price between {$prices['minp']} and {$prices['maxp']}");
        } elseif($prices['minp'] > 0 && $prices['maxp'] == 0){
            $this->category->products->where(" and price > {$prices['minp']}");
        } elseif($prices['minp'] == 0 && $prices['maxp'] > 0){
            $this->category->products->where(" and price < {$prices['maxp']}");
        }

        $manufacturers = $this->request->param('filtered_manufacturers');

        if(!empty($manufacturers)){

            $in = [];
            foreach ($manufacturers as $manufacturer) {

                $in[] = $manufacturer['id'];
            }

            if(! empty($in)){
                $in = implode(', ', $in);
                $this->category->products->where(" and p.manufacturers_id in ($in) ");
            }
        }

        $t = $this->category->products->total();
        $this->category->products->clear();

        return $t['total'];
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

    /**
     * @return array|null
     */
    private function getSelected()
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