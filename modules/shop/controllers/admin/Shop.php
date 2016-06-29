<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\shop\controllers\admin;
use system\Engine;

/**
 * Class shop
 * @package modules\shop\controllers\admin
 */
class Shop extends Engine
{
    public function init()
    {
        $this->assignToNav('Магазин', 'module/run/shop', 'fa-shopping-cart');

        $this->assignToNav('Категорії', 'module/run/shop/categories', 'fa-shopping-cart', 'module/run/shop');
        $this->assignToNav('Товари', 'module/run/shop/products', 'fa-shopping-cart', 'module/run/shop');

        $this->template->assignScript("modules/shop/js/admin/shop.js");

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
        include "Categories.php";

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
}