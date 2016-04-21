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
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;

defined("CPATH") or die();

/**
 * Class ProductsCategories
 * @name Категорії
 * @icon fa-file-text
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @position = 4
 * @package controllers\engine\content_types
 */
class ProductsCategories extends Content
{
    public function __construct()
    {
        $this->type = 'productsCategories';
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
                ['class' => 'btn-md', 'href'=> './content/'.$this->type.'/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables();

        $t  -> setId('content')
            -> ajaxConfig('content/'.$this->type.'/items/' . $parent_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'), '', 'width: 60px')
            -> th($this->t('common.name'))
            -> th($this->t('common.created'), '', 'width: 200px')
            -> th($this->t('common.updated'), '', 'width: 200px')
            -> th($this->t('common.tbl_func'), '', 'width: 180px')
        ;

        $this->output($t->render());
    }

    public function items($parent_id = 0)
    {
        $t = new DataTables();
        $t  -> table('__content c')
            -> get('c.id, ci.name, ci.url, c.created, c.updated, c.status, c.isfolder')//, CONCAT(u.name, ' ' , u.surname) as owner
            -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
            -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
//            -> join('__users u on u.id=c.owner_id')
            -> where(" c.parent_id = {$parent_id} and c.status in ('published', 'hidden')")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $icon_link = Icon::create('fa-external-link');
            $status = $this->t($this->type.'.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                           " <a class='status-{$row['status']}' title='{$status}' href='content/{$this->type}/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
                         . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
//                         . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
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
                                'class' => 'b-'.$this->type.'-hide',
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'b-'.$this->type.'-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                ) .
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "content/$this->type/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'btn-danger b-'.$this->type.'-delete', 'data-id' => $row['id'], 'title' => $this->t($this->type.'.delete_question')]
                ) : "")

            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create($parent_id = 0)
    {
        $id = parent::create($parent_id);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel(
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> './content/'. $this->type . ($parent_id > 0 ? '/index/' . $parent_id : '')]
            )
        );

        parent::edit($id);
    }
}