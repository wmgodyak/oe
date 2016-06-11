<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 12.06.16
 * Time: 0:33
 */

namespace system\components\pages\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\components\content\controllers\Content;
use system\core\DataTables2;

if ( !defined("CPATH") ) die();

class Pages extends Content
{
    public function __construct()
    {
        parent::__construct('pages');
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $data = $this->mContent->getData($parent_id);
            $this->appendToPanel((string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> './pages/index' . ($data['parent_id']>0 ? '/' . $data['parent_id'] : '')],
                (string)Icon::create('fa-reply')
            )
            );
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> './pages/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t
            -> ajax('pages/items/' . $parent_id)
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 1,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 1, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',0,0,0);
        $t->get('c.status',0,0,0);
        $t->get('c.isfolder',0,0,0);

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
            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $icon_link = Icon::create('fa-external-link');
            $status = $this->t('pages.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                " <a class='status-{$row['status']}' title='{$status}' href='content/{$this->type}/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
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
                            'title' => $this->t('common.title_pub'),
                            'data-id' => $row['id']
                        ]
                    )
                    :
                    Link::create
                    (
                        Icon::create(Icon::TYPE_HIDDEN),
                        [
                            'class' => ' b-pages-pub',
                            'title' => $this->t('common.title_hide'),
                            'data-id' => $row['id']
                        ]
                    )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "pages/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'btn-danger b-pages-delete', 'data-id' => $row['id'], 'title' => $this->t('pages.delete_question')]
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
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> './content/'. $this->type . ($parent_id > 0 ? '/index/' . $parent_id : '')],
                (string)Icon::create('fa-reply')
            )
        );

        parent::edit($id);
    }

    public function process($id)
    {
        $a = parent::process($id, false);

        if($a['s']){
            $content = $this->request->post('content');
            $a['m'] = sprintf($this->t('pages.update_success'), "pages/index/{$content['parent_id']}", "pages/create/{$content['parent_id']}");
        }

        $this->response->body($a)->asJSON();
    }
}