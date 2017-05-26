<?php

namespace modules\users\controllers;

use helpers\FormValidation;
use system\core\EventsHandler;
use system\core\Lang;
use system\core\Route;
use system\core\Session;
use system\Frontend;
use system\models\Mailer;

/**
 * Class users
 * @name Користувачі
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\users\controllers
 */
class Users extends Frontend
{
    protected $users;
    protected $group_id;

    protected $config;

    public function __construct()
    {
        parent::__construct();

        $this->users = new \modules\users\models\Users();

        $this->config = module_config('users');

        $this->group_id = $this->config->guest_group_id;
    }

    public function init()
    {
        parent::init();

        events()->add('boot', function(){

            Route::getInstance()->get('/register', function(){

                //todo move it from here
                Lang::getInstance();

                return $this->register();
            });

            Route::getInstance()->get('/{lang}/register', function($lang){

                $s = $this->languages->setByCode($lang);
                if(! $s) $this->e404();

                //todo move it from here

//                Lang::getInstance()->set($this->template->theme, $lang);

                return $this->register();
            });

        });

        events()->add('init', function($page){

            $this->template->assignScript("modules/users/js/users.js");
            $this->template->assign('user', Session::get('user'));

        });
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
                    $i[] = ['data[password]' => t('users.e_login_pass')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[password]' => t('users.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[password]' => t('users.e_login_deleted')];
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
                    $i[] = ['data[password]' => t('users.e_login_pass')];
                }
            }

            return ['s' => $status > 0, 'i' => $i];
        }

        return $this->template->fetch('modules/users/login');
    }

    public function logout()
    {
        $user = Session::get('user');
        EventsHandler::getInstance()->call('user.logout', $user);
        $this->redirect( APPURL);
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
                    $i[] = ['data[email]' => t('users.e_bad_email')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[email]' => t('users.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[email]' => t('users.e_login_deleted')];
                } else {
                    $skey = base64_encode(serialize($user)); $skey = substr($skey, 0, 64);
                    $s = $this->users->update($user['id'], ['skey' => $skey]);
                    if($s){
                        $user['skey'] = $skey;
                        $user['fp_link'] = APPURL . "route/users/newPsw/{$skey}";

                        $mailer = new Mailer('modules/users/mail/fp', 'FP', $user);
                        $mailer
                            ->addAddress($user['email'], $user['name'])
                            ->send();
                        $m = t('users.fp.success');
                    }
                }
            }

            return ['s' => $s, 'i' => $i, 'm' => $m];
        }

        return $this->template->fetch('modules/users/fp');
    }

    public function newPsw($skey=null)
    {
        if(! $skey) return null;

        $user = $this->users->getUserBySkey($skey);

        if($this->request->isPost()){
            $data = $this->request->post('data'); $i=[]; $s = 0;

            FormValidation::setRule(['password', 'password_c'], FormValidation::REQUIRED);
//            FormValidation::setRule(['password'], FormValidation::PASSWORD);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => t('admin_profile.e_pasw_equal')];
            }  else {

                unset($data['password_c']);
                $data['skey'] = null;
                $s = $this->users->update($user['id'], $data);
            }

            if(!$s && $this->users->hasError()){
                $i[] = ["data[password_c]" => $this->users->getErrorMessage()];
            }

            $this->template->assign('status', $s);
            $this->template->assign('errors', $i);
        }

        if(! $user){
            die('wrong key');
        }

        $this->template->assign('user', $user);
        return $this->template->fetch('modules/users/new_psw');
    }

    public function register()
    {
        if($this->request->isPost()){

            $data = $this->request->post('data'); $s=0; $i=[];

            $data['group_id'] = $this->group_id;
            $s = $this->users->register($data);

            if(!$s && $this->users->hasError()){
                $i = $this->users->getError();
            }

            return ['s'=>$s, 'i' => $i];
        }

        return $this->template->fetch('modules/users/register');
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
                $i[] = ["data[email]" => t('admins.error_email_not_unique')];
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

            return ['s'=>$s, 'i' => $i];
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
//            FormValidation::setRule(['password'], FormValidation::PASSWORD);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(strlen($data['password']) < 6){
                $i[] = ["data[password_c]" => t('users.e_pasw_length')];
            } elseif($data['password_c'] != $data['password']){
                $i[] = ["data[password_c]" => t('users.e_pasw_equal')];
            }  else {

                unset($data['password_c']);

                $s = $this->users->update($user['id'], $data);
            }

            if(!$s && $this->users->hasError()){
                echo $this->users->getErrorMessage();
            }

            return ['s'=>$s, 'i' => $i];
        }


        return $this->template->fetch('modules/users/password');
    }
}