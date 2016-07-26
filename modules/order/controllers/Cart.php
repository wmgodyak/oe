<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:39
 */

namespace modules\order\controllers;

use modules\shop\models\Products;
use modules\shop\models\products\Prices;
use modules\shop\models\products\variants\ProductsVariantsPrices;
use system\core\Session;
use system\Front;

defined("CPATH") or die();

/**
 * Class Cart
 * @package modules\order\controllers
 */
class Cart extends Front
{
    public $prices;
    public $variantsPrices;
    public $products;

    public function __construct()
    {
        parent::__construct();

        $this->prices = new Prices();
        $this->variantsPrices = new ProductsVariantsPrices();
        $this->products = new Products('product');
    }

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

        $this->total();
    }

    public function update()
    {
        $id = $this->request->post('id', 'i');
        $quantity = $this->request->post('quantity', 'i');
        $cart = Session::get('cart');

        if(isset($cart[$id])){
            $cart[$id]['quantity'] = $quantity;
        }

        Session::set('cart', $cart);

        $this->response->body(['s' => 1, 'total' => $this->total(false), 'items' => $this->items()])->asJSON();
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $cart = Session::get('cart');

        if(isset($cart[$id])) unset($cart[$id]);

        Session::set('cart', $cart);

        $this->response->body(['s' => 1, 'total' => $this->total(false), 'items' => $this->items()])->asJSON();
    }

    public function items()
    {
        $cart = Session::get('cart'); $user = Session::get('user');
        $group_id = isset($user['group_id']) ? $user['group_id'] : 20;

        foreach ($cart as $k=>$item) {
            $cart[$k] += $this->products->getData($item['products_id']);
            $cart[$k]['img'] = $this->images->cover($item['products_id']);
            if($item['has_variants']){
                $cart[$k]['price'] = $this->variantsPrices->getPrice($item['variants_id'], $group_id);
            } else {
                $cart[$k]['price'] = $this->prices->get($item['products_id'], $group_id);
            }
        }

        return $cart;
    }

    public function total($json = true)
    {
        $amount = 0; $total = 0;
        $cart = Session::get('cart'); $user = Session::get('user');
        $group_id = isset($user['group_id']) ? $user['group_id'] : 20;

        if(!empty($cart)){
            foreach ($cart as $item) {
                $total  += $item['quantity'];
                if($item['has_variants']){
                    $amount += $this->variantsPrices->getPrice($item['variants_id'], $group_id) * $item['quantity'];
                } else {
                    $amount += $this->prices->get($item['products_id'], $group_id) * $item['quantity'];
                }
            }
        }

        if( ! $json){
            return ['amount' => $amount, 'total' => $total];
        }

        $this->response->body(['amount' => $amount, 'total' => $total])->asJSON();
    }

    public function clear()
    {
        Session::delete('cart');
    }
}