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

    // todo change it
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
        //        $this->category->products->debug();
        $this->category->products->clear();

        $this->category->products->category($this->request->param('category_id'));

        $selected = $this->request->param('filtered_features');

        if(!empty($selected)){

            foreach ($selected as $feat) {
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


        $prices = $this->request->param('filtered_prices');

        if($prices['minp'] > 0 && $prices['maxp'] > 0) {
            $this->category->products->where(" and price between {$prices['minp']} and {$prices['maxp']}");
        } elseif($prices['minp'] > 0 && $prices['maxp'] == 0){
            $this->category->products->where(" and price > {$prices['minp']}");
        } elseif($prices['minp'] == 0 && $prices['maxp'] > 0){
            $this->category->products->where(" and price < {$prices['maxp']}");
        }

        $this->category->products->where(" and p.manufacturers_id = {$manufacturer['id']} ");

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