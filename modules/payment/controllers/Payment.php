<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\payment\controllers;

use modules\order\models\Order;
use system\core\EventsHandler;
use system\core\Logger;
use system\Front;
use system\models\Currency;
use system\models\Settings;

/**
 * Class Payment
 * @name Оплата
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\payment\controllers
 */
class Payment extends Front
{
    public function __construct()
    {
        parent::__construct();
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('layouts.pages.content', [$this, 'checkout']);
    }

    public function checkout()
    {
        $settings = Settings::getInstance()->get('modules.Payment.config');

        if($this->request->isPost()){
//            Logger::init('payment', 'payment');
//            Logger::info('Export POST: '. var_export($_POST, 1));
//            die;
        }

        if($this->page['id'] != $settings['checkout_page_id']) return null;

        $oid = $this->request->get('oid');
        if(! $oid)  return null;

        $mOrder = new Order();
        $mPayment = new \modules\payment\models\Payment();
        $currency = new Currency();

        $order   = $mOrder->getDataByOID($oid);
        if(empty($order)) return null;
        $order['amount']   = $mOrder->amount($order['id']);
        $order['currency'] = $currency->getMeta($order['currency_id']);
        $order['description'] = "Payment order {$order['oid']}. ";
        $order['redirect_url'] = $this->getUrl($settings['redirect_url_id']);
        $payment = $mPayment->getData($order['payment_id']);

        if($payment['module'] != ''){
            $module = PaymentFactory::create($payment['module'], $payment['settings']);
            $payment['checkout'] = $module->checkout($order);
        }

        $this->template->assign('order', $order);
        $this->template->assign('payment', $payment);

        return $this->template->fetch('modules/payment/checkout');
    }

    /**
     * route/payment/callback/LiqPay
     * @param $adapter
     */
    public function callback($adapter = null)
    {
        Logger::init('payment', 'payment');
        Logger::info('Call adapter: ' . $adapter);

        if(empty($adapter)) die;

        $mPayment = new \modules\payment\models\Payment();
        $module = PaymentFactory::create($adapter, $mPayment->getSettings($adapter));
        $module->callback();
    }
}