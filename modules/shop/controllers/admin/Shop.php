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
    public function __construct()
    {
        parent::__construct();
        
//        $this->form_action = "module/run/shop/process/";
//        $this->products       = new Products('product');
//        $this->categories  = new \modules\shop\models\Categories('products_categories');
//        $this->relations   = new ContentRelationship();

        // hide custom block
//        $this->form_display_blocks['content'] = false;
//        $this->form_display_params['parent'] = false;
    }


    public function init()
    {
        $this->assignToNav('Магазин', 'module/run/shop', 'fa-shopping-cart');
        // add support sub nav
        $this->assignToNav('Товари', 'module/run/shop/products', 'fa-shopping-cart', 'module/run/shop');
        $this->assignToNav('Категорії', 'module/run/shop/categories', 'fa-shopping-cart', 'module/run/shop');

//        $this->template->assignScript("modules/shop/js/admin/shop.js");
//        $this->template->assignScript("modules/shop/js/admin/bootstrap-tagsinput.min.js");
//        EventsHandler::getInstance()->debug();
//        EventsHandler::getInstance()->add('content.params', [$this, 'contentParams']);
//        EventsHandler::getInstance()->add('content.process', [$this, 'contentProcess']);
//        EventsHandler::getInstance()->add('dashboard', [$this, 'dashboard']);
//        EventsHandler::getInstance()->add('content.process', [new Tags(), 'process']);
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
}