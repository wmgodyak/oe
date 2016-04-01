<?php
/**
 * Company Otakoyi.com
 * Author: volodymyr hodiak
 * Date: 12.01.15 18:05
 */

namespace controllers\modules\payment;

//include DOCROOT . "vendor/LiqPay.php";

//defined("CPATH") or die();

/**
 * Class LiqPay
 * @name LiqPay
 * @author wmgodyak mailto:wmgodyak@gmail.com
 * @version 1.0
 * @copyright &copy; 2014 Otakoyi.com
 * @package controllers\modules\payment
 */
class LiqPay
{
    public $settings =
        [
            'public_key' => null, 'private_key' => null, 'result_url' => null, 'error_url' => null, 'sandbox' => 1
        ];

    public function __construct($settings = null)
    {
        if($settings){
            $this->settings = $this->settings + $settings;
        }
    }


    /**
     * @return string
     */
    public function checkout($data)
    {
//        // налаштування платіжної системи
//        $settings = $this->mPayment->getSettings();
//
//        // інформація про об'єкт
//        $oData = $this->getOData();
//
//        $mContent = $this->load->model('app\Content');
//        // курс валют
//        $mCurrency = $this->load->model('modules\Currency');
//        $mCurrency->setID(Currency::getID());
//        $rate = $mCurrency->getData('rate');
//        $currency = $mCurrency->getData('code');
//        $amount = round($oData['amount_c'] * $rate, 2);
//        $amount = number_format($amount, 2, '.', '');
//
//        $liqpay = new \LiqPay($settings['public_key'], $settings['private_key']);
//        return $liqpay->cnb_form(
//            array(
//                'version'        => '3',
//                'amount'         => $amount,
//                'currency'       => $currency,
//                'description'    => 'Payment of apartment ' . $oData['code'],
//                'order_id'       => $oData['code'],
//                'server_url'     => APPURL . 'ajax/payment/LiqPay/callback',
//                'result_url'     => APPURL . $mContent->getAliasById($settings['result_url'], $this->languages_id),
//                'sandbox'        => $settings['sandbox']
//             )
//        );
    }

    public function callback()
    {
//        if (! $_POST) {
//            $this->log('ERROR: Empty POST');
//            die("ERROR: Empty POST");
//        }
////        $_POST['signature'] = '7rb2gC2m3z45f+zNAz9zoQ+BM5c=';
////        $_POST['data'] = 'eyJ2ZXJzaW9uIjozLCJwdWJsaWNfa2V5IjoiaTI3MTc0MDAzNzQ5IiwiYW1vdW50IjoiMzUwLjAwIiwiY3VycmVuY3kiOiJVQUgiLCJkZXNjcmlwdGlvbiI6IlBheW1lbnQgb2YgYXBhcnRtZW50IEQxNTA1MDEtODMtMzUyLTE1MDYxMSIsInR5cGUiOiJidXkiLCJvcmRlcl9pZCI6IkQxNTA1MDEtODMtMzUyLTE1MDYxMSIsImxpcXBheV9vcmRlcl9pZCI6IjMwMzI3NXUxNDMwNDgxOTc4MTI3NTI2Iiwic3RhdHVzIjoic2FuZGJveCIsImVycl9jb2RlIjpudWxsLCJ0cmFuc2FjdGlvbl9pZCI6NTY0MDk3MDQsInNlbmRlcl9waG9uZSI6IjM4MDY3NjczNjI0MiIsInNlbmRlcl9jb21taXNzaW9uIjowLCJyZWNlaXZlcl9jb21taXNzaW9uIjo5LjYzLCJhZ2VudF9jb21taXNzaW9uIjowfQ==';
//
//// log callback data
//        $this->log('>>>  log callback data');
//        $this->log(var_export($_POST, 1));
//
//        $callbackParams = $_POST;
//
//        // налаштування платіжної системи
//        $settings = $this->mPayment->getSettings();
//
//        $data = base64_decode($callbackParams['data']);
//        $data = json_decode($data, 1);
//        $sign = base64_encode( sha1(
//            $settings['private_key'] .
//            $callbackParams['data'] .
//            $settings['private_key']
//            , 1 ));
//
//        $this->log('verify signature begin');
//// verify signature
//        if ($callbackParams['signature'] !== $sign) {
//            // answer with fail response
//            $this->log("ERROR: Invalid signature");
//        } else {
//            // log success
//            $this->log('Callback signature OK');
//
//            $this->log('log data');
//            $this->log(var_export($data, 1));
//
//            // do processing stuff
//            switch ($data['status']) {
//                case 'sandbox':
//                case 'success':
//                    // ставлю мітку прооплату
//                    $o = $this->load->model('modules\Orders');
//                    $o->confirmPayment($data['order_id']);
//
//                    $notify = new Notification($data['order_id']);
//
//                    $this->log('повідомлення замовнику');
//                    // повідомлення замовнику
//                    $notify->customer();
//
////                    $this->log('повідомлення адміну');
//                    // повідомлення адміну
////                    $notify->admin();
//
//                    $this->log('повідомлення власнику');
//                    // повідомлення власнику
//                    $notify->owner();
//
//                    $this->log("Order {$data['order_id']} processed as successfull sale");
//                    break;
//                default:
//                    $err_msg= "При оплате заказа  {$data['order_id']}  получен статус {$data['status']}.
//
//                            Возможные значения:
//                            success - успешный платеж
//                            failure - неуспешный платеж
//                            wait_secure - платеж на проверке
//                            wait_accept - Деньги с клиента списаны, но магазин еще не прошел проверку
//                            wait_lc - Аккредитив. Деньги с клиента списаны, ожидается подтверждение доставки товара
//                            processing - Платеж обрабатывается
//                            sandbox - тестовый платеж
//                            subscribed - Подписка успешно оформлена
//                            unsubscribed - Подписка успешно деактивирована
//                            reversed - Возврат клиенту после списания
//                            cash_wait - Ожидание оплаты счета клиентом в терминале
//
//                     Подробнее о статусах: https://www.liqpay.com/ru/doc#callback ";
//                    $this->log($err_msg);
//                    mail('info@mushroom.com.ua', 'LiqPay Callback Error', $err_msg);
//                    die("ERROR: Invalid callback data");
//            }
//
//            // answer with success response
//            $this->log('OK');
//            exit("OK");
//        }

    }
}