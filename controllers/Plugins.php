<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.01.16 : 14:36
 */


namespace controllers;

use controllers\core\Request;
use models\core\DB;

defined("CPATH") or die();

class Plugins
{
    private static $plugins = [];

    private function __construct(){}

    private function __clone()
    {
        // TODO: Implement __clone() method.
    }

    public static function get()
    {
        $request = Request::getInstance();

        $controller  = $request->get('controller');
        $action      = $request->get('action');
        $args        = $request->get('args');

        $r = DB::getInstance()
            -> select("
                select p.controller, p.icon, p.rang, p.place, p.settings
                from plugins p
                join components c on c.controller = '{$controller}'
                join plugins_components pc on pc.plugins_id=p.id and pc.components_id=c.id
                where p.published=1
                order by abs(p.position) asc
            ")
            -> all();

        foreach ($r as $item) {
            if(!empty($item['settings'])) $item['settings'] = unserialize($item['settings']);

            $p = self::getItem($item['controller'], $item);
            if(method_exists($p, $action) && !in_array($action, $p->disallow_actions)){ //  && $p->autoload == true

                self::$plugins[$item['place']][] = call_user_func_array(array($p, $action), $args);
            }
        }

        return self::$plugins;
    }

    /**
     * @param $plugin
     * @param null $data
     * @return mixed
     * @throws \FileNotFoundException
     */
    private static function getItem($plugin, $data=null)
    {
        if(! file_exists(DOCROOT . 'controllers/engine/plugins/' . ucfirst($plugin) . '.php')) {
            throw new \FileNotFoundException("Контроллер плагіну {$plugin} не знайдено.");
        }

        $cl = '\controllers\engine\plugins\\' .  ucfirst($plugin);

        $cl = new $cl();
        $cl->setMeta($data);

        return $cl;
    }

//    public function run()
//    {
//        $a = func_get_args();
//        if(empty($a)) throw new \Exception('Wrong plugin');
//        $controller = $a[0];
//        $action = isset($a[1]) ? $a[1] : 'index';
//        unset($a[0]); if(isset($a[1])) unset($a[1]);
//        $args = $a;
//
//        $plugin = $this->getItem($controller);
//        return call_user_func_array(array($plugin, $action), $args);
//    }
}