<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 12:12
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;

defined("CPATH") or die();
/**
 * Class Nav
 * @name Менеждер меню
 * @icon fa-bars
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Nav extends Engine
{
    private $nav;

    public function __construct()
    {
        parent::__construct();

        $this->nav = new \models\engine\Nav();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md', 'href'=> 'nav/create']
            )
        );
  

        $t = new DataTables();

        $t  -> setId('nav')
            -> ajaxConfig('nav/items')
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('nav.name'))
            -> th($this->t('nav.code'), '', 'width: 200px')
            -> th($this->t('common.tbl_func'), '', 'width: 200px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('nav')
            -> get('id, name, code')
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
                    ['class' => 'b-nav-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
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
        $this->output($this->template->fetch('nav/form'));
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
        $this->output($this->template->fetch('nav/form'));
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

        if($this->nav->hasDBError()){
            $m = $this->nav->getDBErrorMessage();
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
//        echo $this->nav->getDBErrorMessage();

        $this->response->body(['s'=>$s, 'items' => $items])->asJSON();
    }
}