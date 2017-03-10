<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.08.16 : 15:41
 */

namespace system\components\install\controllers;

use system\core\Controller;
use system\core\Lang;
use system\core\Template;

defined("CPATH") or die();

/**
 * Class Install
 * @package system\components\install\controllers
 */
class Install extends Controller
{
    private $template;

    public function __construct()
    {
        parent::__construct();

        $this->template = Template::getInstance('backend');
        $this->request->setMode('backend');
    }

    public function init(){}

    public function index()
    {
        $body = null;
        $step = $this->request->post('action');
        switch($step){
            case'create_admin':
                $body = $this->createAdmin();
                break;
            case'db_config':
                $body = $this->dbConfig();
                break;
            case'server_check':
                $body = $this->serverCheck();
                break;
            case'licence':
                $body = $this->license();
                break;
            default:
                $body = $this->welcome();
                break;
        }

        $this->template->assign('body', $body);
        echo $this->template->fetch('system/install/index');
    }

    public function success()
    {
        $this->template->assign('data', $this->request->post('data'));
        return $this->template->fetch('system/install/success');
    }

    private function createAdmin()
    {
        $langs = Lang::getInstance('backend')->getAllowedLanguages();
        $language = $this->request->post('language','s');
        $data = $this->request->post('data');
        $conf = $_SESSION['inst']['db'];
        $prefix = $conf['prefix'];
        if($this->request->isPost() && $language){
            try {
                $db = new \PDO("mysql:host={$conf['host']};dbname={$conf['name']}",$conf['user'],$conf['pass']);
                $db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING);
                $db->exec("SET NAMES utf8");
                $db->setAttribute(\PDO::ATTR_EMULATE_PREPARES, 0);
            } catch(\PDOException $e) {
                $error[] = $e->getMessage();
            }

            // create admin
            if(empty($this->error)){
                try {
                    $pass = crypt($data['pass'], md5(time()));
                    $db->exec("
                    insert into {$prefix}users (group_id, languages_id,name,email,password)
                    values (1, 1, '{$data['user']}','{$data['email']}', '{$pass}') ");
                } catch(\PDOException $e) {
                    $this->error[] = 'E2:' . $e->getMessage();
                }
            }
//            if(empty($this->error)){
//                try {
//                    $db->exec("
//                    insert ignore into {$prefix}content (id, types_id, subtypes_id, owner_id, status)
//                    values (1, 1, 1, 1, 'published') ");
//                    $db->exec("
//                    insert ignore into {$prefix}content_info (id, content_id, languages_id, name)
//                    values (1, 1, 1, 'Home') ");
//                } catch(\PDOException $e) {
//                    $this->error[] = 'E2:' . $e->getMessage();
//                }
//            }
            // set language
            try{
                $db->exec("update {$prefix}languages set `code`='{$language}', `name`='{$langs[$language]}' where id = 1 limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }
            // set settings
            try{
                $db->exec("update {$prefix}settings set `value`='{$data['email']}' where name = 'mail_email_from' limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }
            try{
                $db->exec("update {$prefix}settings set `value`='{$data['email']}' where name = 'mail_email_to' limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }
            try{
                $db->exec("update {$prefix}settings set `value`='{$data['name']}' where name = 'mail_from_name' limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }
            try{
                $db->exec("update {$prefix}settings set `value`='{$data['name']}' where name = 'company_name' limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }
            try{
                if(empty($data['backend_url'])) $data['backend_url'] = 'backend';
                $db->exec("update {$prefix}settings set `value`='{$data['backend_url']}' where name = 'backend_url' limit 1");
            } catch(\PDOException $e) {
                $this->error[] = 'E1:' . $e->getMessage();
            }

            if(empty($this->error)){
                try{
                    $c_sample = DOCROOT . "config/db.sample.php";
                    $cpath = DOCROOT . "config/db.php";

                    // запишу конфіг
                    $config = file_get_contents($c_sample);
                    $config = str_replace
                    (
                        array(
                            '%host%','%db%','%user%','%pass%', '%prefix%'
                        ),
                        array(
                            $conf['host'], $conf['name'], $conf['user'], $conf['pass'], $conf['prefix']
                        ),
                        $config
                    );

                    $h = fopen($cpath,'w+');

                    if (fwrite($h, $config) === FALSE) {
                        $this->error[] = 'Неможу записати конфіг';
                    }
                } catch(\Exception $e) {
                    $this->error[] = $e->getMessage();
                }
            }

            if(empty($this->error)){
                return $this->success();
            }
        }
        $this->template->assign('langs', $langs);
        return $this->template->fetch('system/install/create_admin');
    }

    private function dbConfig()
    {
        $conf = $this->request->post('data'); $db=null; $error = [];
        if(!empty($conf)){

            try{
                $db = new \PDO("mysql:host={$conf['host']};dbname={$conf['name']}",$conf['user'],$conf['pass']);
                $db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING);
                $db->exec("SET NAMES utf8");
                $db->setAttribute(\PDO::ATTR_EMULATE_PREPARES, 0);
            }
            catch(\PDOException $e) {
                $error[] = $e->getMessage();
            }

            if($db) {
                $_SESSION['inst']['db'] = $conf;
                try{
                    // імпортую БД
                    $query = file_get_contents(DOCROOT . "system/components/install/sql/install.sql");
                    $query = str_replace('__', $conf['prefix'], $query);
                    $db->exec($query);
                }
                catch(\PDOException $e) {
                    $error[] = 'Import error: ' . $e->getMessage() ;
//                    d($error);
                }
            }

            if(empty($error)) {
                $_POST['action'] = 'create_admin';
                return $this->createAdmin();
            }

        }
        $this->template->assign('error', $error);
        return $this->template->fetch('system/install/db_config');
    }

    private function serverCheck()
    {
        $res = []; $result = true;

        $srv = $_SERVER["SERVER_SOFTWARE"];
        if (strlen($srv)<=0){
            $srv = $_SERVER["SERVER_SIGNATURE"];
        }

        $srv = trim($srv);

        if (@preg_match("#^([a-zA-Z-]+).*?([\d]+\.[\d]+(\.[\d]+)?)#i", $srv, $m))
        {
            $res['web_server']['data'] = "{$m[1]} {$m[2]}";
            $res['web_server']['status'] = true;
        }

        $sapi = strtolower(php_sapi_name());
        $res['php_interface']['data'] = $sapi;
        $res['php_interface']['status'] = $sapi !== 'cgi';

        $res['php_ver']['data'] = phpversion();
        $res['php_ver']['status'] = version_compare(phpversion(),'5.3.0','>');

        $limit = ini_get('memory_limit')? ini_get('memory_limit') : get_cfg_var("memory_limit");
        $res['memory_limit']['data'] = $limit;
        $res['memory_limit']['status'] = true;

        $t = function_exists('mcrypt_encrypt');
        $res['mcrypt']['data'] = $t;
        $res['mcrypt']['status'] = $t;

        $res['ex_time']['data'] = ini_get('max_execution_time');
        $res['ex_time']['status'] = ini_get('max_execution_time') >= 30;

        $res['mod_rewrite']['data']   = in_array('mod_rewrite', apache_get_modules());
        $res['mod_rewrite']['status'] = in_array('mod_rewrite', apache_get_modules());

        $res['mbstring']['data']   = function_exists("mb_substr");
        $res['mbstring']['status'] = $res['mbstring']['data'] ;


        $res['disc_space']['data'] = intval(@disk_free_space(DOCROOT)/1024/1024);
        $res['disc_space']['status'] = $res['disc_space']['data'] > 30;

        $i = $this->dirInfo(DOCROOT . 'tmp');
        $a = explode(' ', $i);
        $res['dir_perm_tmp']['data'] = $i;
        $res['dir_perm_tmp']['status'] = $a[0] * 1 >= 775;

        $i = $this->dirInfo(DOCROOT . 'logs');
        $a = explode(' ', $i);
        $res['dir_perm_logs']['data'] = $i;
        $res['dir_perm_logs']['status'] = $a[0] * 1 >= 775;

        $i = $this->dirInfo(DOCROOT . 'uploads');
        $a = explode(' ', $i);
        $res['dir_perm_uploads']['data'] = $i;
        $res['dir_perm_uploads']['status'] = $a[0] * 1 >= 775;


        foreach ($res as $row) {
            if($row['status'] == false){
                $result = false;
                break;
            }
        }

        $this->template->assign('result', $result);
        $this->template->assign('res', $res);
        return $this->template->fetch('system/install/server');
    }

    private function dirInfo($dir) {
        if (function_exists('posix_getpwuid') && function_exists('posix_getgrgid')) {
            $perm=substr(sprintf('%o', @fileperms($dir)), -4);
            $user=posix_getpwuid(fileowner($dir));
            $group=posix_getgrgid(filegroup($dir));
            return $perm." ".$user['name']." ".$group['name'];
        } else {
            return "N/A";
        }
    }

    private function welcome()
    {
        return $this->template->fetch('system/install/welcome');
    }

    private function license()
    {
        $text = null;
        if(file_exists(DOCROOT . 'license.txt')){
            $text = file_get_contents(DOCROOT . 'license.txt');
        }

        $this->template->assign('text', $text);
        return $this->template->fetch('system/install/license');
    }
}