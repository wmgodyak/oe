<?php

namespace modules\categorySynonym\controllers;

use system\core\DataFilter;
use system\Front;
use system\models\ContentRelationship;

/**
 * Class CategorySynonym
 * @name Синонім для категорій
 * @description Дозволяє створювати категорії які можуть унаслідувати властивості від інших категорій
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\categorySynonym\controllers
 */
class CategorySynonym extends Front
{
    public function init()
    {
//        $content_id = $this->page['id'];
//        DataFilter::add
//        (
//            'module.shop.products.categories_in',
//            function($in) use ($content_id)
//            {
//                $relations = new ContentRelationship();
//                $in += $relations->getCategories($content_id);
//
//                return $in;
//            }
//        );
        DataFilter::add
        (
            'module.shop.products.categories_id',
            function($categories_id)
            {

                $relations = new ContentRelationship();
                $a = $relations->getCategories($categories_id);
                if(!empty($a)){
                    $categories_id = end($a);
                }

                return $categories_id;
            }
        );
    }
}