<?php
namespace modules\shopActions\models;

use modules\shop\models\Products;
use system\models\ContentMeta;
use system\models\ContentRelationship;
use system\models\Model;

class ShopActions extends Model
{
    public $meta;
    public $relations;
    public $products;
    private $ipp = 15;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new ContentMeta();
        $this->relations = new ContentRelationship();
        $this->products = new Products();
        $this->products->clearQuery();
    }

    /**
     * @param $place
     * @param null $limit
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getBanners($place, $limit = null)
    {
        $n = date('Ymd');

        $limit = $limit ? " limit {$limit}" : '';
        $items = self::$db
            ->select("
              select c.id, img.meta_v as image,
                CONCAT('route/shopActions/click/', c.id) as url, cl.meta_v as clickable
              from __content c
              join __content_types ct on ct.id=c.types_id and ct.type='actions'
              join __content_meta xp  on xp.content_id=c.id and xp.meta_k='expired' and IF(xp.meta_v = '', {$n}, DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y%m%d')) >= {$n}
              join __content_meta p on p.content_id=c.id and p.meta_k='place' and p.meta_v='{$place}'
              join __content_meta img on img.content_id=c.id and img.meta_k='image_{$this->languages_id}'
              left join __content_meta pos on pos.content_id=c.id and pos.meta_k='position'
              join __content_meta cl  on cl.content_id=c.id and cl.meta_k='clickable'
              where c.status = 'published'
              -- order by abs(IF(pos.meta_v = '', 0 , pos.meta_v)) asc
              order by abs(pos.meta_v) asc, abs(c.id) desc
              {$limit}
            ")
            ->all();

        return $items;
    }

    /**
     * @param $current_id
     * @param null $limit
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function old($current_id, $limit = null)
    {
        $n = date('Ymd');

        $limit = $limit ? " limit {$limit}" : null;
        $items = self::$db
            ->select("
              select c.id, ci.name, img.meta_v as image,
                CONCAT('route/shopActions/click/', c.id) as url
              from __content c
              join __content_types ct on ct.id=c.types_id and ct.type='actions'
              join __content_meta xp  on xp.content_id=c.id and xp.meta_k='expired' and IF(xp.meta_v = '', {$n}, DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y%m%d')) >= {$n}
              join __content_meta img on img.content_id=c.id and img.meta_k='image_{$this->languages_id}'
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              left join __content_meta pos on pos.content_id=c.id and pos.meta_k='position'
              join __content_meta cl  on cl.content_id=c.id and cl.meta_k='clickable' and cl.meta_v = 1
              where c.status = 'published' and c.id <> '{$current_id}'
              order by abs(pos.meta_v) asc, abs(c.id) desc
              {$limit}
            ")
            ->all();

        return $items;
    }

    /**
     * @param $categories_id
     * @param null $limit
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function onCategory($categories_id, $limit = null)
    {
        $n = date('Ymd');

        $items = self::$db
            ->select("
              select c.id, ci.name, img.meta_v as image, CONCAT('route/shopActions/click/', c.id) as url,
               DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y/%m/%d') as expired,
               co.meta_v as counter
              from __content c
              join __content_relationship cr on cr.categories_id = '{$categories_id}' and cr.type = 'sa_categories' and cr.content_id=c.id
              join __content_types ct on ct.id=c.types_id and ct.type='actions'
              join __content_meta s  on s.content_id=c.id and s.meta_k='show_on_products' and s.meta_v = 1
              join __content_meta xp  on xp.content_id=c.id and xp.meta_k='expired' and IF(xp.meta_v = '', {$n}, DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y%m%d')) >= {$n}
              join __content_meta img on img.content_id=c.id and img.meta_k='image_{$this->languages_id}' and img.meta_v <> ''
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              join __content_meta cl  on cl.content_id=c.id and cl.meta_k='clickable' and cl.meta_v = 1
              join __content_meta co  on co.content_id=c.id and co.meta_k='counter'
              where c.status = 'published'
              order by abs(c.id) desc
            " . ($limit ? " limit {$limit}" : null)
            )
            ->all();

        if(empty($items)){
            $cat_parent_id = self::$db
                ->select("select parent_id from __content where id='{$categories_id}' limit 1")
                ->row('parent_id');
            if($cat_parent_id > 0){
                return $this->onCategory($cat_parent_id, $limit);
            }
        }

        return $items;
    }

    /**
     * @param $products_id
     * @param null $limit
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function onProduct($products_id, $limit = null)
    {
        $n = date('Ymd');

        $items = self::$db
            ->select("
              select c.id, img.meta_v as image, CONCAT('route/shopActions/click/', c.id) as url,
              IF(xp.meta_v = '', '', DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y/%m/%d'))  as expired,
              co.meta_v as counter, ci.name
              from __content c
              join __content_relationship cr on cr.categories_id = '{$products_id}' and cr.type = 'sa_products' and cr.content_id=c.id
              join __content_meta s  on s.content_id=c.id and s.meta_k='show_on_products_page' and s.meta_v = 1
              join __content_meta xp  on xp.content_id=c.id and xp.meta_k='expired' and IF(xp.meta_v = '', {$n}, DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y%m%d')) >= {$n}
              join __content_meta img on img.content_id=c.id and img.meta_k='image_{$this->languages_id}' and img.meta_v <> ''
              join __content_meta cl  on cl.content_id=c.id and cl.meta_k='clickable' and cl.meta_v = 1
              join __content_meta co  on co.content_id=c.id and co.meta_k='counter'
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              where c.status = 'published'
              order by abs(c.id) desc
            ". ($limit ? " limit {$limit}" : null)
            )
            ->all();

        if(empty($items)){
            $cat_id = $this->relations->getMainCategoriesId($products_id);
            if($cat_id > 0){
                return $this->onCategory($cat_id, $limit);
            }
        }

        return $items;
    }

    public function getProducts($start, $num)
    {
        $this->products->clearQuery();
        $this->products->join("join __content_meta sam on sam.content_id = c.id and sam.meta_k='sa_action' and sam.meta_v = 1");
        $this->products->start = $start;
        $this->products->num = $num;
        $this->products->where(" c.in_stock = 1");
        return $this->products->get();

    }

    /**
     * @param $actions_id
     * @return mixed|null
     */
    public function getProductsByAction($actions_id)
    {
        $start = (int) $this->request->get('p', 'i');
        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * $this->ipp;
        }

        $this->products->start = $start;
        $this->products->num = $this->ipp;
        $this->products->where(" c.in_stock = 1");

        $categories = $this->relations->getCategories($actions_id, null, 'sa_categories');
        if(!empty($categories)){
            $in = [];
            foreach ($categories as $k=>$category_id) {
                $in[] = $category_id;
                $in = array_merge($in, $this->getSubcategoriesId($category_id));
            }

            $this->products->categories_in = $in;
            return $this->products->get();
        }

        $p_in = $this->relations->getCategories($actions_id, null, 'sa_products');
        if(!empty($p_in)){
            $this->products->where(" c.in_stock = 1");
            $this->products->where(" c.id in (". implode(',', $p_in) .")");
            return $this->products->get();
        }

        return null;
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