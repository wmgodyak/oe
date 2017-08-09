<?php

namespace system\core;

use system\models\Permissions;

class Components
{
    public static function init()
    {
        $ns = 'system\components';
        $root = str_replace('\\','/', $ns);

        $components = new \stdClass();
        if ($handle = opendir(DOCROOT . $root)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == 'content')  continue;

                if(! Permissions::canComponent($module, 'index')) continue;

                $c  = $ns .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {

                    $controller = new $c;
                    $components->{$module} = $controller;
                    if(is_callable(array($controller, 'init'))){
                        call_user_func(array($controller, 'init'));
                    }
                }
            }
            closedir($handle);
        }

        return $components;
    }
}