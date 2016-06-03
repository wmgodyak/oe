<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;

defined('CPATH') or die();

/**
 * Class Callbacks
 * @name Зворотні дзвінки
 * @icon fa-phone-square
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @position 5
 * @package controllers\engine
 */
class Callbacks extends Engine {

    private $mCallbacks;

    public function __construct()
    {
        parent::__construct();

        $this->mCallbacks = new \models\engine\Callbacks();
    }

    public function index()
    {
       $this->output($this->template->fetch('callbacks/index'));
    }

    public function tab($status)
    {
        $t = new DataTables2('callbacks_' . $status);

        $t  -> ajax('callbacks/items/'  .$status)
            -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'id', 1,1, 'width:60px')
            -> th($this->t('callbacks.pib'), 'name', 1, 1, 'width: 200px')
            -> th($this->t('callbacks.message'), 'message', 0, 0)
            -> th($this->t('callbacks.created'), 'created', 0, 0, 'width: 100px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;

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

        $t->get('status');
        $t->get('phone');
        $t->get('comment');
        $t->get('manager_id');
        $t->get('updated');
        $t->get('ip');

        if($status != 'all'){
            $t-> where(" status='{$status}'");
        }

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

        return $t->render($res, $t->getTotal());
    }

    public function create()
    {
//        $this->template->assign('action', 'create');
//        $this->response->body($this->template->fetch('callbacks/form'))->asHtml();
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

        if(!$s && $this->mCallbacks->hasDBError()){
            echo $this->mCallbacks->getDBErrorMessage();
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
