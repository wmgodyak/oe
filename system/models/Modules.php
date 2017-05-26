<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.07.16 : 12:39
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class Modules
 * @package system\models
 */
class Modules
{
    const DIR = "modules";
    private static $instance;
    private $modules;

    private function __construct()
    {
        $this->boot();
    }

    private function __clone(){}

    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self();
        }

        return self::$instance;
    }

    public function get()
    {
        return $this->modules;
    }

    private function boot()
    {
        $this->modules = new \stdClass();
        $active = Settings::getInstance()->get('modules');

        if(empty($active)){
            return;
        }

        foreach ($active as $module=>$params) {

            if($params['status'] != 'enabled') continue;

            $c  = self::DIR .'\\'. lcfirst($module) . '\controllers\\' . ucfirst($module);

            $controller = new $c;

            $_module = lcfirst($module);

            $config = $this->readConfig($_module, (isset($params['config']) ? $params['config'] : []));

            // assign config to module
            $controller->config = $config;

            $this->modules->{$_module} = $controller;

            call_user_func(array($controller, 'init'));
        }
    }

    public function init($mode, $lang,array $params = [])
    {
        foreach ($this->modules as $module) {

            foreach ($params as $param_name=> $param_value) {
                $module->{$param_name} = $param_value;
            }

            $a = explode('\\', (string)$module);
            $module_name = end($a);
            $module_name = lcfirst($module_name);

            if($mode == 'backend'){
                if(! Permissions::canModule($module_name, 'index')) continue;

                // replace module path
                $c  = self::DIR .'\\'. $module_name . '\controllers\admin\\' . ucfirst($module_name);
                $path = str_replace('\\', DIRECTORY_SEPARATOR, $c . ".php");
                if(! file_exists($path)){
                    continue;
                }
                $module = new $c;
                $t_path = DOCROOT . "modules/{$module_name}/lang/backend/$lang.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$module_name}/lang/backend/en.json";
                }
            } else {
                $t_path = DOCROOT . "modules/{$module_name}/lang/$lang.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$module_name}/lang/en.json";
                }
            }

            // load translations
            t()->parseFile($t_path, $module_name);

            call_user_func(array($module, 'init'));
        }
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
}