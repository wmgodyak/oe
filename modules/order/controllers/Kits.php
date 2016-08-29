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
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Kits
 * @package modules\order\controllers
 */
class Kits extends Front
{
    public $prices;
    public $variantsPrices;
    public $products;
    private $user_group_id;
    private $bonus_rate;

    public function __construct()
    {
        parent::__construct();

//        $this->prices         = new Prices();
//        $this->variantsPrices = new ProductsVariantsPrices();
//        $this->products       = new Products('product');
//
        $user = Session::get('user');
        $this->user_group_id = isset($user['group_id']) ?
            $user['group_id'] :
            Settings::getInstance()->get('modules.Shop.config.group_id');

        $this->bonus_rate = Settings::getInstance()->get('modules.Shop.config.bonus_rate');
    }

    public function add()
    {
        $kits_id = $this->request->post('kits_id', 'i');

        $kits = Session::get('kits');

        if(isset($kits[$kits_id])) return;

        $kits[$kits_id] =
            [
                'kits_id'  => $kits_id,
                'quantity' => 1
            ];

        Session::set('kits', $kits);

        $this->total();
    }

    public function update()
    {
        $id = $this->request->post('id', 'i');
        $quantity = $this->request->post('quantity', 'i');
        $kits = Session::get('kits');

        if(isset($kits[$id])){
            $kits[$id]['quantity'] = $quantity;
        }

        Session::set('kits', $kits);

        $this->response->body(['s' => 1, 'total' => $this->total(false), 'items' => $this->items()])->asJSON();
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $kits = Session::get('kits');

        if(isset($kits[$id])) unset($kits[$id]);

        Session::set('kits', $kits);

        $this->response->body(['s' => 1, 'total' => $this->total(false), 'items' => $this->items()])->asJSON();
    }

    public function items()
    {
        $kits = Session::get('kits');

        foreach ($kits as $k=>$kit) {
//            $kits[$k] += $this->products->getData($item['products_id']);
//            $kits[$k]['img'] = $this->images->cover($item['products_id']);
//            if($item['has_variants']){
//                $kits[$k]['price'] = $this->variantsPrices->getPrice($item['variants_id'], $this->user_group_id);
//            } else {
//                $kits[$k]['price'] = $this->prices->get($item['products_id'], $this->user_group_id);
//            }
//
//            $kits[$k]['bonus'] = round($kits[$k]['quantity'] * $kits[$k]['price'] * $this->bonus_rate, 2);
        }

        return $kits;
    }

    /**
     * @param bool $json
     * @return array
     */
    public function total($json = true)
    {
        $amount = 0; $total = 0;
//        $kits = Session::get('kits');
//
//        if(!empty($kits)){
//            foreach ($kits as $item) {
//                $total  += $item['quantity'];
//                if($item['has_variants']){
//                    $amount += $this->variantsPrices->getPrice($item['variants_id'], $this->user_group_id) * $item['quantity'];
//                } else {
//                    $amount += $this->prices->get($item['products_id'], $this->user_group_id) * $item['quantity'];
//                }
//            }
//        }
//
//        if( ! $json){
//            return ['amount' => $amount, 'total' => $total];
//        }

        $this->response->body(['amount' => $amount, 'total' => $total])->asJSON();
    }

    public function clear()
    {
        Session::delete('kits');
    }
}