<?php

namespace modules\shop\models\products;

use modules\shop\models\Products;
use system\core\Session;
use system\models\ContentFeatures;
use system\models\Model;

/**
 * Class Comparison
 * @package modules\shop\models\products
 */
class Comparison extends Model
{
    /**
     * @return null
     */
    public function add()
    {
        $categories_id = $this->request->post('categories_id', 'i');
        $products_id = $this->request->post('products_id', 'i');

        if(empty($categories_id) || empty($products_id)) return;
        $cat = Session::get('comparison');

        if(isset($cat[$products_id])) return;

        $cat[$products_id] =
            [
                'products_id'    => $products_id,
                'categories_id'  => $categories_id
            ];

        $_SESSION['comparison'] = $cat;

        echo 1;
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $com = Session::get('comparison');

        if(isset($com[$id])) unset($com[$id]);

        $_SESSION['comparison'] = $com;

        return true;
    }

    public function getFeatures($categories_id)
    {
        $categories_id = (int)$categories_id;
        if(empty($categories_id)) return null;

        $cf = new ContentFeatures();

        return $cf->get($categories_id);
    }

    public function getProducts($categories_id)
    {
        $categories_id = (int)$categories_id;
        $com = Session::get('comparison');

        $in = [];
        foreach ($com as $item) {
            if($item['categories_id'] == $categories_id){
                $in[] = $item['products_id'];
            }
        }

        if(empty($in)) return null;

        $p = new Products();
        $p->where(" c.id in (". implode(',', $in) .")");

        $products = $p->get();

        $features = new \modules\shop\models\products\Features();

        foreach ($products as $k=>$product) {
            $products[$k]['features'] = $features->get($product['id']);
        }

        return $products;
    }

    public function getCategories()
    {
        $com = Session::get('comparison');
        if(empty($com)) return null;

        $in = [];
        foreach ($com as $item) {
            if(!in_array($item['categories_id'], $in)){
                $in[] = $item['categories_id'];
            }
        }

        if(empty($in)) return null;

        $in = implode(',', $in);

        $items =  self::$db->select("
          select c.id, ci.name, ci.title
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.id in ({$in}) and c.status ='published'
          order by ci.name asc
          ")->all();

        return $items;
    }
}