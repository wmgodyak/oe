<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.07.16 : 16:23
 */

namespace modules\wishlist\controllers;

use system\core\Session;
use system\Front;

defined("CPATH") or die();

/**
 * Class Wishlist
 * @package modules\wishlist\controllers
 */
class Wishlist extends Front
{
    private $wishlist;

    public function __construct()
    {
        parent::__construct();

        $this->wishlist = new \modules\wishlist\models\Wishlist();
    }

    public function init()
    {
        $this->template->assignScript('modules/wishlist/js/wishlist.js');
    }

    public function get()
    {
        return $this->wishlist->get();
    }

    public function index()
    {

    }

    public function add()
    {
        $products_id = $this->request->post('products_id', 'i');
        if(empty($products_id)) return 0;

        $wl = Session::get('wishlist');
        if( ! $wl){
            $wl[$products_id] = $products_id;
        }

        Session::set('wishlist', $wl);

        echo 1;
    }

    public function delete()
    {
        $products_id = $this->request->post('products_id', 'i');
        $wl = Session::get('wishlist');

        if(isset($wl[$products_id])) unset($wl[$products_id]);

        echo 1;
    }

}