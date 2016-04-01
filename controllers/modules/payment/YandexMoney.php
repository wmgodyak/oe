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
 * Class YandexMoney
 * @name YandexMoney
 * @author wmgodyak mailto:wmgodyak@gmail.com
 * @version 1.0
 * @copyright &copy; 2014 Otakoyi.com
 * @package controllers\modules\payment
 */
class YandexMoney
{
    public $settings = ['yandex_id' => null,'yandex_secret' => null];

    public function checkout($data){}
    public function callback(){}
}