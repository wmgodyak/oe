<?php
namespace modules\comments\controllers;

use helpers\FormValidation;
use system\core\Session;
use system\Front;
use system\models\Mailer;

/**
 * Class Comments
 * @name Коментарі
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\comments\controllers
 */
class Comments extends Front
{
    private $comments;

    public function __construct()
    {
        parent::__construct();

        $this->comments = new \modules\comments\models\Comments();
    }

    public function init()
    {
        $this->template->assignScript("modules/comments/js/comments.js");
    }

    /**
     * @param $content_id
     * @param string $tpl
     * @return string
     */
    public function form($content_id, $tpl = 'modules/comments/items.tpl')
    {
        return $this->template->fetch($tpl);
    }

    /**
     * @param $content_id
     * @param string $tpl
     * @return string
     */
    public function display($content_id, $tpl = 'modules/comments/items.tpl')
    {
        $this->template->assign
        (
            'comments',
            [
                'total' => $this->comments->getTotal($content_id),
                'items' => $this->comments->get($content_id)
            ]
        );
        return $this->template->fetch($tpl);
    }

    public function get($content_id)
    {
        return $this->comments->get($content_id);
    }

    public function getTotal($content_id)
    {
        return $this->comments->getTotal($content_id);
    }

    public function getAverageRating($content_id)
    {
        return $this->comments->getAverageRating($content_id);
    }

    /**
     * @return string
     */
    public function create()
    {
        if(! $this->request->isPost()) die;

        $user = Session::get('user');
        if(!$user){
            $this->response->sendError(403);
            die;
        }

        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data');

        $data['message'] = htmlspecialchars(strip_tags($data['message']));

        FormValidation::setRule(['message', 'content_id'], FormValidation::REQUIRED);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            $data['users_id'] = $user['id'];
            $data['skey'] = md5( base64_encode(serialize($data)) );

            $s = $this->comments->create($data);

            if($s){

                $m = $this->t('comments.success');

                $data['post_name'] = $this->request->post('post_name', 's');

                $data['approve_url'] = APPURL . "route/comments/approve/{$data['skey']}";
                $data['delete_url'] = APPURL . "route/comments/approve/{$data['skey']}";

                $data['id'] = $s;
                $data['user'] = $user;

                $mailer = new Mailer('modules/comments/mail/comment', 'New comment', $data);

                if(!$mailer->send()) {
                    $m .= '<br>ERROR: '.$mailer->getErrorInfo();
                }
            }
        }

        if(!$s && $this->comments->hasError()){
            $m = $this->comments->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function like($skey)
    {
        $user = Session::get('user');
        if(!$user) {
            $this->response->sendError(403); return;
        }

        $s = false; $t = 0; $m = '';
        if($this->comments->like($skey, $user['id'])){
            $s = 1;
            $t = $this->comments->getLikes($skey);
        }

        $this->response->body(['s'=>$s, 't' => $t, 'm' => $m])->asJSON();
    }

    public function dislike($skey)
    {
        $user = Session::get('user');
        if(!$user) {
            $this->response->sendError(403); return;
        }

        $s = false; $t = 0; $m = '';
        if($this->comments->dislike($skey, $user['id'])){
            $s = 1;
            $t = $this->comments->getDisLikes($skey);
        }

        $this->response->body(['s'=>$s, 't' => $t, 'm' => $m])->asJSON();
    }

    /**
     * // todo ???
     * @param $id
     * @param $skey
     */
    public function approve($skey)
    {
        if($this->comments->approve($skey)){
            $comment = $this->comments->comment;
            if(empty($comment['content_id'])) return;

            $url = $this->getUrl($comment['content_id']);
            $this->redirect($url);
        }
    }
    /**
     * @param $id
     * @param $skey
     */
    public function del($skey)
    {
        if($this->comments->del($skey)){
            $content_id = $this->comments->comment['content_id'];
            $url = $this->getUrl($content_id);
            $this->redirect($url);
        }
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function subscribe($content_id)
    {
        $users_id = Session::get('user.id');
        if(empty($users_id) || empty($content_id)) return 0;
        return $this->comments->subscribe($users_id, $content_id);
    }
    /**
     * @param $content_id
     * @return mixed
     */
    public function unSubscribe($content_id)
    {
        $users_id = Session::get('user.id');
        if(empty($users_id) || empty($content_id)) return 0;
        return $this->comments->unSubscribe($users_id, $content_id);
    }

}