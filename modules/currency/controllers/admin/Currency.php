<?php

namespace modules\currency\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataTables2;
use system\Backend;
use system\core\Session;

/**
 * Class Currency
 * @package modules\currency\controllers\admin
 */
class Currency extends Backend
{
    private $currency;

    public function __construct()
    {
        parent::__construct();
        $this->currency = new \modules\currency\models\admin\Currency();
    }

    public function init()
    {

        $main = $this->currency->getMainMeta('id,code,rate,symbol');
        $site = $this->currency->getOnSiteMeta('id,code,rate,symbol');

        Session::set('currency', ['main' => $main, 'site' => $site ]);

        $this->assignToNav(t('currency.action_index'), 'module/run/currency', 'fa-money', 'settings', 100);//, 'module/run/shop'
        $this->template->assignScript("modules/currency/js/admin/currency.js");
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create(t('common.button_create'), ['class' => 'btn-md btn-primary b-currency-create'])
        );

        $t = new DataTables2('currency');

        $t  -> ajax('module/run/currency/index')
            -> th(t('common.id'), 'id', 1, 1, 'width: 20px')
            -> th(t('currency.name'), 'name', 1, 1)
            -> th(t('currency.code'), 'code', 1, 1, 'width: 140px')
            -> th(t('currency.rate'), 'rate', 1, 1, 'width: 140px')
            -> th(t('currency.symbol'), 'symbol', 1, 1, 'width: 140px')
            -> th(t('currency.is_main'), 'is_main', 1, 1, 'width: 140px')
            -> th(t('currency.on_site'), 'on_site', 1, 1, 'width: 140px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 140px')
        ;

        if($this->request->isXhr()){
            $t  -> from('__currency');
            $t  -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['code'];
                $res[$i][] = $row['rate'];
                $res[$i][] = $row['symbol'];
                $res[$i][] = $row['is_main'] ? 'ТАК' : '';
                $res[$i][] = $row['on_site'] ? 'ТАК' : '';
                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-currency-edit btn-primary', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-currency-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
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
        return $this->template->fetch('modules/currency/edit');
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->currency->getMeta($id));
        $this->template->assign('action', 'edit');
        return $this->template->fetch('modules/currency/edit');
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $currency = (array)$this->request->post('data');
        $s=0; $i=[];

        $v_status = $this->validator->run
        (
            $currency,
            [
                'name' => 'required',
                'symbol' => 'required|alpha',
                'rate' => 'required',
                'code' => 'required|alpha'
            ]
        );
        if(! $v_status){
            $i = $this->validator->getErrors();
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
            if(! $s ){
                $i[]= ['name' => $this->currency->getErrorMessage()];
            }
        }

        return ['s'=>$s, 'i' => $i];
    }

    public function delete($id)
    {
        return $this->currency->delete($id);
    }
}