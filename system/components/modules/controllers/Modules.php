<?php

namespace system\components\modules\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\PHPDocReader;
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
    public $model;
    public function __construct()
    {
        parent::__construct();

        $this->model = new \system\components\modules\models\Modules();
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

                    foreach ($installed_modules as $module=> $status) {
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
                    . "   Author: " . (isset($module['author']) ? $module['author'] : 'немає.')
                    . " | Version: " . (isset($module['version']) ? $module['version'] : 'немає.')
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

                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_SETTINGS),
                        ['class' => 'b-modules-edit', 'data-id' => $module['module'], 'title' => t('modules.title_edit')]
                    );
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
            echo $t->render($res, $t->getTotal()); return;
        }

        return $t->init();
    }

    private function availableModules()
    {
        $modules_dir = 'modules';
        $modules = [];

        if ($handle = opendir(DOCROOT . $modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == '.htaccess')  continue;

                $c  = $modules_dir .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {
                    $meta = PHPDocReader::getMeta($c);
                    $meta['module'] = ucfirst($module);
                    $modules[] = $meta;
                }

            }
            closedir($handle);
        }

        return $modules;
    }

    public function install()
    {
        $m = null;
        $module = $this->request->post('module');
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

    public function create()
    {

    }

    public function edit($id = null)
    {
        $s=0; $t=null; $m=null; $config = null;
        $module =  $this->request->post('module');
        $modules = Settings::getInstance()->get('modules');
        if(isset($modules[$module])){

            $_module = lcfirst($module);
            $t = 'Налаштування модуля';
            $path = DOCROOT . "modules/{$_module}/config.ini";
            if (file_exists($path)) {
                $s=1;
                $config = parse_ini_file($path);
                $s_config = isset($modules[$module]['config']) ? $modules[$module]['config'] : [];
                $config = array_merge($config, $s_config);
            }
        }
        $this->template->assign('config', $config);
        $this->template->assign('module', $module);
        $m = $this->template->fetch('system/modules/config');

        return ['s' => $s, 't' => $t, 'm' => $m];
    }


    public function process($id = null)
    {
        $s=0; $t=null; $m=null;
        $module = $this->request->post('module');
        $config = $this->request->post('config');
        if(empty($config)){
            $m = "Цей модуль немає налаштувань";
        } else {
            $module = ucfirst($module);

            $modules = Settings::getInstance()->get('modules');

            if(isset($modules[$module])){
//                $_module = lcfirst($module);
//                $path = DOCROOT . "modules/{$_module}/config.ini";
//                if( !file_exists($path)){
//                    $m = "Цей модуль немає налаштувань";
//                } else {
//
//                }
                $s=1;
                $m = 'Налаштування модуля оновлено';

                if( !isset($modules[$module]['config'])){
                    $modules[$module]['config'] = [];
                }

                $modules[$module]['config'] = $config;

                Settings::getInstance()->set('modules', $modules);
            }
        }

        return ['s' => $s, 't' => $t, 'm' => $m];
    }

    public function delete($id){}
}