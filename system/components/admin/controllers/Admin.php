<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:33
 */

namespace system\components\admin\controllers;

use helpers\FormValidation;
use system\core\Lang;
use system\core\Session;
use system\Backend;
use system\models\Permissions;

defined("CPATH") or die();

class Admin extends Backend {

    private $mAdmin;

    /**
     * error handle
     * @var array
     */

    public function __construct()
    {
        parent::__construct();

        $this->mAdmin = new \system\components\admin\models\Admin();
    }

    /**
     * @param $key
     * @param null $val
     * @return null
     */
    public static function data($key = null, $val = null)
    {
        if(! $key && ! $val){
            if(! isset($_SESSION['backend']['admin'])) return null;
            return $_SESSION['backend']['admin'];
        } elseif(!$val){
            if(isset($_SESSION['backend']['admin'][$key])){
                return $_SESSION['backend']['admin'][$key];
            }

            return null;
        }

        if(!isset($_SESSION['backend'])) $_SESSION['backend'] = array();
        if(!isset($_SESSION['backend']['admin'])) $_SESSION['backend']['admin'] = array();

        $_SESSION['backend']['admin'][$key] = $val;

        return $val;
    }


    /**
     * @return int id
     */
    public static function id()
    {
        return self::data('id');
    }

    /**
     *
     */
    public function login()
    {
        if($this->request->isPost()){
            $status = 0; $inp = []; $data = $this->request->post('data');
            $ban_time = time()+3600;
            $secpic = $this->request->post('secpic');

            $fail = isset($_COOKIE['fail']) ? $_COOKIE['fail'] : 0;

            if($fail > 5){
                $inp[] = ['data[password]' => $this->t('admin.ban')];

            } elseif(empty($data['email']) || empty($data['password'])){
                $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];

                setcookie('fail', ++$fail, $ban_time);

            } elseif ( $fail > 0 && ( isset($_SESSION['secpic']) && $_SESSION['secpic'] != $secpic)) {
                $inp[] = ['data[password]' => $this->t('admin.e_captcha')];

                setcookie('fail', ++$fail, $ban_time);

            } else {

                $user = $this->mAdmin->getUserByEmail($data['email']);
                Permissions::set($user['permissions']);

                if(empty($user)){
                    $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];
                    setcookie('fail', ++$fail, $ban_time);

                } elseif($user['status'] == 'ban'){
                    $inp[] = ['data[password]' => $this->t('admin.e_login_ban')];
                    setcookie('fail', ++$fail, $ban_time);

                } elseif($user['status'] == 'deleted'){
                    $inp[] = ['data[password]' => $this->t('admin.e_login_deleted')];
                    setcookie('fail', ++$fail, $ban_time);
                } else if ($this->mAdmin->checkPassword($data['password'], $user['password'])){
                    if($user['backend'] == 0) {
                        $inp[] = ['data[password]' => $this->t('admin.e_rang')];
                        setcookie('fail', ++$fail, $ban_time);
                    } else {
                        $status = $this->mAdmin->login($user);
                        if($status){
                            foreach ($user as $k=>$v) {
                                self::data($k, $v);
                            }
                            $a = self::data('avatar');
                            if(empty($a)){
                                self::data('avatar', '/uploads/avatars/0.png');
                            }
                            Session::set('backend_lang', $data['lang']);
                            setcookie('fail', '', time() - 60);
                        } else{
                            $inp[] = ['data[password]' => $this->mAdmin->getErrorMessage()];
                        }
                    }
                } else {
                    $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];
                    setcookie('fail', ++$fail, $ban_time);
                }
            }

            $this->response->body(array(
                's' => $status > 0,
                'i' => $inp,
                'f' => $fail > 0
            ))->asJSON();
            return;
        }

        // витягнути список доступних мовних версій
        $langs = Lang::getInstance()->getLangs();
        $this->template->assign('langs', $langs);

        $this->response->body($this->template->fetch('system/admin/login'));
    }

    /**
     * @throws \phpmailerException
     */
    public function fp()
    {
        if($this->request->isPost()){
            $status = 0; $inp = []; $data = $this->request->post('data');

            $fail = isset($_COOKIE['fail']) ? $_COOKIE['fail'] : 0;

            if($fail > 5){
                $e[] = $this->t('admin.ban');
            } elseif(empty($data['email'])){
                $inp[] = ['data[email]' => $this->t('admin.e_email')];

                setcookie('fail', ++$fail, time()+60*15);

            } else {
                $user = $this->mAdmin->getUserByEmail($data['email']);
                Permissions::set($user['permissions']);
                if(empty($user)){
                    $inp[] = ['data[email]' => $this->t('admin.e_email')];
                    setcookie('fail', ++$fail, time()+60*15);
                }elseif($user['backend'] == 0) {
                    $inp[] = ['data[email]' => $this->t('admin.e_rang')];
                    setcookie('fail', ++$fail, time()+60*15);
                } else {
                    // new password
                    $psw = $this->mAdmin->generatePassword();
                    if($this->mAdmin->changePassword($user['id'], $psw)){

                        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";
                        $mail = new \PHPMailer();
                        $mail->addAddress($data['email']);
                        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], $this->t('core.sys_name'));

                        $tpl = implode("\r\n", $this->t('admin.fp_tpl'));
                        $mail->Body = str_replace(['{psw}'],[$psw], $tpl);
                        $status = $mail->send();
                        if($status){
                            $inp[] = ['data[email]' => $this->t('admin.fp_success')];
                        } else{
                            $inp[] = ['data[email]' => 'Error. Message not send.'];
                        }
                    }
                }
            }

            $this->response->body(array(
                's' => $status > 0,
                'i' => $inp,
                'f' => $fail > 0
            ))->asJSON();
        }
    }

    /**
     * logout user
     * @return mixed
     */
    public function logout()
    {
        Session::destroy();
        setcookie('fail', '', time() - 3600);
        $this->redirect('/');
    }

    public function profile()
    {
        if($this->request->isPost()){
            $data = $this->request->post('data'); $s=0; $i=[]; $user_id = self::data('id');

            // правила
            FormValidation::setRule(['name', 'surname', 'email', 'phone'], FormValidation::REQUIRED);
            FormValidation::setRule('email', FormValidation::EMAIL);

            // валідація
            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
            } else {

                if(empty($data['password'])){
                    unset($data['password']);
                }
                unset($data['password_c']);

                // оновлення даних
                $s = $this->mAdmin->updateProfile($user_id, $data);

                if($s == 0){
                    echo $this->mAdmin->getErrorMessage();
                } else {
                    if(isset($_FILES['avatar'])){
                        $a = $this->mAdmin->changeAvatar($user_id);
                        if($a['s']){
                            self::data('avatar', $a['f']);
                        }
                    }

                    foreach ($data as $k=>$v) {
                        self::data($k, $v);
                    }
                }

            }

            $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a) ? $a['f'] : null])->asJSON();
        }

        $this->template->assign('ui', self::data());
        $this->response->body($this->template->fetch('system/admin/edit_profile'))->render();
    }
    public function index()
    {
    }

    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function process($id)
    {
    }
    public function delete($id)
    {
    }
}