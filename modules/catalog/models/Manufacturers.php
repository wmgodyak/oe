<?php

namespace modules\catalog\models;

use system\core\DB;
use system\core\Languages;
use system\core\Request;

/**
 * Class Manufacturers
 * @package modules\catalog\models
 */
class Manufacturers
{
    private $types_id;
    private $url;
    private $category;

    private $config;
    private $db;
    private $languages;
    private $request;

    public function __construct($config, $category, Request $request)
    {
        $this->db = DB::getInstance();
        $this->languages = Languages::getInstance();

        $this->request = $request;

        $this->config = $config;

        $this->category = $category;

        $this->url = $request->param('url');

        $this->types_id = $this->db
            ->select("select id from __content_types where parent_id=0 and type='{$config->type->manufacturer}' limit 1")
            ->row('id');

    }

    public function get()
    {
        $r = $this->db
            ->select("
              select c.id, i.url, i.name 
              from __content c
              join __content_info i on i.content_id = c.id and i.languages_id={$this->languages->id}
              where c.types_id = {$this->types_id} and c.status = 'published'
              order by i.name asc
            ")
            ->all();

        $res = [];

        foreach ($r as $item) {
            $item['url'] = $this->makeUrl($item);
            $item['total'] = $this->totalProducts($item);
            $res[] = $item;
        }

        return $res;
    }

    private function makeUrl($manufacturer)
    {
        // http://shop.engine.loc/clothing/filter/aaaa-14;bbbb-18;manufacturer-acer,apple
        if(strpos($this->url, 'manufacturer') === false){
            return $this->url .'/filter/manufacturer-'. $manufacturer['url'];
        }

        $a = explode(';manufacturer-', $this->url);

        $url = $a[0];

        $b = explode(',', $a[1]);

        if(in_array($manufacturer['url'], $b)){
            $b = array_filter($b, function($v) use ($manufacturer){
                return $v != $manufacturer['url'];
            });

            if(empty($b)){
                return $url;
            }

            return $url .';manufacturer-' . implode(',', $b);
        }

        $c = [];
        $c[] = $a[1];
        $c[] = $manufacturer['url'];

        $c = implode(',', $c);

        return $url .';manufacturer-'. $c;
    }

    private function totalProducts($manufacturer)
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

                    continue;
                }

                $features_id = $this->db->select("select id from __features where code = '{$code}' limit 1")->row('id');

                if(empty($features_id) || empty($values)) continue;

                $this->category->products->join("join __content_features cf{$features_id} on
                    cf{$features_id}.content_id=c.id
                and cf{$features_id}.features_id = {$features_id}
                and cf{$features_id}.values_id in (". implode(',', $values) .")
                ");

            }

        }

        if(empty($manufacturers_in)){
            $manufacturers_in[] = $manufacturer['id'];
        }

        $this->category->products->where(" and p.manufacturers_id = '{$manufacturer['id']}' ");

        $t = $this->category->products->total();
        $this->category->products->clear();

        return $t['total'];
    }

    /**
     * @param $url
     * @return array|mixed
     */
    public function getId($url)
    {
        return $this->db->select("select content_id as id from __content_info where url = '$url' and languages_id = '{$this->languages->id}' limit 1")->row('id');
    }
}