<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 17:22
 */

namespace modules\order\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use modules\delivery\models\DeliveryPayment;
use modules\order\models\admin\OrdersProducts;
use modules\order\models\admin\OrdersStatus;
use modules\order\models\admin\StatusHistory;
use system\core\DataTables2;
use system\Engine;
use system\models\Currency;
use system\models\Users;

defined("CPATH") or die();

/**
 * Class Order
 * @package modules\order\controllers\admin
 */
class Order extends Engine
{
    private $order;
    private $orderProducts;
    private $currency;
    private $deliveryPayment;
    private $ordersStatus;
    private $users;
    private $history;
    private $os;

    public function __construct()
    {
        parent::__construct();

        $this->order = new \modules\order\models\admin\Order();
        $this->orderProducts = new OrdersProducts();
        $this->currency = new Currency();
        $this->deliveryPayment = new DeliveryPayment();
        $this->ordersStatus = new \modules\order\models\admin\Status();
        $this->users = new Users();
        $this->history = new StatusHistory();
        $this->os = new OrdersStatus();
    }

    public function init()
    {
        $this->assignToNav('Замовлення', 'module/run/order', 'fa-money', null, 100);
        $this->assignToNav('Замовлення', 'module/run/order', 'fa-money', 'module/run/order', 1);

        $this->assignToNav('Статуси', 'module/run/order/status', 'fa-money', 'module/run/order', 1);
        $this->template->assignScript('modules/order/js/admin/order.js');
    }

    public function index()
    {
        $t = new DataTables2('orders');

        $t  -> ajax('module/run/order')
            -> th($this->t('order.oid'), 'o.oid', 1, 1, 'width: 160px')
            -> th($this->t('order.status.status'), "osi.status", 1, 1, 'width:100px')
            -> th($this->t('order.username'), "concat(u.surname, ' ', u.name) as username", 1, 1)
            -> th($this->t('order.amount') .', '. $this->currency->getOnSiteMeta('symbol'), null, 0, 0, 'width: 160px')
            -> th($this->t('order.paid'), 'o.paid', 0, 1, 'width: 20px')
            -> th($this->t('order.created'), 'o.created', 0, 1, 'width: 180px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
            -> orderDef(0, 'desc')
            -> get('o.id', null, 0, 0)
            -> get('o.status_id', null, 0, 0)
            -> get('o.one_click', null, 0, 0)
            -> get('os.bg_color', null, 0, 0)
            -> get('os.txt_color', null, 0, 0)
        ;

        if($this->request->isXhr()){

            $t  -> from('__orders o')
                -> join('__users u on u.id=o.users_id')
                -> join("__orders_status os on os.id=o.status_id")
                -> join("__orders_status_info osi on osi.status_id=o.status_id and osi.languages_id={$this->languages_id}")
                -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['oid'];
                $res[$i][] = "<span class='label' style='background: {$row['bg_color']}; color:{$row['txt_color']}'>{$row['status']}</span>";
                $res[$i][] = $row['username']
                    . ($row['one_click'] ? " <label class='label label-info'>Один клік</label>" : "");
                $res[$i][] = $this->orderProducts->amount($row['id']);
                $res[$i][] = $row['paid'] == 1 ? 'ТАК' : '';
                $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));

                if($row['status_id'] != 2){
                    $res[$i][] =
                        (string)Button::create
                        (
                            Icon::create(Icon::TYPE_EDIT),
                            ['class' => 'b-orders-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                        ) .
                        (string)Button::create
                        (
                            Icon::create(Icon::TYPE_DELETE),
                            ['class' => 'b-orders-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                        )
                    ;
                } else {
                    $res[$i][] = '';
                }
            }

            echo $t->render($res, $t->getTotal());return;
        }

        $this->output($t->init());
    }
    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id, $tab = null)
    {
        $data = $this->order->getData($id);
        if(empty($data)) {
            $this->response->sendError(403, 1);
        }

        switch($tab){
            case 'info':
                $this->editInfo($data);
                break;
            case 'products':
                $this->editProducts($data);
                break;
            case 'history':
                $this->editHistory($data);
                break;
            default:
                $s=0;

                // assign to manager
                if(empty($data['manager_id'])){
                    $this->order->update($id, ['manager_id' => $this->admin['id']]);
                    $this->os->change($id, 3, $this->admin['id']);
                }

                $dt = date('d.m.Y H:i:s', strtotime($data['created']));
                $t = "Редагування замовлення №{$data['oid']}. Від {$dt}";
                $this->template->assign('id', $data['id']);

                $m = $this->template->fetch('orders/form/index');

                $this->response->body(['s' => $s, 'm' => $m, 't' => $t])->asJSON();

                break;
        }
    }

    private function editInfo($order)
    {
        $this->template->assign('order', $order);
        $this->template->assign('delivery', $this->deliveryPayment->getDelivery());
        $this->template->assign('payment', $this->deliveryPayment->getPayment($order['delivery_id']));
        $this->template->assign('status', $this->ordersStatus->get());
        $this->template->assign('users', $this->users->get());

        echo $this->template->fetch('orders/form/info');
    }

    private function editHistory($order)
    {
        $this->template->assign('order', $order);
        $this->template->assign('history', $this->history->history($order['id']));
        echo $this->template->fetch('orders/form/history');
    }

    private function editProducts($order)
    {
        $this->template->assign('products', $this->orderProducts->get($order['id']));
        $this->template->assign('amount', $this->orderProducts->amount($order['id']));
        $this->template->assign('order', $order);
        echo $this->template->fetch('orders/form/products');
    }

    public function delete($id)
    {
        echo $this->order->delete($id, $this->admin['id']);
    }

    public function process($id)
    {
        if(! $this->request->isPost()) die;
        $s= 0; $m=0;
        $oData = $this->order->getData($id);

        $data = $this->request->post('data');
        $this->order->beginTransaction();
        $this->order->update($id, $data);

        if($oData['status_id'] != $data['status_id']){
            $this->os->change($id, $data['status_id'], $this->admin['id'], $this->request->post('s_comment', 's'));
        }
        if($this->order->hasError()){
            $this->order->rollback();
        } else {
            $this->order->commit();
            $s=1;
            $m = 'Дані збережено';
        }
        $this->response->body(['s' => $s, 'm' => $m])->asJSON();
    }

    public function status()
    {
        include "Status.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Status();

        call_user_func_array(array($controller, $action), $params);
    }
    public function products()
    {
        include "Products.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Products();

        call_user_func_array(array($controller, $action), $params);
    }

}