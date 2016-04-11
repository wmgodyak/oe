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
 * Class Features
 * @name Властивості
 * @icon fa-file-code-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Features extends Engine
{
    private $features;

    public function __construct()
    {
        parent::__construct();

        $this->features = new \models\engine\Features();
    }

    public function index($parent_id=0)
    {
        $data = [];
        if($parent_id > 0){

            $data = $this->features->getData($parent_id, 'parent_id,type');
            if(empty($data)) $this->redirect('/404');
            $this->appendToPanel
            (
                (string)Link::create
                    (
                        $this->t('common.back'),
                        ['class' => 'btn-md', 'href'=> './features/index' . ($data['parent_id']>0 ? '/' . $data['parent_id']     : '')]
                    )
            );

            if($data['type'] == 'select'){

                $this->appendToPanel
                (
                    (string)Button::create
                    (
                        $this->t('features.createValue'),
                        ['class' => 'btn-md b-features-add-value', 'data-id'=> $parent_id]
                    )
                );
            }
        }
        if(!isset($data['type']) || $data['type'] != 'select'){
            $this->appendToPanel
            (
                (string)Link::create
                (
                    $this->t('common.button_create'),
                    ['class' => 'btn-md', 'href'=> 'features/create' . ($parent_id>0? "/{$parent_id}" : '')]
                )
            );
        }

        $t = new DataTables();

        $t  -> setId('features')
            -> ajaxConfig('features/items/'.$parent_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('features.name'))
            -> th($this->t('features.code'))
            -> th($this->t('features.type'))
            -> th($this->t('common.tbl_func'), '', 'width: 200px')
        ;

        $this->output($t->render());
    }

    public function items($parent_id=0)
    {
        $t = new DataTables();
        $t  -> table('features f')
            -> join("features_info i on i.features_id=f.id and i.languages_id={$this->languages_id}")
            -> get('f.id, i.name, f.code,f.type, f.status')
            -> where("f.parent_id = {$parent_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {

            if($row['type'] == 'value'){
                $a = 'javascript:;';
            } elseif($row['type'] == 'folder' || $row['type'] == 'select'){
                $a = "features/index/{$row['id']}";
            } else {
                $a = "features/edit/{$row['id']}";
            }

            switch($row['type']){
                case 'text':
                case 'textarea':
                    $it = 'font';
                    break;
                case 'select':
                    $it = 'list';
                    break;
                case 'file':
                    $it = 'file';
                    break;
                case 'folder':
                    $it = 'folder';
                    break;
                case 'checkbox':
                    $it = 'check-square-o';
                    break;
                default:
                    $it = 'question';
                    break;
            }
//            $it = $row['type'] == 'folder' ? 'folder' : 'file';

            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='{$a}'><i class='fa fa-{$it}'></i> {$row['name']}</a>";
            $res[$i][] = $row['code'];
            $res[$i][] = $this->t('features.type_' . $row['type']);
            $res[$i][] =
                (string)(
                $row['status'] == 'published' ?
                    Button::create
                    (
                        Icon::create(Icon::TYPE_PUBLISHED),
                        [
                            'class' => 'btn-primary b-features-hide',
                            'title' => $this->t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Button::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => 'btn-primary b-features-pub',
                            'title' => $this->t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    [
                        'class' => 'btn-primary' . ($row['type'] == 'value' ? ' b-features-edit-value' : ''),
                        'data-id' => $row['id'],
                        'href' => "features/edit/{$row['id']}",
                        'title' => $this->t('common.title_edit')
                    ]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-features-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create($parent_id = 0)
    {
        $id = $this->features->createBlank($parent_id);
        return $this->edit($id);
    }

    /**
     * @param $id
     */
    public function edit($id)
    {
        $data = $this->features->getData($id);
        if(empty($data)) $this->redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> 'features' . ($data['parent_id'] > 0 ? '/index/' . $data['parent_id'] : '')]
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
//        $this->template->assign('content_types', $this->features->getContentTypes(0));
        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('features/form'));
    }

    /**
     * @param null $id
     * @throws \Exception
     */
    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $s=0; $i=[]; $m=null;

        FormValidation::setRule(['code'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            foreach ($info as $languages_id=> $item) {
                if(empty($item['name'])){
                    $i[] = ["info[$languages_id][name]" => $this->t('features.empty_name')];
                }
            }
            if(empty($i)) {
                $s = $this->features->update($id);
            }
        }

        if($this->features->hasDBError()){
            $m = $this->features->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        return $this->features->delete($id);
    }


    public function pub($id)
    {
        return $this->features->pub($id);
    }

    public function hide($id)
    {
        return $this->features->hide($id);
    }

    /**
     * @param $parent_id
     */
    public function addValue($parent_id){
        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);
        $this->template->assign('action', 'create');
        $this->output($this->template->fetch('features/value'));
    }

    /**
     * @param $id
     */
    public function editValue($id){
        $data = $this->features->getData($id);
        unset($data['parent_id']);
        $this->template->assign('data', $data);
        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('features/value'));
    }

    public function processValue()
    {
        if(! $this->request->isPost()) die;

        $info = $this->request->post('info');

        $s=0; $i=[]; $m=null;

        foreach ($info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => $this->t('features.empty_value')];
            }
        }

        if(empty($i)) {
          switch($this->request->post('action')){
              case 'create':
                  $s = $this->features->createValue();
                  break;
              case 'edit':
                  $id = $this->request->post('id', 'i');
                  if(!empty($id)){
                      $s = $this->features->update($id);
                  }
                  break;
              default:
                  throw new \Exception("Wrong action");
          }
        }

        if($this->features->hasDBError()){
            $m = $this->features->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function selectContent($features_id)
    {
        if($this->request->post('action') == 'process'){
           $s = $this->features->selectContent($features_id); $sc = null;
           if(! $s){
                echo $this->features->getDBErrorMessage();
           } else {
               $sc = $this->features->getSelectedContent($features_id);
           }

           $this->response->body(['s' => $s, 'sc' => $sc])->asJSON();
        }

        $this->template->assign('types', $this->features->getContentTypes(0));
        $this->template->assign('action', 'process');
        $this->template->assign('features_id', $features_id);
        $this->response->body($this->template->fetch('features/sel_content_types'))->asHtml();
    }

    public function getTypes($parent_id)
    {
        $this->response->body(['o' => $this->features->getContentTypes($parent_id)])->asJSON();
    }

    public function getContent($types_id, $subtypes_id = 0)
    {
        if($subtypes_id == 0) $subtypes_id = $types_id;

        $this->response->body(['o' => $this->features->getContent($types_id, $subtypes_id)])->asJSON();
    }

    public function deleteSelectedContent($id)
    {
        $s = $this->features->deleteSelectedContent($id);
        if(! $s){
            echo $this->features->getDBErrorMessage();
        }

        $this->response->body(['s' => $s])->asJSON();
    }
}