<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use controllers\modules\OrdersStatusFactory;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use models\engine\OrdersStatusPayment;

defined("CPATH") or die();

/**
 * Class OrdersStatus
 * @name Статуси замовлень
 * @icon fa-bus
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @position 3
 * @package controllers\engine
 */
class OrdersStatus extends Engine
{
    private $ordersStatus;
    public function __construct()
    {
        parent::__construct();
        $this->ordersStatus = new \models\engine\OrdersStatus();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-ordersStatus-create btn-primary'])
        );

        $t = new DataTables2('ordersStatus');

        $t  -> ajax('ordersStatus/items')
            -> th($this->t('common.id'), 'os.id', true, true, 'width: 20px')
            -> th($this->t('ordersStatus.status'), 'i.status', true, true)
            -> th($this->t('ordersStatus.external_id'), 'os.external_id', true, true, 'width: 280px')
            -> th($this->t('ordersStatus.on_site'), 'os.on_site', true, true, 'width: 280px')
            -> th($this->t('common.tbl_func'), null, false, false, 'width: 180px')
        ;



        if($this->request->isXhr()) {

            $t  -> from('__orders_status os')
                -> join("__orders_status_info i on i.status_id=os.id and i.languages_id={$this->languages_id}")
//                -> get('os.id, i.status, os.external_id, os.is_main, os.on_site, os.bg_color, os.txt_color')
                -> execute();

            $t -> get('bg_color')
               -> get('txt_color');

            if (!$t) {
                echo $t->getError();
                return null;
            }

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $res[$i][] = $row['id'];
                $res[$i][] = "<span class='label' style='background: {$row['bg_color']}; color: {$row['txt_color']}'>{$row['status']}</span>"
                    . ($row['is_main'] ? ' <small class="label label-info">Основний</small>' : '');
                $res[$i][] = "<input class='form-control' value='{$row['external_id']}' onfocus='select()'>";
                $res[$i][] = ($row['on_site'] == 1 ? 'Так' : '');
                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-ordersStatus-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-ordersStatus-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    )
                ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('orders_status/edit'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('data', $this->ordersStatus->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('orders_status/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $ordersStatus_info = $this->request->post('info');
        $s=0; $i=[];

        foreach ($ordersStatus_info as $languages_id=> $item) {
            if(empty($item['status'])){
                $i[] = ["info[$languages_id][status]" => $this->t('ordersStatus.empty_name')];
            }
        }

        if(empty($i)){
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->ordersStatus->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->ordersStatus->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->ordersStatus->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->ordersStatus->delete($id);
    }
}