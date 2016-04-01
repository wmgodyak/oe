<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.04.16 : 16:13
 */

namespace controllers\modules;

defined("CPATH") or die();

/**
 * Class PaymentFactory
 * @package controllers\modules
 */
class PaymentFactory
{
    const NS = '\controllers\modules\payment\\';

    /**
     * @param $method
     * @return mixed
     * @throws \Exception
     */
    public static function create($method)
    {
        $method = ucfirst($method);
        if (!class_exists( self::NS . $method)) {
            throw new \Exception("Wrong payment system. {$method} ");
        }

        $c = self::NS . $method;

        return new $c;
    }

    public static function getSettings($method)
    {
        $c = self::create($method);

        return $c->settings;
    }
}