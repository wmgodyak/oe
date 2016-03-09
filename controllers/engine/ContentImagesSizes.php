<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.03.16 : 15:24
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class ContentImagesSizes
 * @name Розміри зображень
 * @icon fa-book
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class ContentImagesSizes extends Engine
{
    private $contentImagesSizes;

    public function __construct()
    {
        parent::__construct();
        $this->contentImagesSizes = new \models\engine\ContentImagesSizes();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_create'),
                [
                    'class' => 'btn-md b-contentImagesSizes-create'
                ]
            )
        );

        $t = new DataTables();

        $t  -> setId('contentImagesSizes')
            -> ajaxConfig('contentImagesSizes/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('contentImagesSizes.size'))
            -> th($this->t('contentImagesSizes.width'))
            -> th($this->t('contentImagesSizes.height'))
            -> th($this->t('common.tbl_func'), '', 'width: 90px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('content_images_sizes')
            -> get('id,size, width, height')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['size'];
            $res[$i][] = $row['width'];
            $res[$i][] = $row['height'];
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-contentImagesSizes-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-contentImagesSizes-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create()
    {
        $this->template->assign('types',$this->contentImagesSizes->getContentTypes(0));
        $this->template->assign('data', ['types' => []]);
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('content/images/sizes/edit'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('types',$this->contentImagesSizes->getContentTypes(0));
        $this->template->assign('data', $this->contentImagesSizes->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('content/images/sizes/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['size','width','height'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->contentImagesSizes->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->contentImagesSizes->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->contentImagesSizes->getDBErrorMessage();
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->contentImagesSizes->delete($id);
    }
}