<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\shop\controllers;

use system\Front;

/**
 * Class shop
 * @package modules\shop\controllers
 */
class Shop extends Front
{
    private $products;
    private $categories;

    public function __construct()
    {
        parent::__construct();

//        $this->products   = new Products('product');
//        $this->categories = new Categories('products_categories');
    }

    public function index()
    {
    }

    public function init()
    {
    }

    public function categories()
    {
        return $this->categories->get();
    }

    public function products()
    {
        $products = $this->products->get();
        return $products;
    }
}