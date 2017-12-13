<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.08.16 : 15:41
 */

namespace system\components\install\controllers;

use helpers\PHPDocReader;
use system\core\Controller;
use system\core\DB;
use system\core\Lang;
use system\core\Session;
use system\core\Template;
use system\models\Modules;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Install
 * @package system\components\install\controllers
 */
class Install extends Controller
{
    private $template;

    private $db;

    private $conf;

    public function __construct()
    {
        parent::__construct();
        $this->template = Template::getInstance('backend');
        $this->request->setMode('backend');
    }

    public function init(){}

    public function index()
    {
        $this->template->mode = 'installing';
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
        $this->db = DB::getInstance();
        $langs = Lang::getInstance()->getAllowedLanguages();
        $language = $this->request->post('language','s');
        $data = $this->request->post('data');
        $conf = Session::get('inst.db');
        $prefix = $conf['prefix'];
        $error = [];
        if($this->request->isPost() && $language){
            // create admin
            if(empty($error)){
                try {
                    $pass = crypt($data['pass'], md5(time()));
                    $this->db->exec("
                    insert into {$prefix}users (group_id, languages_id,name,email,password)
                    values (1, 1, '{$data['user']}','{$data['email']}', '{$pass}') ");
                } catch(\PDOException $e) {
                    $error[] = 'E2:' . $e->getMessage();
                }
            }

            // set language
            try{
                $this->db->exec("update {$prefix}languages set `code`='{$language}', `name`='{$langs[$language]}' where id = 1 limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }
            // set settings
            try{
                $this->db->exec("update {$prefix}settings set `value`='{$data['email']}' where name = 'mail_email_from' limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }
            try{
                $this->db->exec("update {$prefix}settings set `value`='{$data['email']}' where name = 'mail_email_to' limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }
            try{
                $this->db->exec("update {$prefix}settings set `value`='{$data['name']}' where name = 'mail_from_name' limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }
            try{
                $this->db->exec("update {$prefix}settings set `value`='{$data['name']}' where name = 'company_name' limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }
            try{
                if(empty($data['backend_url'])) $data['backend_url'] = 'backend';
                $this->db->exec("update {$prefix}settings set `value`='{$data['backend_url']}' where name = 'backend_url' limit 1");
            } catch(\PDOException $e) {
                $error[] = 'E1:' . $e->getMessage();
            }

            if(empty($error)){
                Session::delete('inst');
            }

            if(empty($error)){
                return $this->success();
            }
        }
        $this->template->assign('error', $error);
        $this->template->assign('langs', $langs);
        return $this->template->fetch('system/install/create_admin');
    }

    private function createConfigFile()
    {
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
                    $this->conf['host'], $this->conf['db'], $this->conf['user'], $this->conf['pass'], $this->conf['prefix']
                ),
                $config
            );

            $h = fopen($cpath,'w+');

            if (fwrite($h, $config) === FALSE) {
                $error[] = 'Неможу записати конфіг';
            } else {
                return true;
            }
        } catch(\Exception $e) {
            $error[] = $e->getMessage();
        }
        return $error;
    }

    private function dbConfig()
    {
        $error = [];
        $conf = $this->request->post('data');
        if(!empty($conf)){
            $this->conf = include(DOCROOT."config/db.sample.php");
            $this->conf['host'] = $conf['host'];
            $this->conf['db'] = $conf['name'];
            $this->conf['user'] = $conf['user'];
            $this->conf['pass'] = $conf['pass'];
            $this->conf['prefix'] = $conf['prefix'];
            $db_config = $this->createConfigFile();
            if($db_config == true) {
                $this->db = DB::getInstance($this->conf);
                if($this->db) {
                    Session::set('inst.db', $this->conf);
                    try{
                        $query = file_get_contents(DOCROOT . "system/components/install/sql/install.sql");
                        $query = str_replace('__', $this->conf['prefix'], $query);
                        $this->db->exec($query);
                        $this->installModules();
                        return $this->createAdmin();
                    }
                    catch(\PDOException $e) {
                        $error[] = 'Import error: ' . $e->getMessage();
                    }
                }
            } else {
                $error = $db_config;
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

    private function installModules()
    {
        $modules_dir = 'modules';
        $modules = [];

        if ($handle = opendir(DOCROOT . $modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == '.htaccess' || $module == 'index.html')  continue;

                $c  = $modules_dir .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {
                    $meta = PHPDocReader::getMeta($c);
                    $meta['module'] = ucfirst($module);
                    $meta['path'] = $modules_dir.'\\'. $module;
                    $modules[] = $meta;
                    $response = $this->installModule($meta['module']);
                    if($response['m'] != NUll) {
                        die($response['m']);
                    }
                }

            }
            closedir($handle);
        }
        return $modules;
    }

    private function installModule($module)
    {
        $m = null;
        $model = new \system\components\modules\models\Modules();
        $modules = Settings::getInstance()->get('modules');
        $s = $model->install($module);
        if($s){
            $modules[$module] = ['status' => 'enabled'];
            Settings::getInstance()->set('modules', $modules);
        } else{
            $m = $model->getError();
            if(!empty($m)) $m = implode('<br>', $m);
            $m = "<p style='text-align: left;'>Під час встановлення модуля виникла помилка.</p><p style='text-align: left; font-size: 12px;'>{$m}</p>";
        }

        return ['s' => $s, 'm' => $m];
    }
}