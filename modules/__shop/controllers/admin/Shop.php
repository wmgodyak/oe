<?php

namespace modules\shop\controllers\admin;
use system\core\DataFilter;
use system\Backend;
use system\models\Permissions;

/**
 * Class shop
 * @package modules\shop\controllers\admin
 */
class Shop extends Backend
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * @throws \system\core\exceptions\Exception
     */
    public function init()
    {
        $this->assignToNav($this->t('shop.action_index'), 'module/run/shop', 'fa-shopping-cart', null, 30);

        $this->assignToNav($this->t('shop.categories.action_index'), 'module/run/shop/categories', 'fa-shopping-cart', 'module/run/shop');
        $this->assignToNav($this->t('shop.products.action_index'), 'module/run/shop/products', 'fa-shopping-cart', 'module/run/shop');

//        if(Permissions::canModule('shop', 'import')){
//            $this->assignToNav($this->t('shop.import.action_index'), 'module/run/shop/import', 'fa-shopping-cart', 'module/run/shop');
//        }

        if(Permissions::canModule('shop', 'kits')){
            $this->assignToNav($this->t('shop.kits.action_index'), 'module/run/shop/kits', null, 'module/run/shop');
        }

        $this->template->assignScript("modules/shop/js/admin/shop.js");

        $this->categories('init');
        $this->accessories('init');

        DataFilter::add('nav.items.content_types', function($types){
           $types[] = 'products_categories';
            return $types;
        });
    }

    public function index($parent_id=0)
    {
        return $this->products();
    }

    public function create()
    {
    }

    public function edit($id)
    {

    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }

    public function categories()
    {
        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Categories();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function products()
    {
        include "Products.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Products();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function prices()
    {
        include "Prices.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Products();

        return call_user_func_array(array($controller, $action), $params);
    }
    public function kits()
    {
        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Kits();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function import()
    {
        include "Import.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Import();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function accessories()
    {
        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new categories\Accessories();

        return call_user_func_array(array($controller, $action), $params);
    }
}