<?php

namespace modules\productsSimilar\models;
use system\models\Model;
use system\models\ContentRelationship;

/**
 * Class ProductsSimilar
 * @package modules\productsSimilar\models
 */
class ProductsSimilar extends Model
{
    private $relations;

    public function __construct()
    {
        parent::__construct();

        $this->relations = new ContentRelationship();
    }

    public function getProducts($product)
    {
        $categories_id = $this->relations->getMainCategoriesId($product['id']);
        $features = self::$db
            ->select("
                select ps.features_id as id, i.name
                from __products_similar ps
                join __features_info i on i.features_id=ps.features_id and i.languages_id={$this->languages_id}
                where ps.categories_id={$categories_id}
            ")
            ->all();

        if(empty($features)) return null;

        foreach ($features as $k=>$feature) {
            $features[$k]['products'] = self::$db
                ->select("
              select c.id, c.sku, i.name, cf.values_id, fi.name as values_name
              from __content_relationship cr
              join __content c on c.id=cr.content_id and c.in_stock = 1 and c.status='published'
              join __content_features cf on cf.features_id = '{$feature['id']}' and cf.content_id=c.id
              join __features_info fi on fi.features_id=cf.values_id and fi.languages_id='{$this->languages_id}'
              join __content_info i on i.content_id=c.id
              where cr.categories_id = {$categories_id}
             ")
                ->all();
        }

        return $features;
    }
}