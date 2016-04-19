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
 * Class Languages
 * @name Мови
 * @icon fa-flag
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Languages extends Engine
{
    public function index()
    {
        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-languages-create']));

        $t = new DataTables();

        $t  -> setId('languages')
            -> ajaxConfig('languages/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('languages.name'))
            -> th($this->t('languages.code'))
            -> th($this->t('languages.is_main'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('__languages')
            -> get('id,name,code,is_main')
            -> execute();

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
                    ['class' => 'b-languages-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['is_main'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-languages-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                ) : "")

            ;
        }

        return $t->renderJSON($res, $t->getTotal());

//        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
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