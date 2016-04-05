<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.03.16 : 15:07
 */

namespace controllers\modules;

use controllers\App;
use controllers\core\Session;
use helpers\FormValidation;
use models\components\Mailer;

defined("CPATH") or die();

class Comments extends App
{
    private $comments;

    public function __construct($content_id=0)
    {
        parent::__construct();
        $this->comments = new \models\modules\Comments();
    }

    /**
     * @return string
     */
    public function create()
    {
        if(! $this->request->isPost()) die;

        $user = Session::get('user');
        if(!$user) $this->response->sendError(403);

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

                $mailer = new Mailer('comment', $data);

                if(!$mailer->send()) {
                    $m .= '<br>ERROR: '.$mailer->getErrorInfo();
                }
            }
        }

        if(!$s && $this->comments->hasDBError()){
            $m = $this->comments->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    /**
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

    public function unSubMMail(){}

}