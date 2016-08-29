<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.07.16 : 11:37
 */

namespace modules\order\controllers;

use helpers\FormValidation;
use helpers\Pagination;
use modules\order\models\OrdersProducts;
use modules\order\models\Status;
use modules\users\models\Users;
use system\core\EventsHandler;
use system\core\Logger;
use system\core\Session;
use system\Front;
use system\models\Currency;
use system\models\Mailer;

defined("CPATH") or die();

/**
 * Class Order
 * @name Замовлення
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\order\controllers
 */
class Order extends Front
{
    private $users;
    public  $cart;
    public  $kits;
    private $order;
    private $status;
    private $ordersProducts;
    private $currency;

//    public $delivery;
//    public $payment;

    public function __construct()
    {
        parent::__construct();

        $this->users  = new Users();
        $this->cart   = new Cart();
        $this->order  = new \modules\order\models\Order();
        $this->status = new Status();
        $this->ordersProducts = new OrdersProducts();

        $this->currency = new Currency();
    }

    public function init()
    {
        $this->template->assignScript('modules/order/js/order.js');
        EventsHandler::getInstance()->add('user.account.sidebar', [$this, 'history']);
        EventsHandler::getInstance()->add('payment.callback.success', [$this, 'paymentCallbackSuccess']);
    }

    public function paymentCallbackSuccess($data)
    {
        Logger::info('Call \modules\order\controllers\Order::paymentCallback');

        $order = $this->order->getDataByOID($data['order_id']);
        if(empty($order)){
            Logger::error('Wrong order id. #' . $data['order_id']);
            return;
        }

        if( $order['paid'] == 1){
            Logger::error('This order is payed');
            return ;
        }

        $s = $this->order->update($order['id'], ['paid' => 1, 'paid_date' => date('Y-m-d H:i:s')]);
        if($s){
            Logger::info("Order: {$data['order_id']} paid successful. ");
        }
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
        } elseif($ui['email'] != $user['email'] && $this->users->issetEmail($user['email'], $ui['id'])) {
            $m['user[email]'] = 'This email address used by other customer';
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
                $order = $this->request->post('data');

                $order['comment'] = htmlspecialchars(strip_tags($order['comment']));

                $order['users_id']       = $ui['id'];
                $order['oid']            = date('ymd-hmsi');
                $order['languages_id']   = $this->languages_id;
                $order['users_group_id'] = $ui['group_id'];
                $order['status_id']      = $this->status->getMainId();
                $order['currency_id']    = $this->currency->getOnSiteMeta('id');
                $order['currency_rate']  = $this->currency->getOnSiteMeta('rate');

                $orders_id = $this->order->create($order);

                $order['products'] = $this->cart->items();

                foreach ($order['products'] as $item) {
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
                    $this->notifyCustomer($order);
                } else {
                    $this->order->rollback();
                }
            }
        }

        $this->response->body(['s'=>$s, 'i' => $m, 'redirect' => $this->getUrl(12)])->asJSON();
    }

    private function notifyCustomer($order)
    {
        $order['user'] = $this->users->getData($order['users_id']);
        $mailer = new Mailer('modules/order/mail', 'Нове замовлення', $order);

        return $mailer->send();
    }

    public function oneClick()
    {
        if(! $this->request->isPost()) die;

        $products_id = $this->request->post('products_id', 'i');
        $variants_id = $this->request->post('variants_id', 'i');

        $s = 1; $m = null;

        $user = Session::get('user');

        if(empty($products_id)){
            FormValidation::setError('data[phone]', 'Невірний артикул товару');
            $s = 0;
            $m = FormValidation::getErrors();
        }

        if($s && ! $user){
            $user = $this->request->post('user');
            if(empty($user['name']) || empty($user['phone'])){
                FormValidation::setError('data[phone]', 'Введіть ім\'я і телефон');
                $s = 0;
                $m = FormValidation::getErrors();
            } else {

                $u = $this->users->getUserByPhone($user['phone']);

                if(empty($u)){

                    $user['email'] = str_replace(['+','(',')','-'], [], $user['phone']) . '@one.click';

                    $users_id = $this->users->register($user);

                    if($this->users->hasError()){
                        $m = $this->users->getError();
                        $s=0;
                    } else {
                        $user = $this->users->getData($users_id);
                        $s=1;
                    }
                } else{
                    $user = $u;
                }
            }
        }

        if($s && !empty($user)){
            $this->order->beginTransaction();
            // register order
            $order = [];
            $order['one_click']      = 1;
            $order['users_id']       = $user['id'];
            $order['oid']            = date('ymd-hmsi');
            $order['languages_id']   = $this->languages_id;
            $order['users_group_id'] = $user['group_id'];
            $order['status_id']      = $this->status->getMainId();
            $order['currency_id']    = $this->currency->getOnSiteMeta('id');
            $order['currency_rate']  = $this->currency->getOnSiteMeta('rate');

            $orders_id = $this->order->create($order);
            if($orders_id > 0){
                if($variants_id > 0){
                    $price = $this->cart->products->variantsPrices->getPrice($orders_id, $user['group_id']);
                } else {
                    $price = $this->cart->products->prices->get($products_id, $user['group_id']);
                }

                $s += $this->ordersProducts->create
                (
                    $orders_id,
                    $products_id,
                    1,
                    $price,
                    ($variants_id > 0 ? $variants_id : 0)
                );

                $order['products'] = [[
                    'products_id' => $products_id,
                    'price' => $price,
                    'quantity' => 1,
                    'variants_id' =>  ($variants_id > 0 ? $variants_id : 0)
                ]];
            }

            if($s && ! $this->order->hasError()){
                $this->order->commit();
                $this->cart->clear();
                $this->notifyCustomer($order);
            } else {
                $this->order->rollback();
            }
        }

        $this->response->body(['s'=>$s > 0, 'i' => $m, 'redirect' => $this->getUrl(31)])->asJSON();
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

    private $h_total = 0;
    private $ipp   = 5;

    /**
     * @param int $start
     * @param int $num
     * @param string $tpl
     * @return string
     */
    public function history($start = 0, $num = 5, $tpl = 'modules/order/history')
    {
        $user = Session::get('user');
        if(! $user) return '';

        $p = (int) $this->request->get('p', 'i');
        $start = $start ? $start : $p;
        if($p){
            $start --;

            if($start < 0) $start = 0;

            if($start > 0){
                $start = $start * $this->ipp;
            }
        }

        $this->template->assign('orders', $this->order->history($user['id'], $start, $num));
        $this->h_total = $this->order->total($user['id']);

        return $this->template->fetch($tpl);
    }

    /**
     * display pagination
     * @param string $tpl
     * @return string
     */
    public function pagination($tpl = 'modules/pagination')
    {
        $p = $this->request->get('p', 'i');

        $url = $this->page['id'] . ';';

        Pagination::init($this->h_total, $this->ipp, $p, $url);

        $this->template->assign('pagination', Pagination::getPages());
        return $this->template->fetch($tpl);
    }
}