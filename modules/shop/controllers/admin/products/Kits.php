<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.08.16 : 14:59
 */

namespace modules\shop\controllers\admin\products;

use system\Engine;

defined("CPATH") or die();

/**
 * Class Kits
 * @package modules\shop\controllers\admin\products
 */
class Kits extends Engine
{
    private $kits;

    public function __construct()
    {
        parent::__construct();

        $this->kits = new \modules\shop\models\admin\products\Kits();
    }

    public function init()
    {
        parent::init();
    }

    public function index()
    {
        return $this->template->fetch('modules/shop/products/kits/index');
    }

    public function create($products_id = null)
    {
        if(! $products_id) die;

        if($this->request->post('action')){
            $this->response->body(['s' => $this->kits->create(), 'items' => $this->kits->get($products_id)])->asJSON();
            return;
        }

        $this->template->assign('products_id', $products_id);

        $this->response->body($this->template->fetch('modules/shop/products/kits/create'));
    }

    public function get($products_id)
    {
        $this->response->body(['items' => $this->kits->get($products_id)])->asJSON();
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function products($id)
    {
        $this->template->assign('kits_id', $id);
        $this->response->body($this->template->fetch('modules/shop/products/kits/products'));
    }

    /**
     *
     */
    public function searchProducts()
    {
        $q = $this->request->post('q', 's');

        $items = [];
        if(!empty($q)){
            $items = $this->kits->products->searchProducts($q);
            foreach ($items as $k=>$item) {
                $items[$k]['text'] = "#{$item['id']} {$item['name']}";
            }
        }

        $res = array(
            'total_count'        => $this->kits->products->searchTotal(),
            'incomplete_results' => false,
            'results'            => $items
        );

        echo json_encode($res);
    }

    public function addProduct()
    {
        $kits_id = $this->request->post('kits_id', 'i');
        $products_id = $this->request->post('products_id', 'i');

        if($kits_id && $products_id){
            $s = $this->kits->products->create($kits_id, $products_id);
            if($s){
                $this->getProducts($kits_id);
            }
        }
    }

    public function getProducts($kits_id)
    {
        $this->response->body(['items' => $this->kits->products->get($kits_id)])->asJSON();
    }

    public function deleteProduct($id, $kits_id)
    {
        if($kits_id && $id){
            $s = $this->kits->products->delete($id);
            if($s){
                $this->getProducts($kits_id);
            }
        }
    }

    public function delete($id, $products_id=null)
    {
        $s = $this->kits->delete($id);
        if($s){
            $this->response->body(['items' => $this->kits->get($products_id)])->asJSON();
        }
    }

    public function setDiscount()
    {
        $s = $this->kits->products->setDiscount();
        $this->response->body(['s' => $s])->asJSON();
    }

    public function process($id){}
}