<?php

namespace modules\users\controllers;

use system\core\EventsHandler;
use system\core\Session;
use system\Frontend;
use system\models\XMail;

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

            route()->get('register', function(){
                if(Session::get('user.id')) {
                    redirect(url('profile'));
                }

                return $this->template->fetch('modules/users/register');
            });

            route()->get('{lang}/register', function(){
                if(Session::get('user.id')) {
                    redirect(url('profile'));
                }

                return $this->template->fetch('modules/users/register');
            });

            route()->post('register', [$this, 'register']);

            route()->get('{lang}/login', function(){
                if(Session::get('user.id')) {
                    redirect(url('profile'));
                }

                return $this->template->fetch('modules/users/login');
            });

            route()->get('login', function(){

                if(Session::get('user.id')) {
                    redirect(url('profile'));
                }

                return $this->template->fetch('modules/users/login');
            });

            route()->post('login', [$this, 'login']);

            route()->get('profile', [$this, 'profile']);
            route()->post('profile', [$this, 'profile']);

            route()->get('change-password', function(){

                if(! Session::get('user.id')) {
                    redirect(url('login'));
                }

                return $this->template->fetch('modules/users/password_change');
            });

            route()->get('forgot-password', function(){

                if(Session::get('user.id')) {
                    redirect(url('profile'));
                }

                return $this->template->fetch('modules/users/fp');
            });

            route()->post('change-password',[$this, 'changePassword']);
            route()->post('forgot-password',[$this, 'fp']);

            route()->get('restore-password/{any}',function($skey){

                if(empty($skey)){
                    die('wrong key');
                }

                $user = $this->users->getUserBySkey($skey);

                if(! $user){
                    die('wrong key');
                }

                $this->template->assign('skey', $skey);
                return $this->template->fetch('modules/users/reset_password');
            });
            route()->post('restore-password',[$this, 'resetPassword']);


            route()->get('account', function(){

                if(! Session::get('user.id')) {
                    redirect(url('login'));
                }

                return $this->template->fetch('modules/users/account');
            });

            route()->get('logout', [$this, 'logout']);
        });

        events()->add('init', function(){});
    }

    public function register()
    {
        if(! $this->request->isPost() ) die;

        token_validate();

        $s=0; $i=[];

        $data = $this->request->post('data');

        $this->validator->setErrorMessage('equals_to', t('users.register.error.password_equals_to'));
        $this->validator->setErrorMessage('not_allowed', t('users.register.error.password_equals_to'));

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

            token_validate();

            $s=0; $i=[];

            $data = $this->request->post('data');

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
                    'surname'    => 'required'
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
            $m = t('users.profile.updated');
            return ['s'=>$s, 'i' => $i, 'm' => $m];
        }

        return $this->template->fetch('modules/users/profile');
    }

    public function changePassword()
    {
        if(! $this->request->isPost()) die();

        token_validate();

        $user = Session::get('user');
        if(!$user){
            return ['s'=>0, 'm' => "Invalid user"];
        }


        $i=[]; $s = 0;

        $data = [
            'password'   => $this->request->post('password'),
            'password_c' => $this->request->post('password_c')
        ];

        $this->validator->setErrorMessage('equals_to', t('users.register.error.password_equals_to'));

        $valid = $this->validator->run
        (
            $data,
            [
                'password'   => 'required',
                'password_c' => "required|equals_to, {$data['password']}"
            ]
        );

        if(!$valid){
            $i = $this->validator->getErrors();
        }   else {

            unset($data['password_c']);

            $s = $this->users->update($user['id'], $data);
        }

        $m = t('users.profile_psw.updated');
        return ['s'=>$s, 'i' => $i, 'm' => $m];
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
        token_validate();

        $s = 0; $i = []; $m=null;
        $email = $this->request->post('email');
        $valid = $this->validator->run
        (
            ['email' => $email],
            ['email'  => 'required|email']
        );

        if(!$valid){
            $i = $this->validator->getErrors();
        }  elseif(! $this->users->issetEmail($email)){
            $i[] = ["email" => t('users.fp.error.not_found')];
        } else {
            $user = $this->users->getUserByEmail($email);

            if(empty($user)){
                $i[] = ['email' => t('users.fp.error.not_found')];
            } elseif($user['status'] == 'ban'){
                $i[] = ['email' => t('users.fp.error.status_banned')];
            } elseif($user['status'] == 'deleted'){
                $i[] = ['email' => t('users.fp.error.status_deleted')];
            } else {

                $skey = base64_encode(serialize($user));
                $skey = substr($skey, 0, 64);

                $s = $this->users->update($user['id'], ['skey' => $skey]);

                if($s){
                    $user['skey'] = $skey;
                    $user['link'] = APPURL . "restore-password/{$skey}";

                    $mailer = new XMail(t('users.ft.mail.subject'), ['user' => $user]);
                    $body = sprintf($this->template->fetch('modules/users/mail/fp'), $user['name'], $user['link']);
                    $mailer->body($body);
                    $mailer->addAddress($user['email'], $user['name']);
                    $s = $mailer->send();
                    $m = t('users.fp.success') . " " . $user['link'];
                }
            }
        }

        return ['s' => $s, 'i' => $i, 'm' => $m];

    }

    public function resetPassword()
    {
        $skey = $this->request->post('skey');

        $i=[]; $s = 0; $m = null;

        $data = [
            'skey' => $skey,
            'password' => $this->request->post('password'),
            'password_c' => $this->request->post('password_c')
        ];

        $this->validator->setErrorMessage('equals_to', t('users.reset_password.error.password_equals_to'));

        $valid = $this->validator->run
        (
            $data,
            [
                'skey'       => 'required',
                'password'   => 'required',
                'password_c' => "required|equals_to, {$data['password']}"
            ]
        );

        if(!$valid){
            $i = $this->validator->getErrors();
        }   else {

            $user = $this->users->getUserBySkey($skey);
            if(empty($user)){
                $i[] = ["password" => t('users.reset_password.error.wrong_skey')];
            } else{

                unset($data['password_c']);

                $s = $this->users->update($user['id'], $data);

                $m = t('users.reset_password.updated');
            }
        }

        return ['s'=>$s, 'i' => $i, 'm' => $m];
    }
}