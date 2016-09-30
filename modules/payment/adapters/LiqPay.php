<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 30.06.16
 * Time: 0:42
 */

namespace modules\payment\adapters;
use modules\payment\controllers\IPayment;
use system\core\EventsHandler;
use system\core\Logger;

include DOCROOT . "vendor/LiqPay.php";
/**
 * Class LiqPay
 * @name LiqPay
 * @package modules\payment\adapters
    public_key	i8678190154
    private_key	STqNFC7tPxq95dzBYJdO1Jq0TRtv0xYASAfzWb5n
 */
class LiqPay implements IPayment
{
    public $settings = ['public_key' => null, 'private_key' => null, 'sandbox' => 1];

    public function __construct($settings = null)
    {
        if($settings){
            $this->settings = array_merge($this->settings, $settings);
        }
    }

    /**
     * @param $order
     * @return string
     */
    public function checkout($order)
    {
        $liqpay = new \LiqPay($this->settings['public_key'], $this->settings['private_key']);

        return $liqpay->cnb_form(
            array(
                'version'        => '3',
                'amount'         => $order['amount'],
                'currency'       => $order['currency']['code'],
                'description'    => $order['description'],
                'order_id'       => $order['oid'],
                'server_url'     => APPURL . 'route/payment/callback/LiqPay',
                'result_url'     => $order['redirect_url'],
                'sandbox'        => $this->settings['sandbox']
            )
        );
    }

    public function callback()
    {
        Logger::log(var_export($_REQUEST, 1));
        Logger::info('LiqPay callback >>>');


//        $_POST['data'] = 'eyJhY3Rpb24iOiJwYXkiLCJwYXltZW50X2lkIjoyMzEwMDU5MTcsInN0YXR1cyI6IndhaXRfYWNjZXB0IiwidmVyc2lvbiI6MywidHlwZSI6ImJ1eSIsInBheXR5cGUiOiJsaXFwYXkiLCJwdWJsaWNfa2V5IjoiaTg2NzgxOTAxNTQiLCJhY3FfaWQiOjQxNDk2Mywib3JkZXJfaWQiOiIxNjA4MjQtMDUwODQ2NTYiLCJsaXFwYXlfb3JkZXJfaWQiOiJDT082UlI4SzE0NzIwNTA3MjMyODQ5MjQiLCJkZXNjcmlwdGlvbiI6IlBheW1lbnQgb3JkZXIgMTYwODI0LTA1MDg0NjU2LiAiLCJzZW5kZXJfcGhvbmUiOiIzODA2NzY3MzYyNDIiLCJzZW5kZXJfZmlyc3RfbmFtZSI6ItCS0L7Qu9C+0LTQuNC80LjRgCIsInNlbmRlcl9sYXN0X25hbWUiOiLQk9C+0LTRj9C6Iiwic2VuZGVyX2NhcmRfbWFzazIiOiI0MTQ5NDkqMDYiLCJzZW5kZXJfY2FyZF9iYW5rIjoicGIiLCJzZW5kZXJfY2FyZF90eXBlIjoidmlzYSIsInNlbmRlcl9jYXJkX2NvdW50cnkiOjgwNCwiaXAiOiIxOTQuNDQuODQuMTI3IiwiYW1vdW50IjoxLjAsImN1cnJlbmN5IjoiVUFIIiwic2VuZGVyX2NvbW1pc3Npb24iOjAuMCwicmVjZWl2ZXJfY29tbWlzc2lvbiI6MC4wMywiYWdlbnRfY29tbWlzc2lvbiI6MC4wLCJhbW91bnRfZGViaXQiOjEuMCwiYW1vdW50X2NyZWRpdCI6MS4wLCJjb21taXNzaW9uX2RlYml0IjowLjAsImNvbW1pc3Npb25fY3JlZGl0IjowLjAzLCJjdXJyZW5jeV9kZWJpdCI6IlVBSCIsImN1cnJlbmN5X2NyZWRpdCI6IlVBSCIsInNlbmRlcl9ib251cyI6MC4wLCJhbW91bnRfYm9udXMiOjAuMCwiYXV0aGNvZGVfZGViaXQiOiI0OTQwMzEiLCJycm5fZGViaXQiOiIwMDA0NDMzNDM2MTEiLCJtcGlfZWNpIjoiNyIsImlzXzNkcyI6ZmFsc2UsImNyZWF0ZV9kYXRlIjoxNDcyMDUwNzE4MjYxLCJ0cmFuc2FjdGlvbl9pZCI6MjMxMDA1OTE3fQ==';
//        $_POST['signature'] = 'aB0b11LKVJ3Qk4YwFiaWPZ47oKs=';


        if (! $_POST) {
            Logger::log('ERROR: Empty POST');
            return;
        }

        Logger::log('>>>  log callback data');
        Logger::log(var_export($_POST, 1));

        $callbackParams = $_POST;

        // налаштування платіжної системи
        $data = base64_decode($callbackParams['data']);
        $data = json_decode($data, 1);
        $sign = base64_encode( sha1(
            $this->settings['private_key'] .
            $callbackParams['data'] .
            $this->settings['private_key']
            , 1 ));

        Logger::log('verify signature begin');

        if ($callbackParams['signature'] !== $sign) {
            // answer with fail response
            Logger::log("ERROR: Invalid signature");
        } else {
            // log success
            Logger::log('Callback signature OK');
            if($this->settings['sandbox'] && in_array($data['status'], ['sandbox', 'success', 'wait_accept'])) {
                Logger::log('Call event: payment.callback.success');
                EventsHandler::getInstance()->call('payment.callback.success', $data);
                Logger::log("Order {$data['order_id']} processed as success full sale on sandbox mode");
                return;
            }
            switch ($data['status']) {
                case 'sandbox':
                case 'success':
                    Logger::log('Call event: payment.callback.success');
                    EventsHandler::getInstance()->call('payment.callback.success', $data);
                    Logger::log("Order {$data['order_id']} processed as success full sale");
                    break;
                default:
                    $err_msg = "При оплате заказа  {$data['order_id']}  получен статус {$data['status']}.
                     Подробнее о статусах: https://www.liqpay.com/ru/doc#callback ";
                    Logger::log($err_msg);
//                    mail('support@otakoyi.com', 'LiqPay Callback Error', $err_msg);
            }

        }
    }
}