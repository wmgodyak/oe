<?php
namespace modules\delivery\controllers;
/**
 * Class DeliveryFactory
 * @package modules\delivery\controllers
 */
class DeliveryFactory
{
    const NS = 'modules\delivery\adapters\\';

    /**
     * @param $adapter
     * @return mixed
     * @throws \Exception
     */
    public static function create($adapter)
    {
        $adapter = ucfirst($adapter);
        if (!class_exists( self::NS . $adapter)) {
            throw new \Exception("Wrong delivery adapter. {$adapter} ");
        }

        $c = self::NS . $adapter;

        return new $c;
    }

    public static function getSettings($adapter)
    {
        $c = self::create($adapter);

        return $c->settings;
    }
}