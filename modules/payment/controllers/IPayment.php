<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.08.16 : 14:14
 */

namespace modules\payment\controllers;

interface IPayment
{
    public function __construct($settings = null);
    public function checkout($order);
    public function callback();
}