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

defined("CPATH") or die();
/**
 * Class Trash
 * @name Кошик
 * @icon fa-trash
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Trash extends Engine
{
    private $trash;

    public function __construct()
    {
        parent::__construct();

        $this->trash = new \models\engine\Trash();
    }

    public function index()
    {
        $t = new DataTables2('content');

        $t  -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'c.id', 1,1, 'width:60px')
            -> th($this->t('common.name'), 'ci.name', 1,1)
            -> th($this->t('common.created'), 'c.created', 1,1)
            -> th($this->t('common.updated'), 'c.updated', 1,1)
            -> th($this->t('common.tbl_func'), null, null, null, 'width: 160px')
            -> ajax('trash/items')
        ;

        $this->output($t->init());
    }

    public function items()
    {
        $t = new DataTables2();
        $t  -> from('__content c')
            -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
            -> join('__users u on u.id=c.owner_id')
            -> where(" c.status = 'deleted' ")
            -> get('ci.url')
            -> get('c.status')
            -> get('c.isfolder')
            -> get('CONCAT(u.name, \' \' , u.surname) as owner')
            -> execute();

//            -> get('ci.url, c.status, c.isfolder, CONCAT(u.name, \' \' , u.surname) as owner')
        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $status = $this->t('trash.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                " <a class='status-{$row['status']}' title='{$status}' href='content/trash/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
                . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
            ;
            $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));
            $res[$i][] = $row['updated'] ? date('d.m.Y H:i:s', strtotime($row['updated'])) : '';
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-trash-restore btn-primary', 'data-id' => $row['id'], 'title' => $this->t('trash.restore_question')]
                )
                .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-trash-remove btn-danger', 'data-id' => $row['id'], 'title' => $this->t('trash.remove_question')]
                )
            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function remove($id)
    {
        $this->trash->remove($id);
    }

    public function restore($id)
    {
        $this->trash->restore($id);
    }

    public function create()
    {

    }
    public function edit($id)
    {

    }
    public function delete($id)
    {

    }
    public function process($id)
    {

    }

}