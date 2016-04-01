<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 12.01.15 18:05
 */

namespace controllers\modules\payment;

use controllers\modules\Payment;

defined("CPATH") or die();

/**
 * Class Webmoney
 * @name Webmoney
 * @author wmgodyak mailto:wmgodyak@gmail.com
 * @version 1.0
 * @copyright &copy; 2015 Otakoyi.com
 * @package controllers\modules\payment
 */
class WebMoney
{
    public $settings = ['purse' => null, 'secret_key' => null];
    public function checkout($data){}
    public function callback(){}
}