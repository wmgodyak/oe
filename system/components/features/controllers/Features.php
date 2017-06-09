<?php

namespace system\components\features\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\components\features\models\FeaturesContent;
use system\core\DataTables2;
use system\Backend;

defined("CPATH") or die();

class Features extends Backend
{
    private $features;
    private $featuresContent;

    public function __construct()
    {
        parent::__construct();

        $this->features = new \system\components\features\models\Features();
        $this->featuresContent = new FeaturesContent();
    }

    public function init()
    {
        $this->assignToNav(t('features.action_index'), 'features', 'fa-users', 'tools', 100);
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $this->addBreadCrumb($this->features->getName($parent_id));
        }

        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary b-features-create', 'data-parent'=> $parent_id]
            )
        );

        $t = new DataTables2('features');

        $t  -> ajax('features/index/'.$parent_id)
            -> th(t('common.id'), 'f.id', 1, 1, 'width: 60px')
            -> th(t('features.name'), 'i.name', 1, 1)
            -> th(t('features.code'), 'f.code', 1, 1, 'width: 300px')
            -> th(t('features.type'), 'f.type', 1, 1, 'width: 200px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 200px')
            -> get('f.status', 0, 0, 0)
        ;

        if($this->request->isXhr()){

            $t  -> from('__features f')
                -> join("__features_info i on i.features_id=f.id and i.languages_id={$this->languages->id}")
                -> where("f.parent_id = {$parent_id}")
                -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $url = $row['type'] == 'folder' ? 'features/index/' : 'features/values/index/';
                $res[$i][] = $row['id'];
                $res[$i][] = "<a href='{$url}{$row['id']}'>{$row['name']}</a>";
                $res[$i][] = "<input class='form-control' onfocus='select()' value='{$row['code']}'>";
                $res[$i][] = t('features.type_' . $row['type']);
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Button::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => ' b-features-hide',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Button::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => ' b-features-pub',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        [
                            'class' => 'btn-primary' . ($row['type'] == 'value' ? ' b-features-edit-value' : ' b-features-edit'),
                            'data-id' => $row['id'],
                            'title' => t('common.title_edit')
                        ]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-features-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());return;
        }

        $this->output($t->init());
    }

    public function create($parent_id = 0)
    {
        $id = $this->features->createBlank($parent_id, $this->admin['id']);
        return $this->edit($id);
    }

    /**
     * @param $id
     */
    public function edit($id)
    {
        $data = $this->features->getData($id);
        if(empty($data)) redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.back'),
                ['class' => 'btn-md', 'href'=> 'features' . ($data['parent_id'] > 0 ? '/index/' . $data['parent_id'] : '')]
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

        $this->template->assign('selected_content', $this->featuresContent->getSelectedContent($id));
        $this->template->assign('action', 'edit');
        $this->template->display('system/features/form');
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
                    $i[] = ["info[$languages_id][name]" => t('features.empty_name')];
                }
            }
            if(empty($i)) {
                $s = $this->features->update($id);
            }
        }

        if($this->features->hasError()){
            $m = $this->features->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'm' => $m];
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

    public function values()
    {
        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new Values();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function content()
    {
        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new Content();

        return call_user_func_array(array($controller, $action), $params);
    }
}