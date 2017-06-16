<?php

namespace modules\catalog\controllers;
use modules\catalog\models\CategoriesFeatures;
use system\core\Request;
use system\models\Features;

/**
 * Class CategoryFilter
 * @package modules\catalog\controllers
 */
class CategoryFilter
{
    private $category;
    public  $features;

    public function __construct($category, $language)
    {
        $this->category = $category;

        $this->features = new CategoriesFeatures(new Features(), $language);

     }

    public function make(Request $request)
    {
        $minp = $request->get('minp', 'i');
        $maxp = $request->get('maxp', 'i');

//        $this->category->products->debug();

        if($minp > 0 && $maxp > 0) {
            $this->category->products->where(" and price between {$minp} and {$maxp}");
        } elseif($minp > 0 && $maxp == 0){
            $this->category->products->where(" and price > {$minp}");
        } elseif($minp == 0 && $maxp > 0){
            $this->category->products->where(" and price < {$maxp}");
        }

    }

}