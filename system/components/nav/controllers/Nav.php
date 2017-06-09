<?php

namespace system\components\nav\controllers;

use system\Backend;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\core\DataTables2;

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
        $this->assignToNav(t('nav.action_index'), 'nav', 'fa-nav', 'tools', 100);
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'nav/create']
            )
        );


        $t = new DataTables2('nav');

        $t
            -> ajax('nav/items')
            -> th(t('common.id'), 'id', false, false, 'width: 40px')
            -> th(t('nav.name'), 'name')
            -> th(t('nav.code'), 'code', 0, 0, 'width: 300px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 200px')
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
                        'title' => t('common.title_edit')
                    ]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-nav-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                )
            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create()
    {
        $id = $this->nav->create(['name' => 'blank', 'code' => time()]);

        return $this->edit($id);
    }


    public function edit($id)
    {
        $data = $this->nav->getData($id);
        if(empty($data)) redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.back'),
                ['class' => 'btn-md', 'href'=> 'nav']
            )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $this->template->assign('data', $data);
        $this->template->assign('action', 'edit');
        $this->template->assign('mNav', $this->nav);
        $this->output($this->template->fetch('system/nav/form'));
    }

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
                    $s = $this->nav->create($data);
                    break;
                case 'edit':
                    $s = $this->nav->update($id);
                    break;
            }

        }

        if($this->nav->hasError()){
            $m = $this->nav->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'm' => $m];
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
        if(empty($nav_id) || empty($item_id)) die;

        $s = $this->nav->addItem($nav_id, $item_id);
//        echo $this->nav->getErrorMessage();

       return ['s'=>$s];
    }

    public function getNavItems($nav_id = null)
    {
        if(empty($nav_id)) die;

        return ['items' => $this->nav->getSelectedItems($nav_id)];
    }

    public function createItem($parent_id)
    {
        $this->template->assign('id', $parent_id);
        $this->template->assign('languages', $this->languages->languages->get());
        $this->template->assign('action', 'create');
        $this->template->display('system/nav/itemForm');
    }

    public function editItem($id)
    {
        $this->template->assign('id', $id);
        $this->template->assign('data', $this->nav->items->getData($id));
        $this->template->assign('info', $this->nav->items_info->getData($id));
        $this->template->assign('languages', $this->languages->languages->get());
        $this->template->assign('action', 'edit');
        $this->template->display('system/nav/itemForm');
    }

    public function updateItem($id)
    {
       $m = t('common.save_success');

        if($this->request->post('action') == 'create'){
            $s = $this->nav->createItem($id);
        } else {
            $s = $this->nav->updateItem($id);
        }

       if(! $s) $m = $this->nav->getErrorMessage();

       return ['s'=>$s, 'm' => $m];
    }

    public function reorderItems()
    {
        $nav_id = $this->request->post('id');
        $items = $this->request->post('items');

        if(empty($items)) return;

        $s = $this->nav->items->reorder($nav_id, $items);

        echo $s ? 1 : 0;
    }
}