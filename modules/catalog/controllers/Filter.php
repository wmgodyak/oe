<?php

namespace modules\catalog\controllers;
use modules\catalog\models\CategoriesFeatures;
use modules\catalog\models\Manufacturers;
use system\core\DB;
use system\core\Request;
use system\models\Features;

/**
 * Class CategoryFilter
 * @package modules\catalog\controllers
 */
class Filter
{
    private $category;
    private $language;
    private $request;
    private $category_id;
    private $categoryFeatures;

    private $minp;
    private $maxp;

    private $manufacturers;
    private $db;

    /**
     * Filter constructor.
     * @param $category
     * @param Request $request
     * @param \modules\catalog\models\Category $categoryModel
     * @param $language
     * @param Manufacturers $manufacturers
     */
    public function __construct($category, Request $request, \modules\catalog\models\Category $categoryModel, $language, Manufacturers $manufacturers)
    {
        $this->category_id = $category['id'];
        $this->request     = $request;
        $this->category    = $categoryModel;
        $this->language    = $language;

        $this->db = DB::getInstance();

        $this->categoryFeatures    = new CategoriesFeatures(new Features(), $this->language, $categoryModel, $category);

        $this->manufacturers = $manufacturers;

        $this->parseGetParams();

        $this->byPrice();
        $this->byFeatures();
        $this->byManufacturers();
     }

    /**
     * @return array|null
     */
    private function parseGetParams()
    {
        $filter = $this->request->param('filter');
        if(empty($filter)) return null;

        d($filter);

        $selected = []; $manufacturers = [];

        $a = explode(';', $filter);
        foreach ($a as $k=>$f) {
            $b = explode('-', $f);
            if(!isset($b[1]) || empty($b[1])) continue;

            if($b[0] == 'manufacturer') {

                $a = explode(',', $b[1]);
                foreach ($a as $i=>$v) {
                    $manufacturer = $this->db->select("select content_id as id, name from __content_info where url = '$v' and languages_id = '{$this->language->id}' limit 1")->row();
                    if(empty($manufacturer)) continue;

                    $manufacturers[] = $manufacturer;
                }

                continue;
            }

            $feature = $this->db->select("select f.id, f.code,i.name
                                              from __features f 
                                              join __features_info i on i.features_id=f.id and i.languages_id = '{$this->language->id}'
                                              where f.code like '{$b[0]}'
                                               limit 1
                                              ")->row();

            if(empty($feature)) continue;

            $a = explode(',', $b[1]);

            foreach ($a as $i=>$v) {
                $v = (int)$v;
                $feature['values'][] = $this->db->select("select f.id, f.code, i.name
                                              from __features f 
                                              join __features_info i on i.features_id=f.id and i.languages_id = '{$this->language->id}'
                                              where f.id = '{$v}'
                                               limit 1
                                              ")->row();
            }

            $selected[] = $feature;
        }

        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');
        $prices = ['minp' => $minp, 'maxp' => $maxp];

        $this->request->param('filtered_features', $selected);
        $this->request->param('filtered_manufacturers', $manufacturers);
        $this->request->param('filtered_prices', $prices);

        d($selected); d($manufacturers); d($prices);
    }

    /**
     * set filter by price
     */
    private function byPrice()
    {
        $prices = $this->request->param('filtered_prices');

        if($prices['minp'] > 0 && $prices['maxp'] > 0) {
            $this->category->products->where(" and price between {$prices['minp']} and {$prices['maxp']}");
        } elseif($prices['minp'] > 0 && $prices['maxp'] == 0){
            $this->category->products->where(" and price > {$prices['minp']}");
        } elseif($prices['minp'] == 0 && $prices['maxp'] > 0){
            $this->category->products->where(" and price < {$prices['maxp']}");
        }

    }

    private function byFeatures()
    {
        $selected = $this->request->param('filtered_features');

        if(empty($selected)) return;

        foreach ($selected as $feature) {
            $values = [];
            foreach ($feature['values'] as $value) {
                $values[] = $value['id'];
            }

            $this->category->products->join("join __content_features cf{$feature['id']} on
                    cf{$feature['id']}.content_id=c.id
                and cf{$feature['id']}.features_id = {$feature['id']}
                and cf{$feature['id']}.values_id in (". implode(',', $values) .")
                ");
        }
    }

    /**
     * @return mixed
     */
    public function features()
    {
        return $this->categoryFeatures->get($this->category_id);
    }
//
//    public function selectedFeatures()
//    {
//        return $this->categoryFeatures->getSelected();
//    }

    /**
     * @param null $price
     * @return null
     */
    public function minPrice($price = null)
    {
        if($price) $this->minp = $price;

        return $this->minp;
    }

    /**
     * @param null $price
     * @return null
     */
    public function maxPrice($price = null)
    {
        if($price) $this->maxp = $price;

        return $this->maxp;
    }

    public function manufacturers()
    {
        return $this->manufacturers->get();
    }

    private function byManufacturers()
    {
        $manufacturers = $this->request->param('filtered_manufacturers');

        if(empty($manufacturers)) return;

        $in = [];
        foreach ($manufacturers as $manufacturer) {

            $in[] = $manufacturer['id'];
        }

        if(empty($in)) return ;

        $in = implode(', ', $in);
        $this->category->products->where(" and p.manufacturers_id in ($in) ");
    }
}