<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.04.16 : 14:34
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class DeliveryPayment
 * @package models\engine
 */
class DeliveryPayment extends Engine
{
    /**
     * @param $delivery_id
     * @param $payment_id
     * @return bool|string
     */
    public static function create($delivery_id, $payment_id)
    {
        return self::$db->insert('__delivery_payment', ['delivery_id' => $delivery_id, 'payment_id' => $payment_id]);
    }

    /**
     * @param $delivery_id
     * @param $payment_id
     * @return int
     */
    public static function delete($delivery_id, $payment_id)
    {
        return self::$db->delete('delivery_payment', " delivery_id={$delivery_id} and payment_id={$payment_id} limit 1");
    }

    public static function getDelivery()
    {
        $languages_id = self::$language_id;
        return self::$db
            ->select("select d.id, i.name from __delivery d, delivery_info i where i.delivery_id=d.id and i.languages_id={$languages_id}")
            ->all();
    }

    public static function getPayment()
    {
        $languages_id = self::$language_id;
        return self::$db
            ->select("select d.id, i.name from __payment d, payment_info i where i.payment_id=d.id and i.languages_id={$languages_id}")
            ->all();
    }

    /**
     * @param $delivery_id
     * @param $payment_id
     * @return array|mixed
     */
    public static function is($delivery_id, $payment_id)
    {
        return self::$db
            ->select("select id from __delivery_payment where delivery_id={$delivery_id} and payment_id={$payment_id} limit 1")
            ->row('id') > 0;
    }

    /**
     * @param $delivery_id
     * @return mixed
     */
    public static function getSelectedPayment($delivery_id)
    {
        return self::$db
            ->select("select payment_id from __delivery_payment where delivery_id={$delivery_id}")
            ->all('payment_id');
    }

    /**
     * @param $payment_id
     * @return mixed
     */
    public static function getSelectedDelivery($payment_id)
    {
        return self::$db
            ->select("select delivery_id from __delivery_payment where payment_id={$payment_id}")
            ->all('delivery_id');
    }
}