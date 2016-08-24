<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 30.06.16
 * Time: 0:42
 */

namespace modules\payment\adapters;
use modules\payment\controllers\IPayment;

/**
 * Class LiqPay
 * @name LiqPay
 * @package modules\payment\adapters
 */
class LiqPay implements IPayment
{
    public $settings = ['key' => null, 'password' => null];

    public function checkout()
    {
        // TODO: Implement checkout() method.
    }

    public function callback()
    {
        // TODO: Implement callback() method.
    }
}