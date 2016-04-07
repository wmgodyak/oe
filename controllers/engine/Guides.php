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
use helpers\bootstrap\Link;
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class Guides
 * @name Довідники
 * @icon fa-book
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Guides extends Engine
{
    private $guides;

    public function __construct()
    {
        parent::__construct();
        $this->guides = new \models\engine\Guides();
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $_parent_id = $this->guides->getData($parent_id, 'parent_id');
            $this->appendToPanel((string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> './guides/index' . ($_parent_id>0 ? '/' . $_parent_id : '')]
            )
            );
        }
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_create'),
                [
                    'class' => 'btn-md b-guides-create',
                    'data-parent_id' => $parent_id
                ]
            )
        );

        $t = new DataTables();

        $t  -> setId('guides')
            -> ajaxConfig('guides/items' . ($parent_id > 0 ? "/{$parent_id}" : ''))
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('guides.name'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items($parent_id=0)
    {
        $t = new DataTables();
        $t  -> table('guides g')
            -> get('g.id,gi.name, g.code')
            -> join("guides_info gi on gi.guides_id=g.id and gi.languages_id={$this->languages_id}");
           if($parent_id>0){
               $t->where("g.parent_id = {$parent_id}");
           }
        $t  -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='guides/index/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-guides-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-guides-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
   }

    public function create($parent_id=0)
    {
        $this->template->assign('data', ['parent_id' => $parent_id]);
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('guides/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->guides->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('guides/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

//        $guides = $this->request->post('guides');
        $guides_info = $this->request->post('guides_info');
        $s=0; $i=[];

        /*FormValidation::setRule(['code'], FormValidation::REQUIRED);

        FormValidation::run($guides);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {*/
            foreach ($guides_info as $languages_id=> $item) {
                if(empty($item['name'])){
                    $i[] = ["guides_info[$languages_id][name]" => $this->t('guides.empty_name')];
                }
            }
            if(empty($i)){
                switch($this->request->post('action')){
                    case 'create':
                        $s = $this->guides->create();
                        break;
                    case 'edit':
                        if( $id > 0 ){
                            $s = $this->guides->update($id);
                        }
                        break;
                }
                if(! $s){
                    echo $this->guides->getDBErrorMessage();
                }
            }
//        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->guides->delete($id);
    }

}