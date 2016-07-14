<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:37
 */

namespace modules\order\controllers;

use system\Front;

defined("CPATH") or die();

class Order extends Front
{
    public $cart;

    public function __construct()
    {
        parent::__construct();

        $this->cart = new Cart();
    }

    public function init()
    {
        $this->template->assignScript('modules/order/js/order.js');
    }

    public function checkout()
    {

    }

    public function ajaxCart()
    {
        $params = func_get_args();
        $action = 'index';

        if(!empty($params)){
            $action = array_shift($params);
        }

        return call_user_func_array(array($this->cart, $action), $params);
    }
}