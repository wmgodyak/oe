<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:39
 */

namespace modules\order\controllers;

use modules\order\models\cart\Kits;
use modules\order\models\cart\Products;
use system\core\Session;
use system\Front;

defined("CPATH") or die();

/**
 * Class Cart
 * @package modules\order\controllers
 */
class Cart extends Front
{
    public $products;
    public $kits;

    public function __construct()
    {
        parent::__construct();

        $this->products = new Products();
        $this->kits     = new Kits();

//        d($_SESSION);die;
    }

    public function clear()
    {
        Session::delete('cart');
    }

    /**
     * @param $adapter
     */
    public function add($adapter)
    {
        $s = $this->{$adapter}->add();
        $this->response->body(['s' => $s])->asJSON();
    }

    /**
     * @param $adapter
     */
    public function update($adapter)
    {
        $s = $this->{$adapter}->update();
        $this->response->body(['s' => $s, 'products' => $this->products(), 'kits' => $this->kits()])->asJSON();
    }

    /**
     * @param $adapter
     */
    public function delete($adapter)
    {
        $s = $this->{$adapter}->delete();
        $this->response->body(['s' => $s, 'products' => $this->products(), 'kits' => $this->kits()])->asJSON();
    }

    public function products()
    {
        return $this->products->items();
    }

    public function kits()
    {
        return $this->kits->items();
    }

    public function total()
    {
        $amount = 0; $total = 0;

        // total products in cart
        $p_total = $this->products->total();
        $amount += $p_total['amount'];
        $total  += $p_total['total'];

        $this->response->body(['amount' => $amount, 'total' => $total])->asJSON();
    }
}