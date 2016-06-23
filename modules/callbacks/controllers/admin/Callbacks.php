<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\callbacks\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use system\core\DataTables2;
use system\Engine;

class Callbacks extends Engine
{
    private $mCallbacks;

    public function __construct()
    {
        parent::__construct();

        $this->mCallbacks = new \modules\callbacks\models\Callbacks();
    }

    public function init()
    {
//        echo 'Init ' . __CLASS__ . '<br>';
        // додаю в меню
        $this->assignToNav('Callbacks', 'module/run/callbacks', 'fa-phone');

        $this->template->assignScript("modules/callbacks/js/admin/callbacks.js");
    }

    public function index()
    {
        $this->output($this->template->fetch('callbacks/index'));
    }

    public function tab($status)
    {
        $t = new DataTables2('callbacks_' . $status);

        $t  -> ajax('module/run/callbacks/items/'  .$status)
            -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'id', 1,1, 'width:60px')
            -> th($this->t('callbacks.pib'), 'name', 1, 1, 'width: 200px')
            -> th($this->t('callbacks.message'), 'message', 0, 0)
            -> th($this->t('callbacks.created'), 'created', 0, 0, 'width: 100px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;


        $t->get('status');
        $t->get('phone');
        $t->get('comment');
        $t->get('manager_id');
        $t->get('updated');
        $t->get('ip');

        $this->output($t->init());
    }

    /**
     * @param $status
     * @return string
     */
    public function items($status)
    {
        $t = new DataTables2();
        $t  -> from('__callbacks');

        if($status != 'all'){
            $t-> where(" status='{$status}'");
        }
//        $t->debug();

        $t-> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $manager = '';
            $status_t = $this->t('callbacks.status_' . $row['status']);
            if($row['manager_id']){
                $manager = '<br>'. $this->t('callbacks.manager') .' '. $this->mCallbacks->getManagerData($row['manager_id']);
            }
            $res[$i][] = $row['id'];
            $res[$i][] = $row['name'] . "<br><small>{$row['phone']}</small>";
            $res[$i][] = "<small>{$row['message']}</small>
                           <br><small>Ip:{$row['ip']}</small>
                           <br><span class='label label-{$row['status']}'>{$status_t}</span>
                        " . ($row['status'] != 'new' ? " {$row['updated']} {$manager}" : '');
            $res[$i][] = DateTime::ago(strtotime($row['created']));

            $b = [];
            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_EDIT),
                ['class' => 'b-callbacks-reply btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_reply')]
            );
            if($row['status'] == 'new'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_BAN),
                    ['class' => 'b-callbacks-spam', 'data-id' => $row['id'], 'title' => $this->t('callbacks.title_spam')]
                );

            } elseif($row['status'] == 'spam'){

                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-callbacks-restore', 'data-id' => $row['id'], 'title' => $this->t('callbacks.title_restore')]
                );
            }

            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_DELETE),
                ['class' => 'b-callbacks-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
            );

            $res[$i][] = implode('', $b);
        }

        $this->response->body($t->render($res, $t->getTotal()))->asJSON();
    }

    public function create()
    {
    }
    public function edit($id)
    {

    }

    public function reply($id)
    {
        $this->template->assign('data', $this->mCallbacks->getData($id));
        $this->response->body($this->template->fetch('callbacks/form'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        $s += $this->mCallbacks->update($id, $data);

        if(!$s && $this->mCallbacks->hasError()){
            echo $this->mCallbacks->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->mCallbacks->delete($id);
    }

    public function spam($id)
    {
        return $this->mCallbacks->spam($id, $this->admin['id']);
    }
    public function restore($id)
    {
        return $this->mCallbacks->restore($id, $this->admin['id']);
    }
}