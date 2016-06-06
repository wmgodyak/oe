<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use controllers\modules\PaymentFactory;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use models\engine\DeliveryPayment;

defined("CPATH") or die();

/**
 * Class Payment
 * @name Оплата
 * @icon fa-credit-card
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Payment extends Engine
{
    private $payment;
    const MOD_PATH = 'controllers/modules/payment/';

    public function __construct()
    {
        parent::__construct();
        $this->payment = new \models\engine\Payment();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-payment-create'])
        );
        $t = new DataTables2('payment');

        $t  -> ajax('payment/items')
            -> th($this->t('common.id'), 'd.id', 1,1, 'width: 20px')
            -> th($this->t('payment.name'), 'i.name', 1, 1)
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
            -> get('d.published')
        ;

        $this->output($t->init());
    }

    public function items()
    {
        $t = new DataTables2();
        $t  -> from('__payment d')
            -> join("__payment_info i on i.payment_id=d.id and i.languages_id={$this->languages_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['name'];
            $res[$i][] =
                (string)(
                $row['published'] ?
                    Button::create
                    (
                        Icon::create(Icon::TYPE_PUBLISHED),
                        [
                            'class' => 'b-payment-hide',
                            'title' => $this->t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Button::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => 'b-payment-pub',
                            'title' => $this->t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ).
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-payment-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-payment-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->render($res, $t->getTotal());
   }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('delivery', DeliveryPayment::getDelivery());
        $this->template->assign('modules', $this->getModules());
        $this->response->body($this->template->fetch('payment/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->payment->getData($id));
        $this->template->assign('delivery', DeliveryPayment::getDelivery());
        $this->template->assign('selected', DeliveryPayment::getSelectedDelivery($id));
        $this->template->assign('action', 'edit');
        $this->template->assign('modules', $this->getModules());
        $this->response->body($this->template->fetch('payment/edit'))->asHtml();
    }

    private function getModules()
    {
        $items = array();
        if ($handle = opendir(DOCROOT . self::MOD_PATH)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".." ) {

                    $module = str_replace('.php', '', $entry);

                    $items[] = $module;
                }
            }
            closedir($handle);
        }

        return $items;
    }

    public function getModuleSettings()
    {
        $module = $this->request->post('module');
        $db_settings = $this->payment->getSettings($module);

        $settings = PaymentFactory::getSettings($module);

        $res = [];$i=0;
        foreach ($settings as $k=>$v) {
            $res[$i]['name']  = $k;
            $res[$i]['value'] = isset($db_settings[$k]) ? $db_settings[$k] : null;
            $i++;
        }
        $this->response->body(['s' => $res])->asJSON();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $payment_info = $this->request->post('info');
        $s=0; $i=[];

        foreach ($payment_info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => $this->t('payment.empty_name')];
            }
        }



        if(empty($i)){
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->payment->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->payment->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->payment->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->payment->delete($id);
    }

    public function pub($id)
    {
        return $this->payment->pub($id);
    }

    public function hide($id)
    {
        return $this->payment->hide($id);
    }

}