<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.07.16
 * Time: 20:12
 */

namespace modules\feedback\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use system\core\DataTables2;
use system\Engine;

class Feedback extends Engine
{
    private $mFeedback;

    public function __construct()
    {
        parent::__construct();

        $this->mFeedback = new \modules\feedback\models\Feedback();
    }

    public function init()
    {
//        echo 'Init ' . __CLASS__ . '<br>';
        // додаю в меню
        $this->assignToNav('Feedback', 'module/run/feedback', 'fa-envelope', null, 100);

        $this->template->assignScript("modules/feedback/js/admin/feedback.js");
    }

    public function index()
    {
        $this->output($this->template->fetch('modules/feedback/index'));
    }

    public function tab($status)
    {
        $t = new DataTables2('feedback_' . $status);

        $t  -> ajax('module/run/feedback/tab/'  .$status)
            -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'id', 1,1, 'width:60px')
            -> th($this->t('feedback.name'), 'name', 1, 1, 'width: 200px')
            -> th($this->t('feedback.phone'), 'phone', 1, 1)
            -> th($this->t('feedback.email'), 'email', 1, 1)
            -> th($this->t('feedback.message'), 'message', 1, 1)
            -> th($this->t('feedback.created'), 'created', 0, 0, 'width: 100px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;

        $t->get('status', 0, 0, 0);
        $t->get('manager_id', 0, 0, 0);
        $t->get('updated', 0, 0, 0);
        $t->get('ip', 0, 0, 0);

        if($this->request->isPost()){

            $t-> from('__feedbacks');

            if($status != 'all'){
                $t-> where(" status='{$status}'");
            }

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $manager = '';
                $status_t = $this->t('feedback.status_' . $row['status']);
                if($row['manager_id']){
                    $manager = '<br>'. $this->t('feedback.manager') .' '. $this->mFeedback->getManagerData($row['manager_id']);
                }

                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['phone'];
                $res[$i][] = $row['email'];
                $res[$i][] = "<small>{$row['message']}</small>
                           <br><small>Ip:{$row['ip']}</small>
                           <br><span class='label label-{$row['status']}'>{$status_t}</span>
                        " . ($row['status'] != 'new' ? " {$row['updated']} {$manager}" : '');
                $res[$i][] = DateTime::ago(strtotime($row['created']));

                $b = [];
                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-feedback-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                );
                if($row['status'] == 'new'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-feedback-spam', 'data-id' => $row['id'], 'title' => $this->t('feedback.title_spam')]
                    );

                } elseif($row['status'] == 'spam'){

                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_RESTORE),
                        ['class' => 'b-feedback-restore', 'data-id' => $row['id'], 'title' => $this->t('feedback.title_restore')]
                    );
                }

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-feedback-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                );

                $res[$i][] = implode('', $b);
            }

            echo $t->render($res, $t->getTotal());die;
        }

        $this->output($t->init());
    }

    public function create()
    {
    }

    public function edit($id)
    {
        $this->template->assign('statuses', $this->mFeedback->getStatuses());
        $this->template->assign('data', $this->mFeedback->getData($id));
        $this->response->body($this->template->fetch('modules/feedback/form'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        $s += $this->mFeedback->update($id, $data);

        if(!$s && $this->mFeedback->hasError()){
            echo $this->mFeedback->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->mFeedback->delete($id);
    }

    public function spam($id)
    {
        return $this->mFeedback->spam($id, $this->admin['id']);
    }
    public function restore($id)
    {
        return $this->mFeedback->restore($id, $this->admin['id']);
    }
}