<?php

namespace modules\customers\controllers;

use helpers\FormValidation;
use system\core\Session;
use system\Front;
use system\models\Mailer;

/**
 * Class Customers
 * @package modules\customers\controllers
 */
class Customers extends Front
{
    /**
     * Default group ID to register
     * @var int
     */
    private $guest_group_id = 20;
    /**
     * Profile page ID
     * @var int
     */
    private $profile_id = 1; 
    private $customers;

    public function __construct()
    {
        parent::__construct();

        $this->customers = new \modules\customers\models\Customers();
    }

    public function init()
    {
        parent::init();
//        echo "Init " . __CLASS__ . "\r\n";
        $this->template->assign('customer', Session::get('customer'));
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
                $user = $this->customers->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[password]' => $this->t('admin.e_login_pass')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[password]' => $this->t('admin.e_login_deleted')];
                } else if ($this->customers->checkPassword($data['password'], $user['password'])){
                    if($user['rang'] > 100) {
                        $i[] = ['data[password]' => $this->t('admin.e_rang')];
                    } else {
                        $status = $this->customers->setOnline($user);
                        if($status){
                            Session::set('customer', $user);
                        } else{
                            $i[] = ['data[password]' => $this->customers->getError()];
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

        return $this->template->fetch('modules/customer/login');
    }

    public function logout()
    {
        Session::delete('customer');
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
                $user = $this->customers->getUserByEmail($data['email']);

                if(empty($user)){
                    $i[] = ['data[email]' => $this->t('admin.e_bad_email')];
                } elseif($user['status'] == 'ban'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_ban')];
                } elseif($user['status'] == 'deleted'){
                    $i[] = ['data[email]' => $this->t('admin.e_login_deleted')];
                } else {
                    $skey = base64_encode(serialize($user)); $skey = substr($skey, 0, 64);
                    $s = $this->customers->update($user['id'], ['skey' => $skey]);
                    if($s){
                        $user['skey'] = $skey;
                        $user['fp_link'] = APPURL . "route/customer/newPsw/{$skey}";

                        $mailer = new Mailer('customer_fp', $user);
                        $mailer
                            ->addAddress($user['email'], $user['name'])
                            ->send();
                        $m = $this->t('customer.fp_send_email');
                    }
                }
            }

            $this->response->body(array(
                's' => $s,
                'i' => $i,
                'm' => $m
            ))->asJSON();
        }

        $this->template->assign('acc_content', $this->template->fetch('modules/customer/fp'));
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
                $s = $this->customers->update($id, $data);
                $m = $this->t('customer.password_changed_success');
            }

            if(!$s && $this->customers->hasError()){
                $m = $this->customers->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
        }
        $user = null;
        if(!empty($skey)){
            $user = $this->customers->getUserBySkey($skey);
        }

        $this->template->assign('page', ['title' => $this->t('customer.new_psw_title')]);
        $this->template->assign('customer', $user);
        $this->template->assign('acc_content', $this->template->fetch('modules/customer/new_psw'));
        $this->response->body($this->template->fetch('layouts/pages/customer'))->asHtml();
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
            } elseif($this->customers->issetEmail($data['email'])){
                $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
            } else {
                unset($data['password_c']);

                if(empty($data['password'])) $data['password'] = $this->customers->generatePassword();

                $data['group_id'] = $this->guest_group_id;
                $s = $this->customers->create($data);
                if($s){
                    $data['id'] = $s;
                    Session::set('customer', $data);
                }
                if($s && isset($data['email'])){
                    $mailer = new Mailer('customer_register', $data);
                    $mailer
                        ->addAddress($data['email'], $data['name'])
                        ->send();
                }
            }

            if(!$s && $this->customers->hasError()){
                echo $this->customers->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }
        
        if(Session::get('customer.id')){
            $url = $this->getUrl(31); //profile

            $this->redirect( APPURL . $url);
        }
        $this->template->assign('acc_content', $this->template->fetch('modules/customer/register'));
    }

    public function profile()
    {
        $user = Session::get('customer');
        
        if(!$user){
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
            }  elseif($this->customers->issetEmail($data['email'], $user['id'])){
                $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
            } else {
                unset($data['password_c']);

                if(empty($data['password'])) $data['password'] = $this->customers->generatePassword();

//                $data['group_id'] = $this->guest_group_id;
                $s = $this->customers->update($user['id'], $data);
                if($s){
                    $data = array_merge($user, $data);
                    Session::set('customer', $data);
                }
            }

            if(!$s && $this->customers->hasError()){
                echo $this->customers->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }
        
        $this->template->assign('acc_content', $this->template->fetch('modules/customer/profile'));
    }

    public function updatePassword()
    {
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

            $s = $this->customers->update($user['id'], $data);
        }

        if(!$s && $this->customers->hasError()){
            echo $this->customers->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }
}