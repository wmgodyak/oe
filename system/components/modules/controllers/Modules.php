<?php

namespace system\components\modules\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\PHPDocReader;
use system\core\Config;
use system\core\DataTables2;
use system\Backend;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Modules
 * @package system\components\modules\controllers
 */
class Modules extends Backend
{
    /**
     * @var
     */
    private static $instance;

    /**
     * @var \system\components\modules\models\Modules
     */
    public $model;

    /**
     * @var string
     *
     * Folder for modules
     */
    private $modules_dir = 'modules';

    private $config_file_name = 'config';
    private $config_file_type = 'json'; // ini|json

    /**
     * Modules constructor.
     */
    public function __construct()
    {
        parent::__construct();

        $this->model = new \system\components\modules\models\Modules();
    }

    /**
     * @return Modules
     */
    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    public function init()
    {
        $this->assignToNav(t('modules.action_index'), 'modules', 'fa-cubes', 'settings');
        $this->template->assignScript("system/components/modules/js/modules.js");
    }

    public function index()
    {
        $this->output($this->template->fetch('system/modules/index'));
    }

    public function tab($status)
    {
        $t = new DataTables2('modules_' . $status);

        $t->ajax('modules/tab/' . $status)
            ->th(t('modules.name'), null, 0, 0)
            ->th(t('modules.description'), null, 0, 0)
            ->th(t('common.tbl_func'), null, 0, 0, 'width: 200px');

        if($this->request->post('draw')){
            $res = []; $modules = []; $installed_modules = Settings::getInstance()->get('modules');
            $modules_dir = 'modules';

            if($status == 'all'){
                $modules = $this->availableModules();
            } elseif($status == 'enabled'){
                if(!empty($installed_modules)){

                    foreach ($installed_modules as $module => $status) {
                        $_module = [];
                        $c  = $modules_dir .'\\'. lcfirst($module) . '\controllers\\' . ucfirst($module);
                        $path = str_replace("\\", "/", $c);

                        if(file_exists(DOCROOT . $path . '.php')) {
                            $meta = PHPDocReader::getMeta($c);
                            $_module['module'] = $module;
                            $_module['status'] = $status;
                            $_module += $meta;
                            $modules[] = $_module;
                        }

                    }
                }
            } elseif($status == 'disabled'){
                $modules = $this->availableModules();
                foreach ($modules as $k=>$module) {
                    if(isset($installed_modules[$module['module']])){
                        unset($modules[$k]);
                    }
                }
            }

            foreach ($modules as $i=>$module) {

                $res[$i][] = isset($module['name']) ? $module['name'] : $module['module'];
                $res[$i][] =
                    (isset($module['description']) ? $module['description'] .'<br>' : '')
                    . '<small>'
                    . "   Author: " . (isset($module['author']) ? $module['author'] : 'none.')
                    . " | Version: " . (isset($module['version']) ? $module['version'] : 'none.')
                    . '</small>'
                ;
                $b = [];

                if(isset($installed_modules[$module['module']])){
                    // edit | hide | pub  | uninstall

                    if($installed_modules[$module['module']]['status'] == 'enabled'){

                        $b[] = (string)Button::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            ['class' => 'b-modules-disable', 'data-id' => $module['module'], 'title' => t('modules.title_disable')]
                        );
                    } else {
                        $b[] = (string)Button::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            ['class' => 'b-modules-enable', 'data-id' => $module['module'], 'title' => t('modules.title_activate')]
                        );

                    }

                    if(isset($module['has_config']) && $module['has_config']){
                        $b[] = (string)Button::create
                        (
                            Icon::create(Icon::TYPE_SETTINGS),
                            ['class' => 'b-modules-edit', 'data-id' => $module['module'], 'title' => t('modules.title_edit')]
                        );
                    }

                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-modules-uninstall btn-danger', 'data-id' => $module['module'], 'title' => t('modules.title_uninstall')]
                    );
                } else {
                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_INSTALL),
                        ['class' => 'b-modules-install', 'data-id' => $module['module'], 'title' => t('modules.title_install')]
                    );

                }
                $res[$i][] = implode('', $b);
            }
            return $t->render($res, $t->getTotal());
        }

        return $t->init();
    }

    private function availableModules()
    {
        $modules = [];

        if ($handle = opendir(DOCROOT . $this->modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == '.htaccess' || $module == 'index.html')  continue;

                $c  = $this->modules_dir .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {
                    $meta = PHPDocReader::getMeta($c);
                    $meta['module'] = ucfirst($module);
                    $meta['has_config'] = file_exists(DOCROOT . $this->modules_dir .'/'. $module . '/config.json');
                    $modules[] = $meta;
                }

            }
            closedir($handle);
        }

        return $modules;
    }

    public function install($module = '')
    {
        $m = null;
        if($module == '') {
            $module = $this->request->post('module');
        }
        $modules = Settings::getInstance()->get('modules');
        $s = $this->model->install($module);
        if($s){
            $modules[$module] = ['status' => 'enabled'];
            Settings::getInstance()->set('modules', $modules);
        } else{
            $m = $this->model->getError();
            if(!empty($m)) $m = implode('<br>', $m);
            $m = "<p style='text-align: left;'>Під час встановлення модуля виникла помилка.</p><p style='text-align: left; font-size: 12px;'>{$m}</p>";
        }

        return ['s' => $s, 'm' => $m];
    }

    public function uninstall()
    {
        $s = false; $m = null;
        $module = $this->request->post('module');
        $modules = Settings::getInstance()->get('modules');
        if(isset($modules[$module])){
            $s = $this->model->uninstall($module);
            if($s){
                unset($modules[$module]);
                Settings::getInstance()->set('modules', $modules);
            } else {
                $m = $this->model->getError();
                if(!empty($m)) $m = implode('<br>', $m);
                $m = "<p style='text-align: left;'>Під час деінсталяції модуля виникла помилка.</p><p style='text-align: left; font-size: 12px;'>{$m}</p>";
            }
        }

        return ['s' => $s, 'm' => $m];
    }

    public function enable()
    {
        $module = $this->request->post('module');
        $modules = Settings::getInstance()->get('modules');
        if(isset($modules[$module])){
            $modules[$module] = ['status' => 'enabled'];
            Settings::getInstance()->set('modules', $modules);
        }

        return ['s' => 1];
    }

    public function disable()
    {
        $module = $this->request->post('module');
        $modules = Settings::getInstance()->get('modules');
        if(isset($modules[$module])){
            $modules[$module] = ['status' => 'disabled'];
            Settings::getInstance()->set('modules', $modules);
        }

        return ['s' => 1];
    }

    public function create(){}

    public function edit($id = null)
    {
        $module  =  $this->request->post('module');
        $modules = Settings::getInstance()->get('modules');

        if(!isset($modules[$module])) {
            return ['s' => 0, 't' => "Error", 'm' => "This module does not available"];
        }

        $path   = DOCROOT . $this->modules_dir .'/'. lcfirst($module) . '/config.json';
        $params = json_decode(file_get_contents($path), true);

        $c      = $this->modules_dir .'\\'. lcfirst($module) . '\controllers\admin\\' . ucfirst($module);
        $c_path = str_replace('\\',DIRECTORY_SEPARATOR, $c) . '.php';

        if(file_exists($c_path)){

            $mi = new $c;

            if(is_callable([$mi, 'config'])){

                $m = $mi->config($params);

                return ['s'=> 1, 't'=> "Configuration of $module", "m" => $m];
            }
        }
        $fields = $this->buildFormFields(lcfirst($module), $params);
        $this->template->assign('fields', $fields);
        $this->template->assign('params', $params);
        $this->template->assign('module', $module);
        $m = $this->template->fetch('system/modules/config');

        return ['s' => 1, 't' => "Configuration of $module", 'm' => $m];
    }

    public function process($id = null)
    {
        $module = $this->request->post('module');
        $data = $this->request->post('config');

        if(empty($data)){
            return ['s'=>0, 'm' => "Цей модуль немає налаштувань"];
        }

        $module  = ucfirst($module);
        $_module = lcfirst($module);

        $modules = Settings::getInstance()->get('modules');

        if(!isset($modules[$module])){
            return ['s'=>0, 'm' => "Цей модуль не існує"];
        }

        $c      = $this->modules_dir .'\\'. $_module . '\controllers\admin\\' . $module;
        $c_path = str_replace('\\',DIRECTORY_SEPARATOR, $c);

        if(file_exists($c_path)){

            $mi = new $c;

            if(is_callable([$mi, 'updateConfig'])){

                return $mi->updateConfig($data);
            }
        }

        if( !isset($modules[$module]['config'])){
            $modules[$module]['config'] = [];
        }

        $config = [];

        foreach ($data as $key=>$value) {
            $config = dots_set($config, $key, $value);
        }

        $path = DOCROOT . $this->modules_dir.'/'.$_module.'/'.$this->config_file_name.".".$this->config_file_type;
        $json = json_encode($config);

        if(file_put_contents($path, $json)){
            return ['s'=>1,'m'=> 'Конфігурацію модуля оновлено'];
        }

        return ['s' => 0, 't' => "Помилка", 'm' => "Щось пішло не так"];
    }

    public function delete($id){}

    private function buildFormFields($module, $config, $code = null, $array = [])
    {
        if(empty($config)) return [];

        foreach($config as $k=>$item) {
            $_code = empty($code) ? $k : "$code.$k";
            if(!is_array($item)) {
                $array[$_code] = [
                    'label' => t($_code),
                    'value' => t($item)
                ];
            } else {
                $a = $this->buildFormFields($module, $item, $_code, $array);
                $array = array_merge($a, $array);
            }
        }

        return $array;
    }
}