<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.08.16 : 11:28
 */

namespace modules\shop\models\products;

use system\models\ContentRelationship;
use system\models\Model;

defined("CPATH") or die();

class Accessories extends Model
{
    private $relations;

    public function __construct()
    {
        parent::__construct();

        $this->relations = new ContentRelationship();
    }

    public function get($products_id)
    {
        $res = [];

        // 1. get main categories
       $products_categories_id = $this->relations->getMainCategoriesId($products_id);

        // 2. get accessories categories
        $categories = self::$db
            ->select("
                select pc.id, pc.categories_id, c.isfolder
                from __products_accessories pc
                join __content c on c.id = pc.categories_id
                where pc.products_categories_id = '{$products_categories_id}'
                ")
            ->all();

        // 3. check if categories has selected features
        foreach ($categories as $k=>$category) {
            $res[$k]['id'] = $category['categories_id'];
            $res[$k]['isfolder'] = $category['isfolder'];
            $a = self::$db
                ->select("select features_id, features_values from __products_accessories_features where products_accessories_id = '{$category['id']}'")
                ->all();

            if(! empty($a)){
                foreach ($a as $item) {
                    $res[$k]['features'][] = ['id' => $item['features_id'], 'values' => $item['features_values']];
                }
            }
        }

        return $res;
    }

    public function getSubcategoriesId($parent_id)
    {
        $in = [];

        $r = self::$db->select("select id, isfolder from __content where parent_id={$parent_id} and status='published'")->all();

        foreach ($r as $item) {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->getSubcategoriesId($item['id']));
            }
        }

        return $in;
    }
}