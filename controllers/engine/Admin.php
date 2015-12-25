<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;

use controllers\core\Config;
use controllers\Engine;
use models\engine\User;

defined('CPATH') or die();

class Admin extends Engine {

    private $mAdmin;

    /**
     * error handle
     * @var array
     */

    public function __construct()
    {
        parent::__construct();

        $this->mAdmin = new \models\engine\Admin();
    }

    /**
     * @param $key
     * @param null $val
     * @return null
     */
    public static function data($key, $val = null)
    {
        if(!$val){
            if(isset($_SESSION['engine']['admin'][$key])){
                return $_SESSION['engine']['admin'][$key];
            }

            return null;
        }

        if(!isset($_SESSION['engine'])) $_SESSION['engine'] = array();
        if(!isset($_SESSION['engine']['admin'])) $_SESSION['engine']['admin'] = array();

        $_SESSION['engine']['admin'][$key] = $val;
    }


    /**
     * @return int id
     */
    public static function id()
    {
        return self::data('id');
    }

    /**
     * Login user
     * @return string
     */
    public function login($lang=null)
    {
        if($this->request->isPost()){
            $status = 0; $inp = []; $data = $this->request->post('data');

            $secpic = $this->request->post('secpic');

            $fail = isset($_COOKIE['fail']) ? $_COOKIE['fail'] : 0;

            if($fail > 5){
                $e[] = $this->t('admin.ban');

            } elseif(empty($data['email']) || empty($data['password'])){
                $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];

                setcookie('fail', ++$fail, time()+3600);

            } elseif ( $fail > 0 && ( isset($_SESSION['secpic']) && $_SESSION['secpic'] != $secpic)) {
                $inp[] = ['data[secpic]' => $this->t('admin.e_captcha')];

                setcookie('fail', ++$fail, time()+3600);

            } else {
                $user = $this->mAdmin->getUserByEmail($data['email']);

                if(empty($user)){
                    $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];
                    setcookie('fail', ++$fail, time()+3600);

                } else if (User::checkPassword($data['password'], $user['password'])){
                    if($user['rang'] <= 100) {
                        $inp[] = ['data[password]' => $this->t('admin.e_rang')];
                        setcookie('fail', ++$fail, time() + 3600);
                    } else {
                        $status = $this->mAdmin->login($user);
                        if($status){
                            foreach ($user as $k=>$v) {
                                self::data($k, $v);
                            }
                            setcookie('fail', '', time() - 3600);
                        }
                    }
                } else {
                    $inp[] = ['data[password]' => $this->t('admin.e_login_pass')];
                    setcookie('fail', ++$fail, time()+3600);
                }
            }

            $this->response->body(array(
                's' => $status > 0,
                'i' => $inp,
                'f' => $fail > 0
            ))->asJSON();
        }

        // витягнути список доступних мовних версій
        $langs = Lang::getInstance()->getLangs(); $c= false;
        foreach ($langs as $l) {
            if($lang == $l['code']){
                Config::getInstance()->set('core.lang', $lang);
                setcookie('lang', $lang, time()+3600+8, "/", "." . $_SERVER['HTTP_HOST']);
                $this->template->assign('t', Lang::getInstance($lang, true)->t());
                $c=true;
            }
        }
        if(! $c){
            $lang = Config::getInstance()->get('core.lang');
        }

        $this->template->assign('s_lang', $lang);
        $this->template->assign('langs', $langs);

        $this->response->body($this->template->fetch('admin/login'));
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

                setcookie('fail', ++$fail, time()+3600);

            } else {
                $user = $this->mAdmin->getUserByEmail($data['email']);

                if(empty($user)){
                    $inp[] = ['data[email]' => $this->t('admin.e_email')];
                    setcookie('fail', ++$fail, time()+3600);
                } else {
                    // new password
                    $psw = User::generatePassword();
                    if(User::changePassword($user['id'], $psw)){

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
        $uid = $_SESSION['admin']['id'];

        unset($_SESSION['admin']);

    }
    public function index()
    {
        return $this->login();
    }

    public function create()
    {
        return $this->login();
    }

    public function edit($id)
    {
        return $this->login();
    }

    public function process($id)
    {
        return $this->login();
    }
    public function delete($id)
    {
        return $this->login();
    }
}
