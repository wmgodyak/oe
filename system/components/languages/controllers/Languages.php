<?php

namespace system\components\languages\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Engine;

defined("CPATH") or die();

class Languages extends Engine
{
    public function index()
    {

        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-languages-create']));

        $t = new DataTables2('languages');

        $t
            -> th($this->t('common.id'), 'id')
            -> th($this->t('languages.name'), 'name', true, true)
            -> th($this->t('languages.code'), 'code', true, true)
            -> th($this->t('languages.is_main'), 'is_main')
            -> th($this->t('common.tbl_func'), null, false, false, 'width:160px');
//        ;

        $t-> ajax('languages/index');


        if($this->request->isXhr()){

            $t  -> from('__languages')
                -> get('id,name,code,is_main')
                -> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['code'];
                $res[$i][] = ($row['is_main'] == 1 ? "<label class='label'>ТАК</label>" : "");
                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-languages-edit  btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    ($row['is_main'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-languages-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    ) : "")

                ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('languages/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->languages->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('languages/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[];

        FormValidation::setRule(['name', 'code'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->languages->create($data);
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->languages->update($id, $data);
                    }
                    break;
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();

    }
    public function delete($id)
    {
        return $this->languages->delete($id);
    }
}