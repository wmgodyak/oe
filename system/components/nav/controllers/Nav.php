<?php

namespace system\components\nav\controllers;

use system\core\DataTables2;
use system\Backend;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;

defined("CPATH") or die();

class Nav extends Backend
{
    private $nav;

    public function __construct()
    {
        parent::__construct();

        $this->nav = new \system\components\nav\models\Nav();
    }

    public function init()
    {
        $this->assignToNav('Менеджер меню', 'nav', 'fa-nav', 'tools', 100);
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'nav/create']
            )
        );


        $t = new DataTables2('nav');

        $t
            -> ajax('nav/items')
            -> th($this->t('common.id'), 'id', false, false, 'width: 40px')
            -> th($this->t('nav.name'), 'name')
            -> th($this->t('nav.code'), 'code', 0, 0, 'width: 300px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 200px')
        ;

        $this->output($t->init());
    }

    public function items()
    {
        $t = new DataTables2();
        $t  -> from('__nav')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {

            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='nav/edit/{$row['id']}'> {$row['name']}</a>";
            $res[$i][] = "<input type='text' class='form-control' readonly onfocus='select();' value='{$row['code']}'>";
            $res[$i][] =
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    [
                        'class' => 'btn-primary',
                        'href' => 'nav/edit/' . $row['id'],
                        'title' => $this->t('common.title_edit')
                    ]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-nav-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create()
    {
        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> 'nav']
            )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $this->template->assign('action', 'create');
        $this->template->assign('items', $this->nav->getItems(0));
        $this->output($this->template->fetch('system/nav/form'));
    }


    public function edit($id)
    {
        $data = $this->nav->getData($id);
        if(empty($data)) $this->redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> 'nav']
            )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $this->template->assign('data', $data);
        $this->template->assign('action', 'edit');
        $this->template->assign('items', $this->nav->getItems(0));
        $this->output($this->template->fetch('system/nav/form'));
    }

    /**
     * @param null $id
     * @throws \Exception
     */
    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');

        $s=0; $i=[]; $m=null;

        FormValidation::setRule(['code'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->nav->create();
                    break;
                case 'edit':
                    $s = $this->nav->update($id);
                    break;
            }

        }

        if($this->nav->hasError()){
            $m = $this->nav->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        return $this->nav->delete($id);
    }

    /**
     * @param $id
     * @return mixed
     */
    public function deleteItem($id)
    {
        return $this->nav->deleteItem($id);
    }

    public function addItem()
    {
        $nav_id  = $this->request->post('nav_id', 'i');
        $item_id = $this->request->post('item_id', 'i');
        if(empty($nav_id) || empty($item_id)) return 0;

        $items = null;
        $s = $this->nav->addItem($nav_id, $item_id);
        if($s){
            $items = $this->nav->getSelectedItems($nav_id);
        }
//        echo $this->nav->getErrorMessage();

        $this->response->body(['s'=>$s, 'items' => $items])->asJSON();
    }
}