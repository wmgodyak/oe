<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.06.16 : 15:51
 */

namespace system\components\features\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Backend;

defined("CPATH") or die();

/**
 * Class Values
 * @package system\components\features\controllers
 */
class Values extends Backend
{
    private $features;

    public function __construct()
    {
        parent::__construct();

        $this->features = new \system\components\features\models\Features();
    }

    public function index($features_id = 0)
    {
        $this->addBreadCrumb($this->features->getName($features_id));

        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary b-features-values-create', 'data-features_id'=> $features_id]
            )
        );

        $t = new DataTables2('features_values');

        $t  -> ajax('features/values/index/' . $features_id)
            -> th(t('common.id'), 'f.id', 1, 1, 'width: 60px')
            -> th(t('features.name'), 'i.name', 1, 1)
            -> th(t('features.code'), 'f.code', 1, 1, 'width: 300px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 200px')
            -> get('f.status', 0, 0, 0)
            -> get('f.type', 0, 0, 0)
        ;

        if($this->request->isXhr()){

            $t  -> from('__features f')
                -> join("__features_info i on i.features_id=f.id and i.languages_id={$this->languages_id}")
                -> where("f.parent_id = {$features_id}")
                -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = "<input class='form-control' onfocus='select()' value='{$row['code']}'>";
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Button::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => ' b-features-values-hide',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Button::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => ' b-features-values-pub',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        [
                            'class' => 'btn-primary  b-features-values-edit',
                            'data-id' => $row['id'],
                            'title' => t('common.title_edit')
                        ]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-features-values-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());return;
        }

        $this->output($t->init());
    }

    public function reorder()
    {
        $this->features->reorder();
        return ['m' => "Сортування збережено"];
    }

    public function create($parent_id = 0){
        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);
        $this->template->assign('action', 'create');
        $this->template->display('system/features/value');
    }

    public function edit($id){
        $data = $this->features->getData($id);
        unset($data['parent_id']);
        $this->template->assign('data', $data);
        $this->template->assign('action', 'edit');
        $this->template->display('system/features/value');
    }

    public function process($id=null)
    {
        if(! $this->request->isPost()) die;

        $info = $this->request->post('info');

        $s=0; $i=[]; $m=null;

        foreach ($info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => t('features.empty_value')];
            }
        }

        if(empty($i)) {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->features->createValue($this->admin['id']);
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

        $m = t('common.update_success');

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

}