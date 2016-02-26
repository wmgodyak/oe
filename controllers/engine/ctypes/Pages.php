<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.02.16 : 16:00
 */

namespace controllers\engine\ctypes;

use controllers\Engine;
use controllers\engine\CTypes;
use controllers\engine\DataTables;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;

defined("CPATH") or die();

/**
 * Class Pages
 * @name Сторінки
 * @icon fa-pages
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine\content_types
 */
class Pages extends CTypes
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $data = $this->mContent->getData($parent_id);
            $this->appendToPanel((string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md b-ct-pages-create', 'href'=> 'cTypes/run/pages/index' . ($data['parent_id']>0 ? '/' . $data['parent_id'] : '')]
            )
            );
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md b-ct-pages-create', 'href'=> 'cTypes/run/pages/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables();

        $t  -> setId('cTypes/run/pages')
            -> ajaxConfig('cTypes/run/pages/items/' . $parent_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('cTypes/run/pages.name'))
            -> th($this->t('cTypes/run/pages.type'))
            -> th($this->t('cTypes/run/pages.template'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items($parent_id = 0)
    {
        $t = new DataTables();
        $t  -> table('content_types')
            -> get('id, name, type, isfolder, is_main')
            -> where(" parent_id = {$parent_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='cTypes/run/pages/index/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $row['type'];
            $res[$i][] = $this->getPath($row['id'], false);
            $res[$i][] =
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "cTypes/run/pages/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['is_main'] == 0 && $row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-ct-pages-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                ) : "")

            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }
    public function create()
    {
        echo 'Pages::create()';
    }
    public function edit($id)
    {
        echo 'Pages::edit('.$id.')';
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
}