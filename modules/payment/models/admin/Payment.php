<?php
namespace modules\payment\models\admin;
use modules\payment\models\DeliveryPayment;

/**
 * Class payment
 * @package modules\payment\models\admin
 */
class Payment extends \modules\payment\models\Payment
{
    private $deliveryPayment;

    public function __construct()
    {
        parent::__construct();

        $this->deliveryPayment = new DeliveryPayment();
    }

    /**
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);

        $this->beginTransaction();

        $id = $this->createRow('__payment', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['payment_id'] = $id;
            $this->createRow('__payment_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $delivery = $this->request->post('delivery');
        if($delivery){
            foreach ($delivery as $k=>$delivery_id) {
                $this->deliveryPayment->create($delivery_id, $id);
            }
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $info = $this->request->post('info');
        $data = $this->request->post('data');

        if(isset($data['settings']) && !empty($data['settings'])) $data['settings'] = serialize($data['settings']);

        $this->beginTransaction();

        $s = $this->updateRow('__payment', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __payment_info where payment_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['payment_id']     = $id;
                $this->createRow('__payment_info', $item);
            } else {
                $this->updateRow('__payment_info', $aid, $item);
            }
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        /*$payment = $this->request->post('payment');
        if($payment){
            foreach ($payment as $k=>$payment_id) {
                if(in_array($payment_id, $selected)){
                    unset($selected[$payment_id]);
                    continue;
                }
                $this->deliveryPayment->create($id, $payment_id);
            }
        }*/

        $delivery = $this->request->post('delivery');
        $selected = $this->deliveryPayment->getSelectedDelivery($id);
        if($delivery){
            foreach ($delivery as $k=>$delivery_id) {
                if(in_array($delivery_id, $selected)){
                    unset($selected[$delivery_id]);
                    continue;
                }

                $this->deliveryPayment->create($delivery_id, $id);
            }
        }
        if(!empty($selected)){
            foreach ($selected as $k=>$delivery_id) {
                $this->deliveryPayment->delete($delivery_id, $id);
            }
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }


        $this->commit();

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__payment', " id={$id} limit 1");
    }
    public function pub($id)
    {
        return self::$db->update('__payment',['published' => 1], " id={$id} limit 1");
    }

    public function hide($id)
    {
        return self::$db->update('__payment',['published' => 0], " id={$id} limit 1");
    }

}