<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use models\engine\DeliveryPayment;

defined("CPATH") or die();

/**
 * Class Delivery
 * @name Доставка
 * @icon fa-bus
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Delivery extends Engine
{
    private $delivery;

    public function __construct()
    {
        parent::__construct();
        $this->delivery = new \models\engine\Delivery();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-delivery-create'])
        );
        $t = new DataTables();

        $t  -> setId('delivery')
            -> ajaxConfig('delivery/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('delivery.name'))
            -> th($this->t('delivery.price'))
            -> th($this->t('delivery.free_from'))
            -> th($this->t('common.tbl_func'), '', 'width: 180px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('delivery d')
            -> join("delivery_info i on i.delivery_id=d.id and i.languages_id={$this->languages_id}")
            -> get('d.id,i.name,d.price,d.free_from,d.published')

            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['name'];
            $res[$i][] = $row['price'];
            $res[$i][] = $row['free_from'];
            $res[$i][] =
                (string)(
                $row['published'] ?
                    Button::create
                    (
                        Icon::create(Icon::TYPE_PUBLISHED),
                        [
                            'class' => 'btn-primary b-delivery-hide',
                            'title' => $this->t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Button::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => 'btn-primary b-delivery-pub',
                            'title' => $this->t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ).
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-delivery-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-delivery-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
   }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('payment', DeliveryPayment::getPayment());
        $this->response->body($this->template->fetch('delivery/edit'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('data', $this->delivery->getData($id));
        $this->template->assign('action', 'edit');
        $this->template->assign('payment', DeliveryPayment::getPayment());
        $this->template->assign('selected', DeliveryPayment::getSelectedPayment($id));
        $this->response->body($this->template->fetch('delivery/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $delivery_info = $this->request->post('info');
        $s=0; $i=[];

        foreach ($delivery_info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => $this->t('delivery.empty_name')];
            }
        }

        if(empty($i)){
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->delivery->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->delivery->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->delivery->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->delivery->delete($id);
    }

    public function pub($id)
    {
        return $this->delivery->pub($id);
    }

    public function hide($id)
    {
        return $this->delivery->hide($id);
    }

}