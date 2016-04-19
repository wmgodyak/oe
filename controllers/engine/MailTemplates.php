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
 * Class MailTemplates
 * @name Шаблони email повідомлень
 * @icon fa-envelope-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class MailTemplates extends Engine
{
    private $mailTemplates;

    public function __construct()
    {
        parent::__construct();
        $this->mailTemplates = new \models\engine\MailTemplates();
    }

    public function index()
    {
        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-mailTemplates-create']));

        $t = new DataTables();

        $t  -> setId('mailTemplates')
            -> ajaxConfig('mailTemplates/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('mailTemplates.name'))
            -> th($this->t('mailTemplates.code'))
            -> th($this->t('common.tbl_func'), '', 'width: 120px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('__mail_templates t')
            -> get('t.id, t.name, t.code')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['name'];
            $res[$i][] = "<input onfocus='select();' style='width: 300px;' class='form-control' value='{$row['code']}'>";
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-mailTemplates-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-mailTemplates-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )

            ;
        }

        return $t->renderJSON($res, $t->getTotal());

//        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('mail_templates/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->mailTemplates->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('mail_templates/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $s=0; $i=[];

        FormValidation::setRule(['code', 'name'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->mailTemplates->is($data['code'], $id)){
            $i[] = ["data[code]" => $this->t('mailTemplates.code_isset')];
        } else {
           /*foreach ($info as $languages_id=> $item) {
                if(empty($item['subject'])){
                    $i[] = ["info[$languages_id][subject]" => $this->t('mailTemplates.empty_value')];
                }
                if(empty($item['body'])){
                    $i[] = ["info[$languages_id][body]" => $this->t('mailTemplates.empty_value')];
                }
            }*/
            if(empty($i)){
                switch($this->request->post('action')){
                    case 'create':
                        $s = $this->mailTemplates->create();
                        break;
                    case 'edit':
                        if( $id > 0 ){
                            $s = $this->mailTemplates->update($id);
                        }
                        break;
                }
                if(! $s){
                    echo $this->mailTemplates->getDBErrorMessage();
                }
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->mailTemplates->delete($id);
    }

}