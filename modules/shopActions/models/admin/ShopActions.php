<?php
namespace modules\shopActions\models\admin;

use system\models\ContentMeta;
use system\models\ContentRelationship;
use system\models\Model;

/**
 * Class ShopActions
 * @package modules\shopActions\models\admin
 */
class ShopActions extends Model
{
    public $meta;
    public $relations;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new ContentMeta();
        $this->relations = new ContentRelationship();
    }

    /**
     * @param $q
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function searchProducts($q)
    {
        $where = [];
        $q = explode(' ', $q);
        foreach ($q as $k=>$v) {
            $v = trim($v);
            if(empty($v)) continue;

            $where[] = " ((i.name like '%{$v}%') or (c.sku like '{$v}%') )";
        }

        $w = implode('and ', $where);

        return self::$db
            ->select("
                select SQL_CALC_FOUND_ROWS c.id, i.name
                from __content c
                join __content_types ct on ct.type='product' and ct.id=c.types_id
                join __content_info i on i.content_id=c.id and i.languages_id='{$this->languages_id}'
                where {$w}  and c.status ='published'
            ")
            ->all();
    }

    public function searchTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }

    public function markProducts($actions_id, $action)
    {
        $products = [];

        $categories = $this->relations->getCategories($actions_id, null, 'sa_categories');
        if(!empty($categories)){
            $in = [];
            foreach ($categories as $k=>$category_id) {
                $in[] = $category_id;
                $in = array_merge($in, $this->getSubcategoriesId($category_id));
            }

            $products = $this->getProductsId($in);
        }

        $p_in = $this->relations->getCategories($actions_id, null, 'sa_products');
        if(!empty($p_in)){
            $products = array_merge($products, $p_in);
        }
        if(!empty($products)){

            foreach ($products as $product) {
                if($action == 1){
                    $this->meta->update($product['id'], 'sa_action', $action);
                } else {
                    $this->meta->delete($product['id'], 'sa_action', $action);
                }
            }
        }
    }

    private function getProductsId($categories)
    {
        $in = implode(',', $categories);

        return self::$db
            ->select("
                  select c.id
                  from __content c
                  join __content_relationship crm on crm.content_id=c.id and crm.categories_id in ({$in})
                  join __content_types ct on ct.type = 'product' and ct.id=c.types_id
                  where c.status ='published'
                  ")
            ->all();
    }

    public function getSubcategoriesId($parent_id)
    {
        $in = [];

        $r = self::$db->select("select id, isfolder from __content where parent_id={$parent_id} and status='published'")->all();

        if(empty($r)) return $in;

        foreach ($r as $item) {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->getSubcategoriesId($item['id']));
            }
        }

        return $in;
    }
}