<?php
namespace modules\payment\controllers;
/**
 * Class paymentFactory
 * @package modules\payment\controllers
 */
class PaymentFactory
{
    const NS = 'modules\payment\adapters\\';

    /**
     * @param $adapter
     * @param null $settings
     * @return mixed
     * @throws \Exception
     */
    public static function create($adapter, $settings = null)
    {
        $adapter = ucfirst($adapter);
        if (!class_exists( self::NS . $adapter)) {
            throw new \Exception("Wrong payment adapter. {$adapter} ");
        }

        $c = self::NS . $adapter;

        return new $c($settings);
    }

    public static function getSettings($adapter)
    {
        $c = self::create($adapter);

        return $c->settings;
    }
}