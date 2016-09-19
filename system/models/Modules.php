<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.07.16 : 12:39
 */

namespace system\models;

use system\core\Lang;

defined("CPATH") or die();

/**
 * Class Modules
 * @package system\models
 */
class Modules
{
    private $theme;
    private $lang;
    private $mode;

    public function __construct($theme = null, $lang = null, $mode = 'frontend')
    {
        $this->theme = $theme;
        $this->lang  = $lang;
        $this->mode  = $mode;
    }

    public function init()
    {
        $modules_dir = 'modules';
        $modules = new \stdClass();
        $active = Settings::getInstance()->get('modules');

        $admin = $this->mode == 'backend' ? '\admin' : '';

        foreach ($active as $module=>$params) {
            if($params['status'] != 'enabled') continue;
            $c  = $modules_dir .'\\'. lcfirst($module) . '\controllers'.$admin.'\\' . ucfirst($module);

            $path = str_replace("\\", "/", $c);

            if(file_exists(DOCROOT . $path . '.php')) {

                $_module = lcfirst($module);

                if($this->mode == 'backend' &&  ! Permissions::canModule($_module, 'index')) continue;


                if($this->theme && $this->lang){
                    $this->assignLang($_module);
                }

                $config = $this->readConfig($_module, (isset($params['config']) ? $params['config'] : []));

                $active[$module]['config'] = $config;

                $controller = new $c;
                // assign config to module
                $controller->config = $config;

                $modules->{$_module} = $controller;

                call_user_func(array($controller, 'init'));
            }
        }

        Settings::getInstance()->set('modules', $active);

        return $modules;
    }

    private function readConfig($module, $settings)
    {
        $file =  DOCROOT . "modules/{$module}/config.ini";

        if(!file_exists( $file )) {
            return null;
        }

        $a = parse_ini_file($file, true);

        return array_merge($a, $settings);
    }

    private function assignLang($module)
    {
        $modules_dir = 'modules';
        $dir  =  $modules_dir .'/'. $module . '/lang';
        $file = DOCROOT . $dir . '/' . $this->lang . '.ini';

        if(!file_exists( $file )) {
            return ;
        }
        $a = parse_ini_file($file, true);

        Lang::getInstance($this->theme, $this->lang)->addTranslations($module, $a);
    }
}