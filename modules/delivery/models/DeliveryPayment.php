<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 30.06.16
 * Time: 0:10
 */

namespace modules\delivery\models;

use system\models\Model;

class DeliveryPayment extends Model
{
    /**
     * @param $delivery_id
     * @param $payment_id
     * @return bool|string
     */
    public function create($delivery_id, $payment_id)
    {
        return self::$db->insert('__delivery_payment', ['delivery_id' => $delivery_id, 'payment_id' => $payment_id]);
    }

    /**
     * @param $delivery_id
     * @param $payment_id
     * @return int
     */
    public function delete($delivery_id, $payment_id)
    {
        return self::$db->delete('__delivery_payment', " delivery_id={$delivery_id} and payment_id={$payment_id} limit 1");
    }

    public function getDelivery()
    {
        return self::$db
            ->select("select d.id, i.name from __delivery d, __delivery_info i where i.delivery_id=d.id and i.languages_id={$this->languages_id}")
            ->all();
    }

    public function getPayment($delivery_id = 0)
    {
        $from = ''; $where = '';
        if($delivery_id > 0){
            $from = ', __delivery_payment dp ';
            $where = " dp.delivery_id={$delivery_id} and dp.payment_id=d.id and ";
        }

        return self::$db
            ->select("
                    select d.id, i.name
                    from __payment d, __payment_info i {$from}
                    where {$where} i.payment_id=d.id and i.languages_id={$this->languages_id}")
            ->all();
    }

    /**
     * @param $delivery_id
     * @param $payment_id
     * @return array|mixed
     */
    public function is($delivery_id, $payment_id)
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