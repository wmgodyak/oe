<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:33
 */

namespace system\components\auth\controllers;

use helpers\Captcha;
use helpers\FormValidation;
use system\core\Lang;
use system\core\Session;
use system\Backend;
use system\models\Permissions;

defined("CPATH") or die();

/**
 * Class Auth
 * @package system\components\auth\controllers
 */
class Auth extends Backend {

    private $mAdmin;
    private $captcha;

    public function __construct()
    {
        parent::__construct();

        $this->mAdmin = new \system\components\auth\models\Auth();

        $oh = 'ask';
        $key = Session::get($oh);

        if(empty($key)){
            $key = random_string(4);
            Session::set($oh, $key);
        }

        $this->captcha = new Captcha($key, ['bg_color' => [27, 25, 71]]);
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
            $unset_keys = ['surname', 'phone'];

            if (in_array($key, $unset_keys)) {
                unset($_SESSION['backend']['admin'][$key]);
            } elseif (isset($_SESSION['backend']['admin'][$key])) {
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
        // витягнути список доступних мовних версій
        $langs = Lang::getInstance()->getLangs($this->template->theme);
        $fail = isset($_SESSION['fail']) ? $_SESSION['fail'] : 0;

        if($this->request->isPost()){

            $status = 0; $inp = []; $data = $this->request->post('data');

            if($fail > 5){
                $inp[] = ['data[password]' => t('auth.ban')];

            } elseif(empty($data['email']) || empty($data['password'])){
                $inp[] = ['data[password]' => t('auth.e_login_pass')];
                $fail++;

            } elseif ( $fail > 0 && ! $this->captcha->check()) {

                $ckey = $this->captcha->key();

                $inp[] = ['data['. $ckey .']' => t('auth.e_captcha')];

                $fail++;
            } else {

                $user = $this->mAdmin->getUserByEmail($data['email']);
                Permissions::set($user['permissions']);

                if(empty($user)){
                    $inp[] = ['data[password]' => t('auth.e_login_pass')];
                    $fail++;
                } elseif($user['status'] == 'ban'){
                    $inp[] = ['data[password]' => t('auth.e_login_ban')];
                    $fail++;
                } elseif($user['status'] == 'deleted'){
                    $inp[] = ['data[password]' => t('auth.e_login_deleted')];
                    $fail++;
                } else if ($this->mAdmin->checkPassword($data['password'], $user['password'])){
                    if($user['backend'] == 0) {
                        $inp[] = ['data[password]' => t('auth.e_rang')];
                        $fail++;
                    } else {
                        $status = $this->mAdmin->login($user, false);
                        if($status){
                            foreach ($user as $k=>$v) {
                                self::data($k, $v);
                            }
                            if(empty($data['lang'])){
                                $data['lang'] = $this->languages->languages->getData($user['languages_id'], 'code');
                            }

                            if(empty($data['lang'])){
                                $data['lang'] = $this->languages->languages->getDefault('code');
                            }

                            Session::set('backend_lang', $data['lang']);

                        } else{
                            $inp[] = ['data[password]' => $this->mAdmin->getErrorMessage()];
                            $fail++;
                        }
                    }
                } else {
                    $inp[] = ['data[password]' => t('auth.e_login_pass')];
                    $fail++;
                }
            }

            $_SESSION['fail'] = $fail;

            return [
                's' => $status > 0,
                'i' => $inp,
                'f' => $fail > 0,
                'c' => $fail
            ];
        }

        $this->template->assign('fail', $fail);
        $this->template->assign('langs', $langs);
        $this->template->assign('c_key', $this->captcha->key());
        $this->template->display('system/auth/login');
    }

    public function pic()
    {
        $this->captcha->make();
    }

    /**
     * @throws \phpmailerException
     */
    public function fp()
    {
        if($this->request->isPost()){
            $status = 0; $inp = []; $data = $this->request->post('data');

            $fail = isset($_SESSION['fail']) ? $_COOKIE['fail'] : 0;

            if($fail > 5){
                $e[] = t('auth.ban');
            } elseif(empty($data['email'])){
                $inp[] = ['data[email]' => t('auth.e_email')];

                $fail++;

            } else {
                $user = $this->mAdmin->getUserByEmail($data['email']);
                Permissions::set($user['permissions']);
                if(empty($user)){
                    $inp[] = ['data[email]' => t('auth.e_email')];
                    $fail++;
                }elseif($user['backend'] == 0) {
                    $inp[] = ['data[email]' => t('auth.e_rang')];
                    $fail++;
                } else {
                    // new password
                    $psw = $this->mAdmin->generatePassword();
                    if($this->mAdmin->changePassword($user['id'], $psw)){

                        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";
                        $mail = new \PHPMailer();
                        $mail->addAddress($data['email']);
                        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], t('core.sys_name'));

                        $tpl = implode("\r\n", t('auth.fp_tpl'));
                        $mail->Body = str_replace(['{psw}'],[$psw], $tpl);
                        $status = $mail->send();
                        if($status){
                            $inp[] = ['data[email]' => t('auth.fp_success')];
                        } else{
                            $inp[] = ['data[email]' => 'Error. Message not send.'];
                        }
                    }
                }
                $_SESSION['fail'] = $fail;
            }
            return [ 's' => $status > 0, 'i' => $inp, 'f' => $fail > 0 ];
        }
    }

    /**
     * logout user
     * @return mixed
     */
    public function logout()
    {
        $this->mAdmin->logout(self::id());

        Session::destroy();
        setcookie('fail', '', time() - 3600);

        redirect('');
    }

    public function profile()
    {
        if($this->request->isPost()){
            $data = (array)$this->request->post('data'); $s=0; $i=[];
            $user_id = self::data('id');

            $valid = $this->validator->run($data, [
                'name' => 'required',
                'email' => 'required|email',
            ]);
            if(! $valid){
                $i = $this->validator->getErrors();
            } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                $i[] = ["data[password_c]" => t('admin_profile.e_pasw_equal')];
            } else {

                if(empty($data['password'])){
                    unset($data['password']);
                }
                unset($data['password_c']);

                // оновлення даних
                $s = $this->mAdmin->update($user_id, $data);

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

            return ['s'=>$s, 'i' => $i, 'a' => isset($a) ? $a['f'] . '?_=' . time() : null];
        }

        $this->template->assign('data', self::data());
        $this->template->display('system/auth/edit_profile');
    }

    public function index(){}
    public function create(){}
    public function edit($id){}
    public function process($id){}
    public function delete($id){}
}