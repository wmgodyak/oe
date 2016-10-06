<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.08.16 : 15:41
 */

namespace system\components\install\controllers;

use system\core\Controller;
use system\core\Template;

defined("CPATH") or die();

/**
 * Class Install
 * @package system\components\install\controllers
 */
class Install extends Controller
{
    private $install;
    private $template;

    public function __construct()
    {
        parent::__construct();

        $this->template = Template::getInstance('engine');
//        $this->install = new \system\components\install\models\Install();
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

    private function createAdmin()
    {
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
                    d($error);
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

    public function step2(){}
    public function step3(){}
    public function step4(){}
}