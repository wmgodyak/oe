<?php

namespace modules\catalog\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentRelationship;
use system\components\content\controllers\Content;

/**
 * Class Manufacturers
 * @package modules\catalog\models
 */
class Manufacturers extends Content
{
    private $manufacturers;
    private $config;

    public function __construct()
    {
        $this->config = module_config('catalog');

        parent::__construct($this->config->type->manufacturer);

        $this->form_action = "module/run/catalog/manufacturers/process/";

        $this->manufacturers = new \modules\catalog\models\backend\Manufacturers($this->config->type->manufacturer);

        // disable default features block
        $this->form_display_blocks['features'] = false;
        $this->form_display_params['position'] = true;
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/catalog/manufacturers/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/catalog/manufacturers/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('module/run/catalog/manufacturers/index/' . $parent_id)
            -> th(t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th(t('common.name'), 'ci.name', 1, 1)
            -> th(t('common.created'), 'c.created', 0,1, 'width: 200px')
            -> th(t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);
        $t->get('c.isfolder',null,null,null);


        if($this->request->isXhr()){
            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages->id}")
                -> where(" c.parent_id='$parent_id' and c.status in ('published', 'hidden')");

            $t-> execute();

            $res = array();

            foreach ($t->getResults(false) as $i=>$row) {

                $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
                $icon_link = Icon::create('fa-external-link');
                $status = t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/catalog/manufacturers/edit/{$row['id']}'>{$icon}  {$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                ;
                $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));
                $res[$i][] = $row['updated'] ? date('d.m.Y H:i:s', strtotime($row['updated'])) : '';
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Link::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-hide',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-pub',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/catalog/manufacturers/edit/" . $row['id'], 'title' => t('common.title_edit')]
                    ) .
                    ($row['isfolder'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => t($this->type.'.delete_question')]
                    ) : "")

                ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->output($t->init());
    }


    /**
     * @param int $parent_id
     * @return string
     */
    public function create($parent_id = 0)
    {
        /**
         * modal create from tree context menu
         */
        if($this->request->isXhr()){
            $this->template->assign('content', ['parent_id' => $parent_id]);
            $this->template->assign('action', 'create');

            return $this->template->fetch('modules/catalog/manufacturers/form');
        }

        $id = parent::create($parent_id);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/catalog/manufacturers' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        parent::edit($id);
    }

    public function delete($id)
    {
        $s = $this->manufacturers->delete($id);

        return ['s' => $s, 'm' => $this->manufacturers->getErrorMessage()];
    }


    public function process($id=0)
    {
        if($this->request->post('modal')){

            $i=[]; $m = t('common.update_success'); $s = 0;
            switch($this->request->post('action')){
                case 'create':
                    $id = $this->manufacturers->create($id, $this->admin['id']);
                    if($id){
                        $s = $this->manufacturers->update($id);
                    }
                    break;
                case 'edit':
                    $s = $this->manufacturers->update($id);
                    break;
            }

            if(! $s){
                $i = $this->manufacturers->getError();
                $m = $this->manufacturers->getErrorMessage();
            }

            return ['s'=>$s, 'i' => $i, 'm' => $m];
        }

        return parent::process($id);
    }
}