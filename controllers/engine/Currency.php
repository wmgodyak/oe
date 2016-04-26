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
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class Currency
 * @name Валюти
 * @icon fa-money
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Currency extends Engine
{
    private $currency;

    public function __construct()
    {
        parent::__construct();
        $this->currency = new \models\engine\Currency();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-currency-create'])
        );
        $t = new DataTables();

        $t  -> setId('currency')
            -> ajaxConfig('currency/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('currency.name'))
            -> th($this->t('currency.code'))
            -> th($this->t('currency.rate'))
            -> th($this->t('currency.symbol'))
            -> th($this->t('currency.is_main'))
            -> th($this->t('common.tbl_func'), '', 'width: 140px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('__currency')
            -> get('id,name,code,rate,symbol,is_main');
        $t  -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['name'];
            $res[$i][] = $row['code'];
            $res[$i][] = $row['rate'];
            $res[$i][] = $row['symbol'];
            $res[$i][] = $row['is_main'] ? 'ТАК' : '';
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-currency-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-currency-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
   }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('currency/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->currency->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('currency/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $currency = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['name','symbol','rate','code'], FormValidation::REQUIRED);

        FormValidation::run($currency);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->currency->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->currency->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->currency->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->currency->delete($id);
    }

}