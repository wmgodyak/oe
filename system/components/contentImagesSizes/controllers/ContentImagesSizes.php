<?php

namespace system\components\contentImagesSizes\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Engine;

defined("CPATH") or die();

/**
 * Class ContentImagesSizes
 * @package system\components\blank\controllers
 */
class ContentImagesSizes extends Engine
{
    private $contentImagesSizes;

    public function __construct()
    {
        parent::__construct();
        $this->contentImagesSizes = new \system\components\contentImagesSizes\models\ContentImagesSizes();
    }

    public function init()
    {
        $this->assignToNav('Розміри зображень', 'contentImagesSizes', 'fa-users', 'tools', 10);
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

        $t = new DataTables2('contentImagesSizesList');

        $t
            -> th($this->t('common.id'), 'id', null, null, 'width: 20px')
            -> th($this->t('contentImagesSizes.size'), 'size', 1, 1)
            -> th($this->t('contentImagesSizes.width'), 'width', 1, 1)
            -> th($this->t('contentImagesSizes.height'), 'height', 1, 1)
            -> th($this->t('common.tbl_func'), null, null, null, 'width: 180px')
            -> ajax('contentImagesSizes/items')
        ;

        $this->output
        (
            '<div id="resizeBox" class="row" style="display: none"><div id="progress" class=\'progress progress-thin progress-striped active\'><div style=\'width: 0;\' class=\'progress-bar progress-bar-success\'></div></div></div>'.
            $t->init()
        );
    }

    public function items()
    {
        $t = new DataTables2();
        $t  -> from('__content_images_sizes')
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
                    Icon::create(Icon::TYPE_CROP),
                    ['class' => 'b-contentImagesSizes-crop', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-contentImagesSizes-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-contentImagesSizes-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->render($res, $t->getTotal());
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
                echo $this->contentImagesSizes->getErrorMessage();
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->contentImagesSizes->delete($id);
    }

    public function resizeGetTotal()
    {
        $size_id = $this->request->post('sizes_id', 'i');
        if(empty($size_id)) die(0);

        $t = $this->contentImagesSizes->resizeGetTotal($size_id);
        echo $this->contentImagesSizes->getErrorMessage();
        $this->response->body($t)->asHtml();
    }

    public function resizeItems()
    {
        $num = 1;
        $size_id = $this->request->post('sizes_id', 'i');
        $start   = $this->request->post('start', 'i');
        if($start > 0){
            $start = $start * $num;
        }

        $s = $this->contentImagesSizes->resizeItems($size_id, $start, $num);

        $this->response->body($s)->asHtml();
    }
}