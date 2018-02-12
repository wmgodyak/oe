<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.07.16 : 12:39
 */

namespace system\models;

use system\core\Lang;
use system\core\Request;

defined("CPATH") or die();

/**
 * Class Modules
 * @package system\models
 */
class Modules
{
    const DIR = "modules";
    private static $instance;
    private $modules = [];

    private function __construct(){}

    private function __clone(){}

    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self();
        }

        return self::$instance;
    }

    public function get($module = null)
    {
        if($module) {
            $module = lcfirst($module);
            return $this->modules->{$module};
        }

        return $this->modules;
    }

    public function boot(Request $request)
    {
        $this->modules = new \stdClass();
        $active = Settings::getInstance()->get('modules');

        if(empty($active)){
            return;
        }

        $lang = Lang::getInstance();

        foreach ($active as $module=>$params) {
            if(!isset($params['status']) || $params['status'] != 'enabled') continue;

            $_module = lcfirst($module);

            if($request->mode == 'backend'){
                $c  = self::DIR .'\\'. $_module . '\controllers\admin\\' . ucfirst($module);
            } else {
                $c  = self::DIR .'\\'. $_module . '\controllers\\' . ucfirst($module);
            }

            $path = str_replace('\\', DIRECTORY_SEPARATOR, $c . ".php");

            if(! file_exists($path)){
                continue;
            }

            if($request->mode == 'backend' && ! Permissions::canModule($_module, 'index')){
                continue;
            }

            $controller = new $c;

            $this->modules->{$_module} = $controller;

            if($request->mode == 'backend'){
                if(! Permissions::canModule($_module, 'index')) continue;

                $t_path = DOCROOT . "modules/{$_module}/lang/backend/{$request->language->code}.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$_module}/lang/backend/en.json";
                }
            } else {
                $t_path = DOCROOT . "modules/{$_module}/lang/{$request->language->code}.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$_module}/lang/en.json";
                }
            }

            // load translations
            $lang->parseFile($t_path, $_module);

            call_user_func(array($controller, 'init'));
        }
    }

    public function getActionsList($backend = false)
    {
        $bl = ['init', 'boot', '__construct', '__set', 'before', 'redirect'];
        $res = [];
        foreach ($this->modules as $module) {

            $a = explode('\\', (string)$module);
            $module_name = end($a);
            $module_name = lcfirst($module_name);

            if($backend){
                $c  = self::DIR .'\\'. $module_name . '\controllers\admin\\' . ucfirst($module_name);
                $path = str_replace('\\', DIRECTORY_SEPARATOR, $c . ".php");

                if(! file_exists($path)){
                    continue;
                }

                $module = new $c;
            }

            $class = new \ReflectionClass($module);

            foreach ($class->getMethods(\ReflectionMethod::IS_PUBLIC) as $method) {

                if(in_array($method->name, $bl) || strpos($method->name, '__') !== false) continue;

                $res[$module_name][] = $method->name;
            }
        }

        return $res;
    }
}