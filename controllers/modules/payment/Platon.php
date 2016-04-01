<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 12.01.15 18:05
 */

namespace controllers\modules\payment;

defined("CPATH") or die();

/**
 * Class Platon
 * @name Platon
 * @author wmgodyak mailto:wmgodyak@gmail.com
 * @version 1.0
 * @copyright &copy; 2014 Otakoyi.com
 * @package controllers\modules\payment
 */
class Platon
{
    public $settings = ['key' => null, 'password' => null, 'url' => null, 'error_url' => null];

    /**
     * @param $data
     */
    public function checkout($data)
    {
//        // налаштування платіжної системи
//        $data = $this->mPayment->getSettings();
//
//        // інформація про об'єкт
//        $oData = $this->getOData();
//
//        // курс валют
//        $mCurrency = $this->load->model('modules\Currency');
//        $mCurrency->setID(Currency::getID());
//        $rate = $mCurrency->getData('rate');
//
//        // назва
//        $mContent = $this->load->model('app\Content');
//        $amount = round($oData['amount_c'] * $rate, 2);
//        $amount = number_format($amount, 2, '.', '');
//        $data['data'] = base64_encode(
//            serialize(
//                array(
//                    'amount'   => $amount,
//                    'name'     => $mContent->getData($oData['content_id'], $this->languages_id, 'name'),
//                    'currency' => $mCurrency->getData('code')
//                )
//            )
//        );
//
//        $data['payment']      = 'CC';
//        $data['url']          = APPURL . $mContent->getAliasById($data['url'], $this->languages_id);
//        $data['error_url']    = APPURL . $mContent->getAliasById($data['error_url'], $this->languages_id);
//        $data['callback_url'] = APPURL . 'ajax/payment/Platon/callback';
//
//        /* Calculation of signature */
//        $sign = md5(
//            strtoupper(
//                strrev($data['key']).
//                strrev($data['payment']).
//                strrev($data['data']).
//                strrev($data['url']).
//                strrev($data['password'])
//            )
//        );
//
//        return '
//         <form class="m-group-btn" action="https://secure.platononline.com/payment/auth" method="post">
//            <input type="hidden" name="payment" value="'.$data['payment'].'" />
//            <input type="hidden" name="key"     value="'.$data['key'].'" />
//            <input type="hidden" name="order"   value="'.$oData['code'].'" />
//            <input type="hidden" name="url"     value="'.$data['url'].'" />
//            <input type="hidden" name="error_url" value="'.$data['error_url'].'" />
//            <input type="hidden" name="data"    value="'.$data['data'].'" />
//            <input type="hidden" name="sign"    value="'.$sign.'" />
//            <button class="btn btn-orange">'. $this->translation['order_submit_btn'] .'</button>
//         </form>
//        ';
    }

    public function callback()
    {
//        // налаштування платіжної системи
//        $data = $this->mPayment->getSettings();
//
//        if (! $_POST) {
//            $this->log('ERROR: Empty POST');
//            die("ERROR: Empty POST");
//        }
//
//// log callback data
//        $this->log('log callback data');
//        $this->log(var_export($_POST, 1));
//
//        $callbackParams = $_POST;
//
//// generate signature from callback params
//        $sign =  md5(strtoupper(
//            strrev($callbackParams['email']) .
//            $data['password'] .
//            $callbackParams['order'] .
//            strrev(substr($callbackParams['card'], 0, 6) . substr($callbackParams['card'], -4))
//        ));
//
//// verify signature
//        if ($callbackParams['sign'] !== $sign) {
//            // log failure
//            $this->log('Invalid signature');
//
//            // answer with fail response
//            die("ERROR: Invalid signature");
//
//        } else {
//            // log success
//            $this->log('Callback signature OK');
//
//            // do processing stuff
//            switch ($callbackParams['status']) {
//                case 'SALE':
//                    // ставлю мітку прооплату
//                    $o = $this->load->model('modules\Orders');
//                    $o->confirmPayment($callbackParams['order']);
//
//                    $this->log("Order {$callbackParams['order']} processed as successfull sale");
//                    break;
//                case 'REFUND':
//                    $this->log("Order {$callbackParams['order']} processed as successfull refund");
//                    break;
//                case 'CHARGEBACK':
//                    $this->log("Order {$callbackParams['order']} processed as successfull chargeback");
//                    break;
//                default:
//                    $this->log("Invalid callback data");
//                    die("ERROR: Invalid callback data");
//            }
//
//            // answer with success response
//            $this->log('OK');
//            exit("OK");
//        }

    }
}