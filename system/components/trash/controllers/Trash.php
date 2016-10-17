<?php

namespace system\components\trash\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\Backend;

defined("CPATH") or die();

/**
 * Class Trash
 * @package system\components\blank\controllers
 */
class Trash extends Backend
{
    private $trash;

    public function __construct()
    {
        parent::__construct();

        $this->trash = new \system\components\trash\models\Trash();
    }

    public function init()
    {
        $this->assignToNav('Кошик', 'trash', 'fa-file-text', 'tools', 100);
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

            -> get('ci.url')
            -> get('c.status')
            -> get('c.isfolder')
            -> get('CONCAT(u.name, \' \' , u.surname) as owner')

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
            -> execute();

//            -> get('ci.url, c.status, c.isfolder, CONCAT(u.name, \' \' , u.surname) as owner')
        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
            $status = $this->t('trash.status_' . $row['status']);
            $res[$i][] = $row['id'];
            $res[$i][] =
                " <a class='status-{$row['status']}' title='{$status}' href='trash/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
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
        $s = $this->trash->remove($id);

        if($s){
            EventsHandler::getInstance()->call('trash.remove', ['id' => $id]);
        }
    }

    public function restore($id)
    {
        $this->trash->restore($id);
    }

    public function create(){}
    public function edit($id){}
    public function delete($id){}
    public function process($id){}
}