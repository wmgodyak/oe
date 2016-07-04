<?php
namespace modules\delivery\models\admin;
use modules\delivery\models\DeliveryPayment;

/**
 * Class Delivery
 * @package modules\delivery\models\admin
 */
class Delivery extends \modules\delivery\models\Delivery
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

        $id = $this->createRow('__delivery', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['delivery_id'] = $id;
            $this->createRow('__delivery_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $payment = $this->request->post('payment');
        foreach ($payment as $k=>$payment_id) {
            $this->deliveryPayment->create($id, $payment_id);
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

        $s = $this->updateRow('__delivery', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __delivery_info where delivery_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['delivery_id']     = $id;
                $this->createRow('__delivery_info', $item);
            } else {
                $this->updateRow('__delivery_info', $aid, $item);
            }
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $selected = $this->deliveryPayment->getSelectedPayment($id);
        $payment = $this->request->post('payment');
        if($payment){
            foreach ($payment as $k=>$payment_id) {
                if(in_array($payment_id, $selected)){
                    unset($selected[$payment_id]);
                    continue;
                }
                $this->deliveryPayment->create($id, $payment_id);
            }
        }
        if(!empty($selected)){
            foreach ($selected as $k=>$payment_id) {
                $this->deliveryPayment->delete($id, $payment_id);
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
        return self::$db->delete('__delivery', " id={$id} limit 1");
    }
    public function pub($id)
    {
        return self::$db->update('__delivery',['published' => 1], " id={$id} limit 1");
    }

    public function hide($id)
    {
        return self::$db->update('__delivery',['published' => 0], " id={$id} limit 1");
    }

}