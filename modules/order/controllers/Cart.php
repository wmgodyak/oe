<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:39
 */

namespace modules\order\controllers;

use modules\shop\models\products\Prices;
use system\core\Session;
use system\Front;

defined("CPATH") or die();

/**
 * Class Cart
 * @package modules\order\controllers
 */
class Cart extends Front
{
    public function add()
    {
        $products_id = $this->request->post('products_id', 'i');
        $variants_id = $this->request->post('variants_id', 'i');
        $quantity    = $this->request->post('quantity', 'i');

        $cart = Session::get('cart');

        if(isset($cart[$products_id])) return;

        $cart[$products_id] =
            [
                'products_id'  => $products_id,
                'variants_id'  => $variants_id,
                'quantity'     => $quantity,
                'has_variants' => $variants_id > 0
            ];

        Session::set('cart', $cart);
        echo 1;
    }

    public function edit(){}

    public function delete(){}

    public function getTotal()
    {
        $amount = 0; $total = 0;
        $cart = Session::get('cart'); $user = Session::get('user');
        $group_id = isset($user['group_id']) ? $user['group_id'] : 20;

        if(!empty($cart)){
            $prices = new Prices();
            foreach ($cart as $item) {
                $total  += $item['quantity'];
                $amount += $prices->get($item['products_id'], $group_id);
            }
        }

        $this->response->body(['amount' => $amount, 'total' => $total])->asJSON();
    }
}