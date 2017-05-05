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
        if(!empty($active)){

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
        }

        return $modules;
    }

    private function readConfig($module, $settings)
    {

        $file =  DOCROOT . "modules/{$module}/config.json";

        if(file_exists( $file )) {

            $a = file_get_contents($file);
            $a = json_decode($a, true);
            if(empty($a)) $a = [];

            return array_merge($a, $settings);
        }

        // older versions

        $file =  DOCROOT . "modules/{$module}/config.ini";

        if(file_exists( $file )) {

            $a = parse_ini_file($file, true);

            if(empty($a)) $a = [];

            return array_merge($a, $settings);
        }

        return null;
    }

    private function assignLang($module)
    {
        $modules_dir = 'modules';
        $backend = $this->mode == 'backend' ? 'backend/' : '';
        $dir  =  $modules_dir .'/'. $module . '/lang';
        $file = DOCROOT . $dir . '/' . $backend . $this->lang . '.json';

        if(!file_exists( $file )) {
            $file = DOCROOT . $dir . '/' . $backend . 'en.json';
        }

        if(!file_exists( $file )) {
            return ;
        }

        $a = file_get_contents($file);
        $a = json_decode($a, true);

        Lang::getInstance($this->theme, $this->lang)->addTranslations($module, $a);
    }
}