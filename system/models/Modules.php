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

class Modules
{
    private $theme;
    private $lang;
    private $mode;

    public function __construct($theme, $lang, $mode = 'frontend')
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

                $this->assignLang(lcfirst($module));
                $controller = new $c;
                $modules->{lcfirst($module)} = $controller;

                call_user_func(array($controller, 'init'));
            }
        }

        return $modules;
    }

    private function assignLang($module)
    {
        $modules_dir = 'modules';
        $dir  =  $modules_dir .'/'. $module . '/lang';
        $file = DOCROOT . $dir . '/' . $this->lang . '/'. $module . '.ini';

        if(!file_exists( $file )) {
            return ;
        }
        $a = parse_ini_file($file, true);

        Lang::getInstance($this->theme, $this->lang)->addTranslations($module, $a);
    }
}