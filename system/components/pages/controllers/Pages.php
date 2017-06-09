<?php

namespace system\components\pages\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\components\content\controllers\Content;
use system\core\DataTables2;

if ( !defined("CPATH") ) die();

/**
 * Class Pages
 * @package system\components\pages\controllers
 */
class Pages extends Content
{
    public function __construct()
    {
        parent::__construct('pages');

        $this->template->assignScript("system/components/pages/js/pages.js");
    }

    public function init()
    {
        $this->assignToNav(t('pages.action_index'), 'pages', 'fa-file-text', null, 10);
    }

    public function index($parent_id=0)
    {

        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'pages/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> './pages/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t
            -> ajax('pages/items/' . $parent_id)
            -> th(t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th(t('common.name'), 'ci.name', 1, 1)
            -> th(t('common.created'), 'c.created', 1,1, 'width: 200px')
            -> th(t('common.updated'), 'c.updated', 1, 1, 'width: 200px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',0,0,0);
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
            -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages->id}")
            -> where(" c.parent_id = {$parent_id} and c.status in ('published', 'hidden')")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $icon_link = Icon::create('fa-external-link');
            $status = t('pages.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                " <a class='status-{$row['status']}' title='{$status}' href='{$this->type}/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
                . "<a style='margin-left:10px' href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
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
                            'class' => 'b-pages-hide',
                            'title' => t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Link::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => ' b-pages-pub',
                            'title' => t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "pages/edit/" . $row['id'], 'title' => t('common.title_edit')]
                ) .
                ($row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'btn-danger b-pages-delete', 'data-id' => $row['id'], 'title' => t('pages.delete_question')]
                ) : "")

            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create($parent_id = 0)
    {
        $id = parent::create($parent_id);
        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.back'),
                ['class' => 'btn-md', 'href'=> './'. $this->type . ($parent_id > 0 ? '/index/' . $parent_id : '')],
                (string)Icon::create('fa-reply')
            )
        );

        $this->tree();

       return parent::edit($id);
    }

    public function process($id)
    {
        $a = parent::process($id);

        if($a['s']){
            $content = $this->request->post('content');
            $a['m'] = sprintf(t('pages.update_success'), "pages/index/{$content['parent_id']}", "pages/create/{$content['parent_id']}");
        }

        return $a;
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

                $item['a_attr'] = ['id'=> $item['id'], 'href' => 'pages/edit/' . $item['id']];

                $item['li_attr'] =
                    [
                        'id'=> 'li_'.$item['id'],
                        'class' => 'status-' . $item['status'],
                        'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')
                    ];

                $item['type'] = $item['isfolder'] ? 'folder': 'file';

                $items[] = $item;
            }

            return $items;
        }

        $this->template->assign('tree_icon', 'fa-file-text');
        $sidebar = $this->template->fetch('system/pages/tree');
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