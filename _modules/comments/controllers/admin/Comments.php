<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\comments\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\Engine;

class Comments extends Engine
{
    private $comments;
    private $allowed_types = [2];

    public function __construct()
    {
        parent::__construct();
        $this->comments = new \modules\comments\models\admin\Comments();
    }

    public function init()
    {

        $this->assignToNav('Коментарі', 'module/run/comments', 'fa-comment', null, 100);
        $this->template->assignScript("modules/comments/js/admin/comments.js");
//        EventsHandler::getInstance()->debug();
        EventsHandler::getInstance()->add('content.meta.after', [$this, 'postComments']);
        EventsHandler::getInstance()->add('dashboard', [$this, 'dashboard']);
//        Event::getInstance()->add('content.process', [$this, 'contentProcess']);
    }

    public function dashboard()
    {
        $this->template->assign('items', $this->comments->getLatest());
        return $this->template->fetch('comments/dashboard');
    }

    public function postComments($post)
    {
        if(!in_array($post['types_id'], $this->allowed_types)) return '';

        $this->template->assign('comments_total', $this->comments->getTotal($post['id']));
        $this->template->assign('comments', $this->comments->get($post['id']));
        return $this->template->fetch('comments/post');
    }

    public function index()
    {
        $this->output($this->template->fetch('comments/index'));
    }

    public function tab($status)
    {
        $t = new DataTables2('comments_' . $status);

        $t
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('comments.pib'), 'u.surname', 1, 1, 'width: 200px')
            -> th($this->t('comments.message'), 'c.message')
            -> th($this->t('comments.created'), 'c.created', 1, 1, 'width: 160px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 200px')
            ->get('u.id as user_id')
            ->get('u.name')
            ->get('u.email')
            ->get('ci.name as page_name')
            ->get('ci.url')
            ->get('c.skey')
            ->get('c.status')
            -> ajax('module/run/comments/items/'  .$status)
            -> orderDef(1, 'desc')
        ;

        $this->output($t->init());
    }

    public function items($status)
    {
        $t = new DataTables2();
        $t  -> from('__comments c')
            -> join("__users u on u.id = c.users_id")
            -> join("__content_info ci on ci.content_id=c.content_id and ci.languages_id={$this->languages_id}");


        if($status != 'all'){
            $t-> where(" c.status='{$status}'");
        }

        $t-> execute();
        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $row['url'] = APPURL . $row['url'] . "#comment-{$row['id']}";
            $status = $this->t('comments.status_' . $row['status']);

            $res[$i][] = $row['id'];
            $res[$i][] = $row['surname'] .' '. $row['name'] . "<br><small>{$row['email']}</small>";
            $res[$i][] = "<small>{$row['message']}</small>
                           <br><strong style='color:green' class='label label-{$row['status']}'>{$status}</strong> Для <a target='_blank' href='{$row['url']}'>{$row['page_name']}</a>
                        ";
            $res[$i][] = DateTime::ago(strtotime($row['created']));

            $b = [];
            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_REPLY),
                ['class' => 'b-comments-reply', 'data-id' => $row['id'], 'title' => $this->t('common.title_reply')]
            );
            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_EDIT),
                ['class' => 'b-comments-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
            );

            if($row['status'] == 'new'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_PUBLISHED),
                    ['class' => 'b-comments-approve', 'data-id' => $row['skey'], 'title' => $this->t('comments.title_approve')]
                );

                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_BAN),
                    ['class' => 'b-comments-spam', 'data-id' => $row['id'], 'title' => $this->t('comments.title_spam')]
                );

            } elseif($row['status'] == 'spam'){

                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-comments-restore', 'data-id' => $row['id'], 'title' => $this->t('comments.title_restore')]
                );
            }

            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_DELETE),
                ['class' => 'b-comments-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
            );

            $res[$i][] = implode('', $b);
        }

        header('Content-Type: application/json');
        echo $t->render($res, $t->getTotal());die;
    }

    public function process($id){}

    public function approve($id)
    {
        return $this->comments->approve($id);
    }

    public function delete($id)
    {
        return $this->comments->delete($id);
    }

    public function spam($id)
    {
        return $this->comments->spam($id);
    }
    public function restore($id)
    {
        return $this->comments->restore($id);
    }
    public function create()
    {
    }

    public function edit($id)
    {
        if($this->request->post('action') == 'process'){
            $data = $this->request->post('data');
            $s=0; $i=[];

            FormValidation::setRule(['message'], FormValidation::REQUIRED);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {

                FormValidation::setRule(['message','content_id', 'users_id', 'status'], FormValidation::REQUIRED);
                if(FormValidation::hasErrors()){
                    $i = FormValidation::getErrors();
                } else {
                    $s += $this->comments->update($id, $data);
                }
            }

            if(!$s && $this->comments->hasError()){
                echo $this->comments->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
            return;
        }

        $this->template->assign('data', $this->comments->getData($id));
        $this->response->body($this->template->fetch('comments/reply'))->asHtml();
    }


    public function reply($id)
    {
        if($this->request->post('action') == 'process'){
            $data = $this->request->post('data');
            $s=0; $i=[];

            FormValidation::setRule(['message'], FormValidation::REQUIRED);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {

                FormValidation::setRule(['message','content_id', 'users_id', 'status'], FormValidation::REQUIRED);
                if(FormValidation::hasErrors()){
                    $i = FormValidation::getErrors();
                } else {
                    $s += $this->comments->create($data);
                }
            }

            if(!$s && $this->comments->hasError()){
                echo $this->comments->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
            return;
        }

        $this->template->assign('data', $this->comments->getData($id));
        $this->response->body($this->template->fetch('comments/reply'))->asHtml();
    }
}