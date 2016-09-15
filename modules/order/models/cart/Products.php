<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.08.16 : 19:36
 */

namespace modules\order\models\cart;

use system\models\Front;

use modules\shop\models\Products as Mp;
use modules\shop\models\products\Prices;
use modules\shop\models\products\variants\ProductsVariantsPrices;
use system\core\Session;
use system\models\Settings;

defined("CPATH") or die();

class Products extends Front
{
    public  $prices;
    public  $variantsPrices;
    public  $products;
    private $user_group_id;
    private $bonus_rate;

    public function __construct()
    {
        parent::__construct();

        $this->prices         = new Prices();
        $this->variantsPrices = new ProductsVariantsPrices();
        $this->products       = new Mp('product');

        $user = Session::get('user');
        $this->user_group_id = isset($user['group_id']) ?
            $user['group_id'] :
            Settings::getInstance()->get('modules.Shop.config.group_id');

        $this->bonus_rate = Settings::getInstance()->get('modules.Shop.config.bonus_rate');
    }

    public function add()
    {
        $products_id = $this->request->post('products_id', 'i');
        $variants_id = $this->request->post('variants_id', 'i');
        $quantity    = $this->request->post('quantity', 'i');

        $cart = Session::get('cart.products');

        if(isset($cart[$products_id])) return null;

        $cart[$products_id] =
            [
                'products_id'  => $products_id,
                'variants_id'  => $variants_id,
                'quantity'     => $quantity,
                'has_variants' => $variants_id > 0
            ];

//        Session::set(['cart' => ['products' => $cart]]);

        if(! isset($_SESSION['cart'])){
            $_SESSION['cart'] = [];
        }

        $_SESSION['cart']['products'] = $cart;

        return true;
    }

    public function update()
    {
        $id = $this->request->post('id', 'i');
        $quantity = $this->request->post('quantity', 'i');
        $cart = Session::get('cart.products');

        if(isset($cart[$id])){
            $cart[$id]['quantity'] = $quantity;
        }

//        Session::set(['cart' => ['products' => $cart]]);
        $_SESSION['cart']['products'] = $cart;

        return true;
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $cart = Session::get('cart.products');

        if(isset($cart[$id])) unset($cart[$id]);

//        Session::set(['cart' => ['products' => $cart]]);

        $_SESSION['cart']['products'] = $cart;

        return true;
    }

    public function items()
    {
        $cart = Session::get('cart.products');
        if(empty($cart)) return null;

        foreach ($cart as $k=>$item) {
            $cart[$k] += $this->products->getData($item['products_id']);
            $cart[$k]['img'] = $this->images->cover($item['products_id']);
            if($item['has_variants']){
                $cart[$k]['price'] = $this->variantsPrices->getPrice($item['variants_id'], $this->user_group_id);
            } else {
                $cart[$k]['price'] = $this->prices->get($item['products_id'], $this->user_group_id);
            }

            $cart[$k]['price'] = ceil($cart[$k]['price']);

            $cart[$k]['bonus'] = round($cart[$k]['quantity'] * $cart[$k]['price'] * $this->bonus_rate, 2);
        }

        return $cart;
    }

    public function total()
    {
        $amount = 0; $total = 0;
        $cart = Session::get('cart.products');

        if(!empty($cart)){
            foreach ($cart as $item) {
                $total  += $item['quantity'];
                if($item['has_variants']){
                    $price = $this->variantsPrices->getPrice($item['variants_id'], $this->user_group_id) * $item['quantity'];
                } else {
                    $price = $this->prices->get($item['products_id'], $this->user_group_id) * $item['quantity'];
                }
                $price = ceil($price);
                $amount +=$price;
            }
        }

        return ['amount' => $amount, 'total' => $total];
    }
}