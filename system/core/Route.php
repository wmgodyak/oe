<?php
/**
 * OYiEngine 7.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 07.05.14 21:56
 */
namespace system\core;

use system\core\exceptions\Exception;

defined('CPATH') or die();

class Route
{
    private static $rules = array();

    /**
     * @throws \Exception
     */
    private static function getRoutes()
    {
        $r = Config::getInstance()->get('routes');
        if(empty($r)) throw new Exception('No routes.');

        foreach ($r as $k => $v) {
            $regex     = $v[0];
            $namespace = $v[1];
            $params    = isset($v[2]) ? $v[2] : null;
            self::$rules[] = array(
                'regex'      => $regex,
                'params'     => $params,
                'namespace'  => $namespace
            );
        }
    }

    public static function run()
    {
        $namespace = ''; $controller = ''; $action = 'index'; $params = array();

        $uri = self::protect($_SERVER['REQUEST_URI']);

        $uri = urldecode($uri);
        if(strpos($uri, '?')){
            $a = explode('?', $uri);
            $uri = $a[0];
        }

        self::getRoutes();

        $found_route = false;
        foreach (self::$rules as $route) {
            if(preg_match("@^" . $route['regex'] . "$@siu", $uri, $matches)){
                $found_route = true;
                if(empty($route['params'])) {
                    // вирізаю з неймспейсу :controller :action
                    if(strpos($route['namespace'], ':controller') !== false) {
                        $s = explode(':', $route['namespace']);
                        $namespace = $s[0];

                        if(isset($s[1]) && $s[1] == 'controller') {
                            $controller = $matches[1];
                        }

                        if(isset($s[2]) && $s[2] == 'action') {
                            $matches[2] = isset($matches[2]) ? $matches[2] : 'index';
                            $action = $matches[2];
                        }

                        if(isset($matches[3]) && !empty($matches[3])) {
                            $params = explode('/', trim($matches[3],'/'));
                        }

                    } else {
                        // задано виклик конкретного контрола
                        $controller = substr(strrchr($route['namespace'], '\\'), 1);
                        $namespace  = str_replace($controller, '', $route['namespace']);
                    }

                } else {
                    // чітко задана послідовність параметрів і назви
                    $namespace = $route['namespace'];

                    $s = explode('/', $route['params']);
                    foreach ($s as $k=>$param) {
                        $k++;
                        if(!isset($matches[$k])) continue;
                        $params[$param] = $matches[$k];
                    }
                }

                break;
            }
        }

//        if(!$found_route){
//            $namespace  = self::$ns;
//            $controller = 'App';
//            $action     = 'e404';
//        }

        $controller = ucfirst($controller);

        $action = rtrim($action,'/');

        $mode = strpos($namespace, 'system') !== FALSE ? 'backend' : 'frontend';

        Request::getInstance($mode)
            ->param('namespace',  $namespace)
            ->param('controller', $controller)
            ->param('action',     $action);

//        echo $controller, ' :: ', $action , ' :: ';

        Request::getInstance()->param('args', $params);

        foreach ($params as $k=>$v) {
            Request::getInstance()->param($k, $v);
        }

        $c_dir = lcfirst($controller) . '\controllers\\';

        // change engine to system folder
        $c  = $namespace . $c_dir . $controller;

        // 7.2 зміна на папку


//        echo $c, '::', $controller, "<br>";die;

        $path = str_replace("\\", "/", $c);

        if(!file_exists(DOCROOT . $path . '.php')) {
            die('Controller not found:' . DOCROOT . $path . '.php');
        }

        $controller = new $c;

        if(!is_callable(array($controller, $action))){
            die('Action '. $action .' is not callable: ' . DOCROOT . $path . '.php');
        }

//        Event::fire($c, 'before'.ucfirst($action), $params);

        if(!empty($params)){
//            call_user_func_array(array($controller, 'before'), $params);
            $res = call_user_func_array(array($controller, $action), $params);
        } else {
//            call_user_func(array($controller, 'before'));
            $res = call_user_func(array($controller, $action));
        }

//        Event::fire($c, 'after' . ucfirst($action), $params);

        if($res){
            Response::getInstance()->body($res);
        }
    }

    /**
     * @param $uri
     * @return mixed
     */
    private static function protect($uri)
    {
        $tags = array (
            '@\'@si',
            '@\[\[(.*?)\]\]@si',
            '@\[!(.*?)!\]@si',
            '@\[\~(.*?)\~\]@si',
            '@\[\((.*?)\)\]@si',
            '@{{(.*?)}}@si',
            '@\[\+(.*?)\+\]@si',
            '@\[\*(.*?)\*\]@si'
        );

        if (isset($_SERVER['QUERY_STRING']) && strpos(urldecode($_SERVER['QUERY_STRING']), chr(0)) !== false)
            die();

        if (@ ini_get('register_globals')) {
            foreach ($_REQUEST as $key => $value) {
                $$key = null;
                unset ($$key);
            }
        }

        $uri = preg_replace($tags, "", $uri);

        unset($tags, $key, $value);

        return $uri;
    }
}
