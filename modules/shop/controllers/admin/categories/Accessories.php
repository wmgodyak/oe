<?php
namespace modules\shop\controllers\admin\categories;

use system\core\EventsHandler;
use system\Engine;

/**
 * Class Accessories
 * @package modules\shop\controllers\admin\categories
 */
class Accessories extends Engine
{
    private $accessories;
    private $categoryFeatures;

    public function __construct()
    {
        parent::__construct();

        $this->accessories = new \modules\shop\models\admin\categories\Accessories();
        $this->categoryFeatures = new \modules\shop\models\admin\categories\Features();
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('content.main.after', [$this, 'index']);
    }

    public function index()
    {
        return $this->template->fetch('shop/categories/accessories/index');
    }

    public function searchCategories()
    {
        $q = $this->request->post('q', 's');

        $where =[]; $items = [];

        if(!empty($q)){
            $q = explode(' ', $q);
            foreach ($q as $k=>$v) {
                $v = trim($v);
                if(empty($v)) continue;

                $where[] = " ((i.name like '%{$v}%') or (c.id like '{$v}%') )";
            }
        }

        if(!empty($where)){
            $items = $this->accessories->searchCategories($where);
            foreach ($items as $k=>$item) {
                $items[$k]['text'] = "#{$item['id']} {$item['name']}";
            }
        }


        $res = array(
            'total_count' => $this->accessories->searchTotal(),
            'incomplete_results' => false,
            'results' => $items
        );

        echo json_encode($res);
    }

    public function create()
    {
        $s = 0;$items = [];

        $products_categories_id = $this->request->post('products_categories_id', 'i');
        $categories_id          = $this->request->post('categories_id', 'i');

        if($products_categories_id && $categories_id) {
            $s = $this->accessories->create($products_categories_id, $categories_id);

            if($s){
                $items = $this->accessories->getCategories($products_categories_id);
            }
        }

        $this->response->body(['s' => $s, 'items' => $items])->asJSON();
    }

    public function getCategories()
    {
        $products_categories_id = $this->request->post('products_categories_id', 'i');
        if( ! $products_categories_id) return null;

        $items = $this->accessories->getCategories($products_categories_id);
        $this->response->body(['items' => $items])->asJSON();
    }

    public function edit($id)
    {
        $categories_id = $this->request->post('categories_id', 'i');
        // select categories features
        $features = $this->categoryFeatures->get(0, $categories_id);
        $this->template->assign('features', $features);

        $this->response->body($this->template->fetch('shop/categories/accessories/edit'));
    }

    public function delete($id)
    {
        if(! $this->accessories->delete($id)) return null;

        $products_categories_id = $this->request->post('products_categories_id', 'i');
        if( ! $products_categories_id) return null;

        $items = $this->accessories->getCategories($products_categories_id);
        $this->response->body(['items' => $items])->asJSON();
    }

    public function createFeatures()
    {
        $features_id = $this->request->post('features_id', 'i');
        $products_accessories_id = $this->request->post('products_accessories_id', 'i');
        if($features_id && $products_accessories_id){
            $s = $this->accessories->features->create($products_accessories_id, $features_id);
            if($s){
                $items = $this->accessories->features->get($products_accessories_id);
                $this->response->body(['items' => $items])->asJSON();
            }
        }
    }

    public function getFeatures()
    {
        $products_accessories_id = $this->request->post('products_accessories_id', 'i');
        if($products_accessories_id){
            $items = $this->accessories->features->get($products_accessories_id);
            $this->response->body(['items' => $items])->asJSON();
        }
    }

    public function deleteFeatures($id)
    {
        $s = $this->accessories->features->delete($id);
        if($s){
            $this->getFeatures();
        }
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}