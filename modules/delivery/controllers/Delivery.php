<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\delivery\controllers;

use modules\delivery\models\DeliveryPayment;
use system\Front;

class Delivery extends Front
{
    private $delivery;
    private $deliveryPayment;

    public function __construct()
    {
        parent::__construct();

        $this->deliveryPayment = new DeliveryPayment();
        $this->delivery = new \modules\delivery\models\Delivery();
    }

    public function get()
    {
        return $this->delivery->get();
    }

    public function getPayment()
    {
        $delivery_id = $this->request->post('delivery_id', 'i');
        $payment = $this->deliveryPayment->getPayment($delivery_id);

        $this->response->body(['payment' => $payment])->asJSON();
    }
}