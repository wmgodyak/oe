<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.08.16 : 11:25
 */

namespace modules\payment\adapters;
use modules\order\models\Order;
use modules\payment\controllers\IPayment;
use modules\usersBonus\models\UsersBonus;

defined("CPATH") or die();

/**
 * Class Bonus
 * @name Оплата бонусами
 * @package modules\payment\adapters
 */
class Bonus implements IPayment
{
    public $settings = [];

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
//        return $liqpay->cnb_form(
//            array(
//                'version'        => '3',
//                'amount'         => $order['amount'],
//                'currency'       => $order['currency']['code'],
//                'description'    => $order['description'],
//                'order_id'       => $order['oid'],
//                'server_url'     => APPURL . 'route/payment/callback/LiqPay',
//                'result_url'     => $order['redirect_url'],
//                'sandbox'        => $this->settings['sandbox']
//            )
//        );
        // get balance
        $ub = new UsersBonus();
        $bb = $ub->get($order['users_id']);
        $o = new Order();

        if(isset($_GET['pay'])){
            if($o->paid($order['id'])){
                $s = $ub->create($order['users_id'], $order['id'], - $order['amount']);
                if($s){
                    echo "<script>self.location.href='{$order['redirect_url']}';</script>";
                }
            }
        }

        if($order['paid']){
            return  "Це замовлення вже оплачене";
        }

        if($bb < $order['amount']){
            return "Ви не можете здійснити оплату бонусами";
        }

        return "
            <form id='payBonus' method='get'>
                <input type='hidden' name='oid' value='{$order['oid']}'>
                <input type='hidden' name='pay'>
                <button class='btn md red'>Оптатити</button>
            </form>
        ";
    }

    public function callback()
    {

    }
}