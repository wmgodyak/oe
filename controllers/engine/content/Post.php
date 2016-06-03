<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.02.16 : 16:00
 */

namespace controllers\engine\content;

use controllers\Engine;
use controllers\engine\Content;
use controllers\engine\DataTables;
use controllers\engine\DataTables2;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use models\engine\Comments;

defined("CPATH") or die();

/**
 * Class Post
 * @name Статті
 * @icon fa-pencil
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine\content_types
 */
class Post extends Content
{
    public function __construct()
    {
        $this->type = 'post';

        parent::__construct();
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $data = $this->mContent->getData($parent_id);
            $this->appendToPanel((string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> './content/'.$this->type.'/index' . ($data['parent_id']>0 ? '/' . $data['parent_id'] : '')],
                (string)Icon::create('fa-reply')
            )
            );
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> './content/'.$this->type.'/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('content/'.$this->type.'/items/' . $parent_id)
            ->orderDef(0, 'desc')
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 1,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 1, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',0,0,0);
        $t->get('c.status',0,0,0);
        $t->get('c.isfolder',0,0,0);
        $t->get('CONCAT(u.name, \' \' , u.surname) as owner',0,0,0);
        $this->output($t->init());
    }

    public function items($parent_id = 0)
    {
        $t = new DataTables2();
        $t  -> from('__content c')
            -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
            -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
            -> join('__users u on u.id=c.owner_id')
            -> where("c.status in ('published', 'hidden')");
         if($parent_id > 0){
            $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$parent_id}");
         }


        $t-> execute();

        $res = array();
        $comments = new Comments();

        foreach ($t->getResults(false) as $i=>$row) {
            $t_comments = $comments->getTotal($row['id']);
            $t_comments_new = $comments->getTotalNew($row['id']);

            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $icon_link = Icon::create('fa-external-link');
            $status = $this->t($this->type .'.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                           " <a class='status-{$row['status']}' title='{$status}' href='content/{$this->type}/edit/{$row['id']}'>{$icon}  {$row['name']}</a>"
                         . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                         . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
                         . "<br><small class='label label-info'>Коментарів: {$t_comments} </small>"
                         . ($t_comments_new > 0 ? ", <small class='label label-info'>{$t_comments_new} новий</small>" : "")
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
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "content/{$this->type}/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t($this->type.'.delete_question')]
                ) : "")

            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create()
    {
        $id = parent::create(0);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> './content/'. $this->type . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        parent::edit($id);
    }
}