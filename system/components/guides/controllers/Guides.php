<?php

namespace system\components\guides\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\components\content\controllers\Content;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentTypes;

if ( !defined("CPATH") ) die();

/**
 * Class guides
 * @package system\components\guides\controllers
 */
class Guides extends Content
{
    public function __construct()
    {
        parent::__construct('guide');

    }

    public function init()
    {
        $this->assignToNav('Довідкники', 'guides', 'fa-book');
        $this->template->assignScript(dirname(__FILE__) . "/js/guides.js");
        EventsHandler::getInstance()->add('content.main', [$this, 'main']);
    }

    public function main($guide)
    {
        $ct = new ContentTypes();
        $a = $ct->getData($guide['types_id'], 'type');

        if($this->type != $a) return '';

        return $this->template->fetch('guides/main');
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'guides/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary b-guides-create', 'data-id'=> $parent_id]
            )
        );

        $t = new DataTables2('content');

        $t
            -> ajax('guides/items/' . $parent_id)
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 1,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 1, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('c.external_id',0,0,0);
        $t->get('c.status',0,0,0);
        $t->get('c.isfolder',0,0,0);

        $this->tree();
        $this->output($t->init());
    }

    public function items($parent_id = 0)
    {
        $t = new DataTables2();
        $t  -> from('__content c')
            -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
            -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
            -> where(" c.parent_id = {$parent_id} and c.status in ('published', 'hidden')")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='guides/index/{$row['id']}'>{$row['name']}</a>" . ($row['external_id'] ? " ({$row['external_id']})" : '');
            $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));
            $res[$i][] = $row['updated'] ? date('d.m.Y H:i:s', strtotime($row['updated'])) : '';
            $res[$i][] =
                (string)(
                $row['status'] == 'published' ?
                    Link::create
                    (
                        Icon::create(Icon::TYPE_PUBLISHED),
                        [
                            'class' => 'b-guides-hide',
                            'title' => $this->t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Link::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => ' b-guides-pub',
                            'title' => $this->t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary b-guides-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'btn-danger b-guides-delete', 'data-id' => $row['id'], 'title' => $this->t('guides.delete_question')]
                ) : "")

            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create($parent_id = 0)
    {
        $this->template->assign('content', ['parent_id' => $parent_id]);
        $this->template->assign('action', 'create');

        $this->response->body($this->template->fetch('guides/form'));
    }

    public function edit($id)
    {
        $this->template->assign('content', $this->mContent->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('guides/form'));
    }

    public function process($id = null)
    {
        $i=[]; $m = $this->t('common.update_success'); $s = 0;
        switch($this->request->post('action')){
            case 'create':
                $id = $this->mContent->create(0, $this->admin['id']);
                if($id){
                    $s = $this->mContent->update($id);
                }
                break;
            case 'edit':
                $s = $this->mContent->update($id);
                break;
        }

        if(! $s){
            $i = $this->mContent->getError();
            $m = $this->mContent->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function tree()
    {
        if($this->request->isXhr()){

            $items = array();

            $parent_id = $this->request->get('id','i');
            $parent_id = (int)$parent_id;

            foreach ($this->mContent->tree($parent_id) as $item) {

                $item['children'] = $item['isfolder'] == 1;

                if( $parent_id > 0 ){
                    $item['parent'] = $parent_id;
                }

                $item['text'] .= " #{$item['id']}";

                $item['a_attr'] = ['id'=> $item['id'], 'href' => 'guides/index/' . $item['id']];

                $item['li_attr'] =
                    [
                        'id'=> 'li_'.$item['id'],
                        'class' => 'status-' . $item['status'],
                        'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')
                    ];

                $item['type'] = $item['isfolder'] ? 'folder': 'file';

                $items[] = $item;
            }

            $this->response->asJSON();

            return $items;
        }

        $this->template->assign('tree_icon', 'fa-file-text');
        $sidebar = $this->template->fetch('guides/tree');
        $this->template->assign('sidebar', $sidebar);
    }

    public function moveTreeItem()
    {
        if(! $this->request->isPost()) die(403);

        $id            = $this->request->post('id', 'i');
        $old_parent    = $this->request->post('old_parent', 'i');
        $parent        = $this->request->post('parent', 'i');
        $position      = $this->request->post('position', 'i');

        if(empty($id)) return 0;

        $this->mContent->move($id, $old_parent, $parent, $position);

        if($this->mContent->hasError()){
            echo $this->mContent->getError();
            return 0;
        }

        return 1;
    }
}