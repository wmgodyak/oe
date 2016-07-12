<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\currency\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use modules\currency\models\admin\CurrencyRate;
use system\core\DataTables2;
use system\Engine;

class Currency extends Engine
{
    private $currency;
    private $currencyRate;

    public function __construct()
    {
        parent::__construct();
        $this->currency = new \modules\currency\models\admin\Currency();
        $this->currencyRate = new CurrencyRate();
    }

    public function init()
    {
        $this->assignToNav('Валюти', 'module/run/currency', 'fa-money', 'module/run/shop', 100);//, 'module/run/shop'
        $this->template->assignScript("modules/currency/js/admin/currency.js");
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-currency-create'])
        );

        $t = new DataTables2('currency');

        $t  -> ajax('module/run/currency/index')
            -> th($this->t('common.id'), 'id', 1, 1, 'width: 20px')
            -> th($this->t('currency.name'), 'name', 1, 1)
            -> th($this->t('currency.code'), 'code', 1, 1, 'width: 140px')
            -> th($this->t('currency.symbol'), 'symbol', 1, 1, 'width: 140px')
            -> th($this->t('currency.is_main'), 'is_main', 1, 1, 'width: 140px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 140px')
        ;

        if($this->request->isXhr()){
            $t  -> from('__currency');
            $t  -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['code'];
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

            echo $t->render($res, $t->getTotal());return;
        }

        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('old_currencies', $this->currencyRate->getOldCurrencies());

        $this->response->body($this->template->fetch('currency/edit'))->asHtml();
    }
    public function edit($id)
    {
        $data = $this->currency->getData($id);
        $data['rate'] = $this->currencyRate->get($id);

        $this->template->assign('data', $data);
        $this->template->assign('action', 'edit');
        $this->template->assign('old_currencies', $this->currencyRate->getOldCurrencies($id));
        $this->response->body($this->template->fetch('currency/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $currency = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['name','symbol','code'], FormValidation::REQUIRED);

        FormValidation::run($currency);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->currency->create();
                    $this->currencyRate->update($s);
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->currency->update($id);
                        $this->currencyRate->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->currency->getErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        echo $this->currency->delete($id);
    }
}