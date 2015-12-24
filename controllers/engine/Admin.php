<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;

use controllers\Engine;

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
//            return $this->loginProcess();
        }

        // витягнути список доступних мовних версій
        $langs = Lang::getInstance()->getLangs();

        $this->template->assign('langs', $langs);

        $this->response->body($this->template->fetch('admin/login'));
    }

    private function loginProcess()
    {
//        $this->dump($_SESSION); die();
        // init languages
        $this->lang = Languages::instance()->getTranslations();
        $status = 0;
//        $_SESSION['fail'] = 1;
        if(!isset($_SESSION['fail'])) $_SESSION['fail'] = 0;

        if($_SESSION['fail'] > 5){
            $this->error[] = $this->lang->auth['e_login_limit_ex'];

        } elseif(empty($_POST['email']) || empty($_POST['password'])){
            $this->error[] = $this->lang->auth['e_bad_e_p'];
            $_SESSION['fail']++;

        } elseif ( $_SESSION['fail'] > 0 && ( isset($_SESSION['secpic']) && $_SESSION['secpic'] != $_POST['secpic'])) {
            $this->error[] = $this->lang->auth['e_bad_code'];
            $_SESSION['fail']++;

        } else {
            $user = $this->ma->userDataByEmail($_POST['email']);
//            $this->dump($user); die();
            if(empty($user)){
                $this->error[] = $this->lang->auth['e_bad_e_p'];
                $_SESSION['fail']++;

            } else if (crypt($_POST['password'],$user['password']) == $user['password']){

                if($user['rang'] <= 100) {
                    $this->error[] = $this->lang->auth['e_permission_denied'];
                    $_SESSION['fail']++;
                } else {
                    $this->ma->updateSession($user['id']);

                    Admin::data('id', $user['id']);
                    Admin::data('name', $user['name']);
                    Admin::data('rang', $user['rang']);
                    Admin::data('email', $user['email']);
                    Admin::data(
                        'languages',
                        array(
                        'id'=>$user['languages_id'],
                        'code'=>$user['code']
                        )
                    );

                    $this->error[] = $this->lang->auth['e_success'];
                    unset($_SESSION['fail']);
                    $status = 1;
                }
            } else {
                $this->error[] = $this->lang->auth['e_bad_e_p'];
                $_SESSION['fail']++;
            }
        }

        echo json_encode(array(
            't' => $this->lang->auth['e_title_error'],
            's' => $status,
            'm' => implode('<br>', $this->error),
            'f' => isset($_SESSION['fail']) ? $_SESSION['fail'] : 0
        ));
    }

    public function fp()
    {
        $status=0;
        $this->lang = Languages::instance()->getTranslations();
        if(empty($_POST['email'])){
            $this->error[] = $this->lang->auth['e_email'];
        } else {
            $user = $this->ma->userDataByEmail($_POST['email']);
            if(empty($user)){
                $this->error[] = $this->lang->auth['e_email'];
            } else {
                $pwd = $this->generatePassword();

                if($this->ma->updatePassword($user['id'], crypt($pwd))) {
                    mail($user['email'], 'NEW PASWORD', "Ви надсилали запит на зміну паролю.<br> Ваш новий пароль: $pwd.");
                    $status = 1;
                    $this->error[] = $this->lang->auth['e_fp_success'];
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
     * generate random password
     * @param int $number
     * @return string
     */
    private function generatePassword($number = 6)
    {
        $arr = array(
            'A','B','C','D','E','F',
            'G','H','I','J','K','L',
            'M','N','O','P','R','S',
            'T','U','V','X','Y','Z',
            '1','2','3','4','5','6',
            '7','8','9','0'
        );

        $pass = "";
        for($i = 0; $i < $number; $i++)
        {
            $index = rand(0, count($arr) - 1);
            $pass .= $arr[$index];
        }
        return $pass;
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
