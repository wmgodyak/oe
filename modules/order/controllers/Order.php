<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:37
 */

namespace modules\order\controllers;

use helpers\FormValidation;
use modules\order\models\OrdersProducts;
use modules\order\models\Status;
use modules\users\models\Users;
use system\core\Session;
use system\Front;

defined("CPATH") or die();

class Order extends Front
{
    private $users;
    public $cart;
    private $order;
    private $status;
    private $ordersProducts;

//    public $delivery;
//    public $payment;

    public function __construct()
    {
        parent::__construct();

        $this->users = new Users();
        $this->cart = new Cart();
        $this->order = new \modules\order\models\Order();
        $this->status = new Status();
        $this->ordersProducts = new OrdersProducts();
    }

    public function init()
    {
        $this->template->assignScript('modules/order/js/order.js');
    }

    public function checkout()
    {
        if(! $this->request->isPost()) die;
        $s = 0; $m = null;
        $ui = Session::get('user');

        $user = $this->request->post('user');
        if(!isset($user['email'])) $user['email'] = $ui['email'];

        FormValidation::setRule(['name','surname', 'email', 'phone'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($user);

        if(FormValidation::hasErrors()){
            $m = FormValidation::getErrors();
        } else {

            $this->order->beginTransaction();
            if($ui){
                // update user info
                $s = $this->users->update($ui['id'], $user);
                $ui += $user;
                Session::set('user', $ui);
            } else {
                $users_id = $this->users->register($user);
                if(! $users_id){
                    $m = $this->users->getError();
                } else {
                    $s=1;
                    $ui = $this->users->getData($users_id);
                }
            }

            if($s){
                // register order
                $order = $this->request->post('order');

                $order['comment'] = htmlspecialchars(strip_tags($order['comment']));

                $order['users_id']       = $ui['id'];
                $order['oid']            = date('ymd-hms');
                $order['languages_id']   = $this->languages_id;
                $order['users_group_id'] = $ui['group_id'];
                $order['status_id']      = $this->status->getMainId();

                $orders_id = $this->order->create($order);

                foreach ($this->cart->items() as $item) {
                    $this->ordersProducts->create
                    (
                        $orders_id,
                        $item['products_id'],
                        $item['quantity'],
                        $item['price'],
                        (isset($item['variants_id']) ? $item['variants_id'] : 0)
                    );
                }

                if($s && ! $this->order->hasError()){
                    $this->order->commit();
                    $this->cart->clear();
                } else {
                    $this->order->rollback();
                }
            }
        }

        $this->response->body(['s'=>$s, 'i' => $m])->asJSON();
    }

    public function oneClick()
    {
        if(! $this->request->isPost()) die;

        $products_id = $this->request->post('products_id', 'i');
        $variants_id = $this->request->post('variants_id', 'i');
        $phone       = $this->request->post('phone', 's');
        $name        = $this->request->post('name', 's');

        $s = 0; $m = null;
        $ui = Session::get('user');

        if(empty($ui)){
            $ui = $this->users->getUserByPhone($phone);
        }

        $this->order->beginTransaction();

        if(empty($ui)){

            $user = [
                'name'  => $name,
                'phone' => $phone,
                'email' => $phone
            ];

            $users_id = $this->users->register($user);

            if(! $users_id){
                $m = $this->users->getError();
            } else {
                $s=1;
                $ui = $this->users->getData($users_id);
            }
        }

        if($s){
            // register order
            $order = [];
            $order['one_click']      = 1;
            $order['users_id']       = $ui['id'];
            $order['oid']            = date('ymd-hms');
            $order['languages_id']   = $this->languages_id;
            $order['users_group_id'] = $ui['group_id'];
            $order['status_id']      = $this->status->getMainId();

            $orders_id = $this->order->create($order);

            // todo доробити товари
            foreach ($this->cart->items() as $item) {
                $this->ordersProducts->create
                (
                    $orders_id,
                    $item['products_id'],
                    $item['quantity'],
                    $item['price'],
                    (isset($item['variants_id']) ? $item['variants_id'] : 0)
                );
            }

            if($s && ! $this->order->hasError()){
                $this->order->commit();
                $this->cart->clear();
            } else {
                $this->order->rollback();
            }
        }


        $this->response->body(['s'=>$s, 'i' => $m])->asJSON();
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

    public function kits($tpl = 'modules/order/kits')
    {
        return $this->template->fetch($tpl);
    }
}