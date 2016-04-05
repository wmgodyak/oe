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
 * Class DeliveryFactory
 * @package controllers\modules
 */
class DeliveryFactory
{
    const NS = '\controllers\modules\delivery\\';

    /**
     * @param $method
     * @return mixed
     * @throws \Exception
     */
    public static function create($method)
    {
        $method = ucfirst($method);
        if (!class_exists( self::NS . $method)) {
            throw new \Exception("Wrong delivery system. {$method} ");
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