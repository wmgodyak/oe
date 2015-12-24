<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;

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
    public function login()
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
        $langs = Lang::getInstance()->getLangs();

        $this->template->assign('langs', $langs);

        $this->response->body($this->template->fetch('admin/login'));
    }

    public function fp()
    {
        $status=0;
        $this->lang = Languages::instance()->getTranslations();
        if(empty($_POST['email'])){
            $e[] = $this->lang->auth['e_email'];
        } else {
            $user = $this->ma->userDataByEmail($_POST['email']);
            if(empty($user)){
                $e[] = $this->lang->auth['e_email'];
            } else {
                $pwd = $this->generatePassword();

                if($this->ma->updatePassword($user['id'], crypt($pwd))) {
                    mail($user['email'], 'NEW PASWORD', "Ви надсилали запит на зміну паролю.<br> Ваш новий пароль: $pwd.");
                    $status = 1;
                    $e[] = $this->lang->auth['e_fp_success'];
                }
            }
        }

        echo json_encode(array(
            't' =>$this->lang->auth['e_title_success'],
            's' => $status,
            'm' =>implode('<br>', $this->error)
        ));
    }


    /**
     * logout user
     * @return mixed
     */
    public function logout()
    {
        $uid = $_SESSION['admin']['id'];

        unset($_SESSION['admin']);
        setcookie('rmus','',time() - 1,'/' );

    }
    public function index()
    {
        // TODO: Implement index() method.
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}
