<?php

namespace modules\account\controllers;

use helpers\FormValidation;
use system\core\Session;
use system\core\WidgetsArea;
use system\Front;
use system\models\Mailer;

if ( !defined("CPATH") ) die();

class Account extends Front
{
    private $reg_group_id=0;
    private $account;
    private $user;

    public function __construct()
    {
        parent::__construct();

        $this->reg_group_id = 2;
        $this->account = new \modules\account\models\Account();

        $this->user = ['id'=>1, 'name' => 'GoVi']; //Session::get('user');
    }

    public function init()
    {
        parent::init();
//        echo "Init " . __CLASS__ . "\r\n";
        $this->template->assign('user', $this->user);
        WidgetsArea::register('account.subscribe', 'Підписка в Account', 'Опис підписки в account');
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
                $user = $this->account->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[password]' => $this->t('admin.e_login_pass')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_deleted')];
                } else if ($this->account->checkPassword($data['password'], $user['password'])){
                    if($user['rang'] > 100) {
                        $i[] = ['data[password]' => $this->t('admin.e_rang')];
                    } else {
                        $status = $this->account->setOnline($user);
                        if($status){
                            Session::set('user', $user);
                        } else{
                            $i[] = ['data[password]' => $this->account->getError()];
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
        }

        return $this->template->fetch('modules/account/login');
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
                $user = $this->account->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[email]' => $this->t('admin.e_bad_email')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_deleted')];
                } else {
                    $skey = base64_encode(serialize($user)); $skey = substr($skey, 0, 64);
                    $s = $this->account->update($user['id'], ['skey' => $skey]);
                    if($s){
                        $user['skey'] = $skey;
                        $user['fp_link'] = APPURL . "route/account/newPsw/{$skey}";

                        $mailer = new Mailer('account_fp', $user);
                        $mailer
                            ->addAddress($user['email'], $user['name'])
                            ->send();
                        $m = $this->t('account.fp_send_email');
                    }
                }
            }

            $this->response->body(array(
                's' => $s,
                'i' => $i,
                'm' => $m
            ))->asJSON();
        }

        $this->template->assign('acc_content', $this->template->fetch('modules/account/fp'));
    }

    public function newPsw($skey=null)
    {
        if($this->request->isPost()){
            $id   = $this->request->post('id', 'i');
            $data = $this->request->post('data'); $i=[]; $s = 0; $m=null;

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
                $s = $this->account->update($id, $data);
                $m = $this->t('account.password_changed_success');
            }

            if(!$s && $this->account->hasError()){
                $m = $this->account->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
        }
        $user = null;
        if(!empty($skey)){
            $user = $this->account->getUserBySkey($skey);
        }

        $this->template->assign('page', ['title' => $this->t('account.new_psw_title')]);
        $this->template->assign('user', $user);
        $this->template->assign('acc_content', $this->template->fetch('modules/account/new_psw'));
        $this->response->body($this->template->fetch('layouts/pages/account'))->asHtml();
    }

    public function register()
    {
        if($this->request->isPost()){

            $data = $this->request->post('data'); $s=0; $i=[];

            FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
            } elseif($this->account->issetEmail($data['email'])){
                $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
            } else {
                unset($data['password_c']);

                if(empty($data['password'])) $data['password'] = $this->account->generatePassword();

                $data['group_id'] = $this->reg_group_id;
                $s = $this->account->create($data);
                if($s){
                    $data['id'] = $s;
                    Session::set('user', $data);
                }

            }

            if(!$s && $this->account->hasError()){
                echo $this->account->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }
        if($this->user){
            $url = $this->getUrl(31); //profile

            $this->redirect( APPURL . $url);
        }
        $this->template->assign('acc_content', $this->template->fetch('modules/account/register'));
    }

    public function profile()
    {
        if(!$this->user){
            $url = $this->getUrl(29); //profile

            $this->redirect( APPURL . $url);
        }

        if($this->request->isPost()){

            $data = $this->request->post('data'); $s=0; $i=[];

            FormValidation::setRule(['name', 'surname', 'email', 'profile'], FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            }  elseif($this->account->issetEmail($data['email'], $this->user['id'])){
                $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
            } else {
                unset($data['password_c']);

                if(empty($data['password'])) $data['password'] = $this->account->generatePassword();

                $data['group_id'] = $this->reg_group_id;
                $s = $this->account->update($this->user['id'], $data);
                if($s){
                    $data = array_merge($this->user, $data);
                    Session::set('user', $data);
                }
            }

            if(!$s && $this->account->hasError()){
                echo $this->account->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }
        $this->template->assign('acc_content', $this->template->fetch('modules/account/profile'));
    }

    public function updatePassword()
    {
        if(!$this->user){
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

            $s = $this->account->update($this->user['id'], $data);
        }

        if(!$s && $this->account->hasError()){
            echo $this->account->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }
}