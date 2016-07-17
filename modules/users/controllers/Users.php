<?php

namespace modules\users\controllers;

use helpers\FormValidation;
use system\core\Session;
use system\Front;
use system\models\Mailer;

/**
 * Class users
 * @name Користувачі
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\users\controllers
 */
class Users extends Front
{
    /**
     * Profile page ID
     * @var int
     */
    private $profile_id = 1; 
    private $users;

    public function __construct()
    {
        parent::__construct();

        $this->users = new \modules\users\models\Users();
    }

    public function init()
    {
        parent::init();

        $this->template->assignScript("modules/users/js/users.js");
//        echo "Init " . __CLASS__ . "\r\n";
        // todo manual authorize user
//        $user = $this->users->getUserByEmail('m@otakoyi.com');
//        Session::set('user', $user);
        $this->template->assign('user', Session::get('user'));
    }

    public function nav($tpl = 'modules/users/nav')
    {
        return $this->template->fetch($tpl);
    }

    public function login()
    {
        if($this->request->isPost()){
            $status = 0; $i = []; $data = $this->request->post('data');

            FormValidation::setRule(['password', 'email'], FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {
                $user = $this->users->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[password]' => $this->t('admin.e_login_pass')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_deleted')];
                } else if ($this->users->checkPassword($data['password'], $user['password'])){
                    if($user['backend'] == 1){
                        $i[] = ['data[password]' => "Адміністратори не можуть логінитись на сайті"];
                    } else {
                        $status = $this->users->setOnline($user);
                        if($status){
                            Session::set('user', $user);
                        } else {
                            $i[] = ['data[password]' => $this->users->getError()];
                        }
                    }


                } else {
                    $i[] = ['data[password]' => $this->t('admin.e_login_pass')];
                }
            }

            $this->response->body(array(
                's' => $status > 0,
                'i' => $i
            ))->asJSON();
            return;
        }

        $this->response->body($this->template->fetch('modules/users/login'));
    }

    public function logout()
    {
        Session::delete('user');
        $url = $this->getUrl(1);
        $this->redirect( APPURL . $url);
    }

    public function fp()
    {
        if($this->request->isPost()){
            $s = 0; $i = []; $data = $this->request->post('data'); $m=null;

            FormValidation::setRule('email', FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {
                $user = $this->users->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[email]' => $this->t('admin.e_bad_email')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_deleted')];
                } else {
                    $skey = base64_encode(serialize($user)); $skey = substr($skey, 0, 64);
                    $s = $this->users->update($user['id'], ['skey' => $skey]);
                    if($s){
                        $user['skey'] = $skey;
                        $user['fp_link'] = APPURL . "route/users/newPsw/{$skey}";

                        $mailer = new Mailer('user_fp', $user);
                        $mailer
                            ->addAddress($user['email'], $user['name'])
                            ->send();
                        $m = $this->t('users.fp_send_email');
                    }
                }
            }

            $this->response->body(array(
                's' => $s,
                'i' => $i,
                'm' => $m
            ))->asJSON();
            return;
        }

        $this->response->body($this->template->fetch('modules/users/fp'));
    }

    public function newPsw($skey=null)
    {

        if(!empty($skey)){
            $user = $this->users->getUserBySkey($skey);
            if(! $user){
                die('wrong key');
            }
            $this->template->assign('user', $user);
        }

        if($this->request->isPost()){
            $data = $this->request->post('data'); $i=[]; $s = 0;

            FormValidation::setRule(['password', 'password_c'], FormValidation::REQUIRED);
            FormValidation::setRule(['password'], FormValidation::PASSWORD);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
            }  else {

                unset($data['password_c']);
                $data['skey'] = null;
                $s = $this->users->update($user['id'], $data);

                $this->redirect('/');
            }

            if(!$s && $this->users->hasError()){
                $i[] = ["data[password_c]" => $this->users->getErrorMessage()];
            }

            $this->template->assign('status', $s);
            $this->template->assign('errors', $i);;
        }

//        $this->template->assign('page', ['title' => $this->t('users.new_psw_title')]);
        $this->response->body($this->template->fetch('modules/users/new_psw'));
    }

    public function register()
    {
        if($this->request->isPost()){

            $data = $this->request->post('data'); $s=0; $i=[];

            $s = $this->users->register($data);

            if(!$s && $this->users->hasError()){
                $i = $this->users->getError();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();

            return;
        }

        $this->response->body($this->template->fetch('modules/users/register'));
    }

    public function profile()
    {
        $user = Session::get('user');
        
        if(!$user){
            $url = $this->getUrl(29); //profile

            $this->redirect( APPURL . $url);
        }

        if($this->request->isPost()){

            $data = $this->request->post('data'); $s=0; $i=[];

            FormValidation::setRule(['name', 'surname', 'email', 'phone'], FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            }  elseif($this->users->issetEmail($data['email'], $user['id'])){
                $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
            } else {
                unset($data['password_c']);

                if(empty($data['password'])) $data['password'] = $this->users->generatePassword();

//                $data['group_id'] = $this->guest_group_id;
                $s = $this->users->update($user['id'], $data);
                if($s){
                    $data = array_merge($user, $data);
                    Session::set('user', $data);
                }
            }

            if(!$s && $this->users->hasError()){
                echo $this->users->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON(); return null;

        }
        
        return $this->template->fetch('modules/users/profile');
    }

    public function changePassword()
    {
        if($this->request->isPost()){

            $user = Session::get('user');
            if(!$user){
                $this->response->sendError(403);
            }

            if(! $this->request->isPost()) die();

            $data = $this->request->post('data'); $i=[]; $s = 0;

            FormValidation::setRule(['password', 'password_c'], FormValidation::REQUIRED);
            FormValidation::setRule(['password'], FormValidation::PASSWORD);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
            }  else {

                unset($data['password_c']);

                $s = $this->users->update($user['id'], $data);
            }

            if(!$s && $this->users->hasError()){
                echo $this->users->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON(); return null;
        }


        return $this->template->fetch('modules/users/password');
    }
}