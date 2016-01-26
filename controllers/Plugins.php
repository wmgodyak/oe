<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.01.16 : 14:36
 */


namespace controllers;

use controllers\core\Request;
use controllers\core\Template;
use models\core\DB;

defined("CPATH") or die();

class Plugins
{
    private static $plugins = [];

    private function __construct()
    {
    }

    private function __clone()
    {
        // TODO: Implement __clone() method.
    }

    public static function get()
    {
        $request = Request::getInstance();

        $action  = $request->get('action');
        $args    = $request->get('args');

        $r = DB::getInstance()
            -> select("select controller, icon, rang, place, settings from components where type='plugin' order by abs(position) asc")
            -> all();

        foreach ($r as $item) {
            if(!empty($item['settings'])) $item['settings'] = unserialize($item['settings']);

            $p = self::getItem($item['controller']);
            if(method_exists($p, $action)){
                self::$plugins[$item['place']][] = call_user_func_array(array($p, $action), $args);
            }
        }

        return self::$plugins;
    }

    /**
     * @param $plugin
     * @return mixed
     * @throws \FileNotFoundException
     */
    private static function getItem($plugin)
    {
        if(! file_exists(DOCROOT . 'controllers/engine/plugins/' . ucfirst($plugin) . '.php')) {
            throw new \FileNotFoundException("Контроллер плагіну {$plugin} не знайдено.");
        }

        $cl = '\controllers\engine\plugins\\' .  ucfirst($plugin);
        return new $cl;
    }
}