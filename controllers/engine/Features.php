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

    public function index()
    {
        $this->appendToPanel
        (
            (string)Link::create
                (
                    $this->t('common.button_create'),
                    ['class' => 'btn-md', 'href'=> 'features/create']
                )
        );

        $t = new DataTables();

        $t  -> setId('features')
            -> ajaxConfig('features/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('features.name'))
            -> th($this->t('features.code'))
            -> th($this->t('features.categories'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('features f')
            -> join("features_info i on i.features_id=f.id and i.languages_id={$this->languages_id}")
            -> get('f.id, i.name, f.code, f.status')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='features/edit/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $row['code'];
            $res[$i][] = $row['code'];
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
                    ['class' => 'btn-primary', 'href' => "features/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
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
}