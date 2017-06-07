<?php

namespace modules\users\controllers;

use helpers\FormValidation;
use system\core\EventsHandler;
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
    protected $config;

    private $allowed_fields = ['name', 'surname', 'email', 'password'];

    public function __construct()
    {
        parent::__construct();

        $this->users = new \modules\users\models\Users();

        $this->config = module_config('users');
    }

    public function init()
    {
        parent::init();

        events()->add('boot', function(){

            $this->template->assignScript("modules/users/js/users.js");
            $this->template->assign('user', Session::get('user'));

            $this->route->get('register', function(){
                if(Session::get('user.id')) {
                    redirect(route('profile'));
                }

                return $this->template->fetch('modules/users/register');
            });

            $this->route->get('{lang}/register', function(){
                if(Session::get('user.id')) {
                    redirect(route('profile'));
                }

                return $this->template->fetch('modules/users/register');
            });

            $this->route->post('register', [$this, 'register']);

            $this->route->get('{lang}/login', function(){
                if(Session::get('user.id')) {
                    redirect(route('profile'));
                }

                return $this->template->fetch('modules/users/login');
            });

            $this->route->get('login', function(){

                if(Session::get('user.id')) {
                    redirect(route('profile'));
                }

                return $this->template->fetch('modules/users/login');
            });

            $this->route->post('login', [$this, 'login']);

            $this->route->get('profile', [$this, 'profile']);

            $this->route->get('forgot-password', function(){

                if(Session::get('user.id')) {
                    redirect(route('profile'));
                }

                return $this->template->fetch('modules/users/fp');
            });

            $this->route->get('logout', [$this, 'logout']);
        });

        events()->add('init', function(){});
    }

    public function register()
    {
        if(! $this->request->isPost() ) die;

        $s=0; $i=[];

        $data = $this->request->post('data');

        $this->validator->setErrorMessage('equals_to', t('users.register.error.password_equals_to'));

        $this->validator->addMethod('not_allowed', function($data){

            foreach ($data as $k=>$v) {
                if(! in_array($k, $this->allowed_fields)){
                    return false;
                }
            }

            return true;
        });

        $valid = $this->validator->run
        (
            $data,
            [
                'email'      => 'required|email',
                'password'   => 'required',
                'password_c' => "required|equals_to, {$data['password']}"
            ]
        );

        if(!$valid){
            $i = $this->validator->getErrors();
        } else {
            unset($data['password_c']);

            $data['group_id'] = $this->config->guest_group_id;

            $id = $this->users->create($data);

            $data['id'] = $id;
            $s = $id > 0;

            if($s){
                if($this->config->auth_after_register){
                    $this->users->login($data);
                }
                events()->call('user.registered', ['user' => $data]);
            } else {
                $i = $this->users->getError();
            }
        }

        return ['s'=>$s, 'i' => $i];
    }

    public function login()
    {
        if( ! $this->request->isPost() ) die;

        token_validate();

        $status = 0; $i = [];

        $email = $this->request->post('email');
        $password = $this->request->post('password');

        $valid = $this->validator->run
        (
            ['email' => $email, 'password' => $password],
            ['email' => 'required|email', 'password' => 'required']
        );

        if(!$valid){
            $i = $this->validator->getErrors();
        } else {
            $user = $this->users->getUserByEmail($email);

            if(empty($user)){
                $i[] = ['email' => t('users.login.error.not_found')];
            } elseif($user['status'] == 'ban'){
                $i[] = ['email' => t('users.login.error.status_banned')];
            } elseif($user['status'] == 'deleted'){
                $i[] = ['email' => t('users.login.error.status_deleted')];
            } else if ($this->users->checkPassword($password, $user['password'])){
                if($user['backend'] == 1){
                    $i[] = ['email' => t("users.login.error.only_backend")];
                } else {
                    $status = $this->users->login($user);
                    events()->call('user.login.success', ['user' => $user]);
                }
            } else {
                $i[] = ['password' => t('users.login.error.invalid_password')];
            }
        }

        return ['s' => $status > 0, 'i' => $i];
    }


    public function profile()
    {
        $user = Session::get('user');

        if(!$user){
            redirect('login');
        }

        if($this->request->isPost()){

            $s=0; $i=[];

            $data = $this->request->post('data');

            $this->validator->setErrorMessage('equals_to', t('users.register.error.password_equals_to'));

            $this->validator->addMethod('not_allowed', function($data){

                foreach ($data as $k=>$v) {
                    if(! in_array($k, $this->allowed_fields)){
                        return false;
                    }
                }

                return true;
            });

            $valid = $this->validator->run
            (
                $data,
                [
                    'email'      => 'required|email',
                    'name'       => 'required',
                    'surname'    => 'required',
                    'password'   => 'required',
                    'password_c' => "required|equals_to, {$data['password']}"
                ]
            );

            if(!$valid){
                $i = $this->validator->getErrors();
            }  elseif($this->users->issetEmail($data['email'], $user['id'])){
                $i[] = ["data[email]" => t('users.profile.error.is_email')];
            } else {

                $s = $this->users->update($user['id'], $data);
                if($s){
                    $data = array_merge($user, $data);
                    Session::set('user', $data);

                    events()->call('user.profile.updated', ['user' => $data]);
                }
            }

            return ['s'=>$s, 'i' => $i];
        }

        return $this->template->fetch('modules/users/profile');
    }

    public function logout()
    {
        $user = Session::get('user');
        EventsHandler::getInstance()->call('user.logout', $user);

        $this->users->logout($user['id']);
        redirect( APPURL );
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