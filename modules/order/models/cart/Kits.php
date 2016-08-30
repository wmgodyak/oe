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
use system\core\Session;
use system\models\Settings;

defined("CPATH") or die();

class Kits extends Front
{
    public  $prices;
    public  $products;
    private $kits;
    private $user_group_id;
    private $bonus_rate;

    public function __construct()
    {
        parent::__construct();

        $this->prices         = new Prices();
        $this->products       = new Mp('product');

        $this->kits = new \modules\shop\models\products\Kits();

        $user = Session::get('user');
        $this->user_group_id = isset($user['group_id']) ?
            $user['group_id'] :
            Settings::getInstance()->get('modules.Shop.config.group_id');

        $this->bonus_rate = Settings::getInstance()->get('modules.Shop.config.bonus_rate');
    }

    public function add()
    {
        $kits_id = $this->request->post('kits_id', 'i');

        $cart = Session::get('cart.kits');

        if(isset($cart[$kits_id])) return null;

        $cart[$kits_id] =
            [
                'kits_id'  => $kits_id,
                'quantity'     => 1
            ];

        if(! isset($_SESSION['cart'])){
            $_SESSION['cart'] = [];
        }

        $_SESSION['cart']['kits'] = $cart;

        return true;
    }

    public function update()
    {
        $id = $this->request->post('id', 'i');
        $quantity = $this->request->post('quantity', 'i');
        $cart = Session::get('cart.kits');

        if(isset($cart[$id])){
            $cart[$id]['quantity'] = $quantity;
        }

        $_SESSION['cart']['kits'] = $cart;

//        Session::set(['cart' => ['kits' => $cart]]);

        return true;
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $cart = Session::get('cart.kits');

        if(isset($cart[$id])) unset($cart[$id]);

//        Session::set(['cart' => ['kits' => $cart]]);

        $_SESSION['cart']['kits'] = $cart;

        return true;
    }

    public function items()
    {
        $cart = Session::get('cart.kits');
        if(empty($cart)) return null;

        foreach ($cart as $k=>$item) {

//            $cart[$k]['amount']      = 0;
//            $cart[$k]['original_amount'] = 0;
            $cart[$k]['save_amount'] = 0;

            $cart[$k] = $this->kits->getData($item['kits_id']);
            $cart[$k]['quantity'] = $item['quantity'];
            $cart[$k]['product'] = $this->products->getData($cart[$k]['products_id']);
            $cart[$k]['product']['price'] = $this->prices->get($cart[$k]['products_id'], $this->user_group_id);
            $cart[$k]['product']['img'] = $this->images->cover($cart[$k]['products_id']);

            $cart[$k]['amount'] = $cart[$k]['product']['price'];
            $cart[$k]['original_amount'] = $cart[$k]['product']['price'];

            foreach ( $cart[$k]['products'] as $i=>$product) {
                $cart[$k]['products'][$i]['img'] = $this->images->cover($product['products_id']);
//
                $cart[$k]['products'][$i]['original_price'] = $this->prices->get($product['products_id'], $this->user_group_id);
                $cart[$k]['products'][$i]['price']          = $cart[$k]['products'][$i]['original_price'] - ($cart[$k]['products'][$i]['original_price'] / 100 * $product['discount']);
                $cart[$k]['products'][$i]['save_price']     = $cart[$k]['products'][$i]['original_price'] - $cart[$k]['products'][$i]['price'];

                $cart[$k]['amount'] += $cart[$k]['products'][$i]['price'];
                $cart[$k]['original_amount'] += $cart[$k]['products'][$i]['original_price'];

//                $cart[$k]['save_amount'] += $cart[$k]['products'][$i]['save_amount'];
            }

            unset($cart[$k]['kits_id'], $cart[$k]['products_id']);
        }

        return $cart;
    }

    public function total()
    {
        $amount = 0; $total = 0;
        $cart = Session::get('cart.kits');

//        if(!empty($cart)){
//            foreach ($cart as $item) {
//                $total  += $item['quantity'];
//                if($item['has_variants']){
//                    $amount += $this->variantsPrices->getPrice($item['variants_id'], $this->user_group_id) * $item['quantity'];
//                } else {
//                    $amount += $this->prices->get($item['kits_id'], $this->user_group_id) * $item['quantity'];
//                }
//            }
//        }

        return ['amount' => $amount, 'total' => $total];
    }
}