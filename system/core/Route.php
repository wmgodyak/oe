<?php
/**
 * OYiEngine 7.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 07.05.14 21:56
 */
namespace system\core;

use system\models\Settings;

defined('CPATH') or die();

/**
 * Class Route
 * @package system\core
 */
class Route
{
    private static $instance = null;

    private $uri;

    private $actions =
        [
            'PUT'    => [],
            'POST'   =>	[],
            'DELETE' => [],
            'GET'    => [],
            'ANY'    => [],
        ];

    private $patterns = [
        'id'      => '[[:digit:]]+',
        'lang'     => '[a-z]{2}',
        'url'     => '[a-zA-Z0-9-_/]+',
        'any'     => '.+',
        'alpha'   => '[[:alpha:]]+',
        'segment' => '[^/]*'
    ];

    /**
     * @param $name
     * @param $regex
     * @return $this
     */
    public function pattern($name, $regex)
    {
        $this->patterns[$name] = $regex;

        return $this;
    }

    private function __construct()
    {
        $this->uri = rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');
        $this->uri = $this->protect($this->uri);
    }

    private function __clone(){}

    /**
     * @return null|Route
     */
    public static function getInstance(){
        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function any($uri, $callback)
    {
        return $this->add('ANY', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function get($uri, $callback)
    {
        return $this->add('GET', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function post($uri, $callback)
    {
        return $this->add('POST', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function put($uri, $callback)
    {
        return $this->add('PUT', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function patch($uri, $callback)
    {
        return $this->add('PATCH', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function delete($uri, $callback)
    {
        return $this->add('DELETE', $uri, $callback);
    }

    /**
     * @param $uri
     * @param $callback
     * @return Route
     */
    public function options($uri, $callback)
    {
        return $this->add('OPTIONS', $uri, $callback);
    }

    public function actions()
    {
        return $this->actions;
    }

    /**
     * @return $this
     * @throws \Exception
     */
    public function run()
    {
        if(empty($this->uri)) $this->uri = "/";

        if (isset($_REQUEST['_method']) && in_array(strtoupper($_REQUEST['_method']), ['PUT', 'DELETE'])) {
            $method = strtoupper($_REQUEST['_method']);
        } else {
            $method = $_SERVER['REQUEST_METHOD'];
        }

        $actions = array_merge($this->actions['ANY'], $this->actions[$method]);

        $mode = 'frontend';
        $backend_url = Settings::getInstance()->get('backend_url');
        $response  = Response::getInstance();

        foreach ($actions as $route) {
            // for admin panel
            $regex = str_replace('backend', $backend_url, $route[0]);

            $regex = str_replace(['{', '}'], ['({','})'], $regex);

            if(strpos($regex,'{') !== false){
                foreach ($this->patterns as $slug => $pattern) {
                    $regex = str_replace('{'.$slug.'}', $pattern, $regex);
                }
            }

            // if found like this /post/{post}/comment/{comment}
            if(strpos($regex,'{') !== false){
                $regex = preg_replace('(\{[[:alpha:]]+\})', $this->patterns['url'], $regex);
            }

            if(preg_match("@^$regex$@siu", $this->uri, $matches)){

//                d($this->uri);d($regex);d($matches); d($route[1]);

                $params = [];
                $callback = $route[1];

                if(isset($matches[1])){
                    $params = array_slice($matches, 1);
                    foreach ($params as $k=>$v) {
                        $v = trim($v);
                        if(empty($v)) unset($params[$k]);
                    }
                }

                if(is_callable($callback, true) && !is_string($callback)){
                    return $response->body(call_user_func_array($callback, $params));
                } else {

                    // do something
                    if(strpos($callback,'::') !== false){
                        $a = explode('::', $callback);

                        list($controller, $action) = $a;

                    } elseif($callback == 'module'){
                        $controller = array_shift($params);

                        $action = "index";
                        if(!empty($params)){
                            $action = array_shift($params);
                        }
                    } elseif($callback == 'component'){

                        $mode = 'backend';

                        $controller = array_shift($params);

                        $action = "index";
                        if(!empty($params)){
                            $action = array_shift($params);
                        }

                    } else {
                        // only controller
                        $controller = $callback;
                        $action = "index";
                    }

                    $controller = ucfirst($controller);

                    Request::getInstance($mode)
                        ->param('controller', $controller)
                        ->param('action',     $action);

//                    Request::getInstance()->param('args', $params);

                    foreach ($params as $k=>$v) {
                        Request::getInstance()->param($k, $v);
                    }

                    // maybe it is module
                    $_module  = "modules\\" . lcfirst($controller) . "\\controllers\\$controller";
                    $m_path = str_replace("\\", DIRECTORY_SEPARATOR, $_module);

                    // or system component
                    $_component  = "system\\components\\" . lcfirst($controller) . "\\controllers\\$controller";
                    $c_path = str_replace("\\", DIRECTORY_SEPARATOR, $_component);

                    // or some controller
                    $path = str_replace("\\", DIRECTORY_SEPARATOR, $controller);

                    if(file_exists(DOCROOT . $m_path . '.php')) {

                        $controller = $_module;

                    } elseif(file_exists(DOCROOT . $c_path . '.php')) {

                        $controller = $_component;

                    } elseif(!file_exists(DOCROOT . $path . '.php')) {

                        throw new \Exception('Route not found', 404);
                    }

                    return $this->call($controller, $action, $params);
                }
            }
        }

        throw new \Exception('Route not found', 404);
    }

    /**
     * @param $controller
     * @param $action
     * @param $params
     * @return $this
     * @throws \Exception
     */
    private function call($controller, $action, $params)
    {
        $controller = new $controller;

        if(!is_callable([$controller, $action])){
            throw new \Exception("Call to undefined action $action", 404);
        }

        return Response::getInstance()->body(call_user_func_array([$controller, $action], $params));
    }

    /**
     * @param $method
     * @param $uri
     * @param $callback
     * @return $this
     */
    private function add($method, $uri, $callback)
    {
        $this->actions[$method][] = [$uri, $callback];

        return $this;
    }

    /**
     * @param $uri
     * @return mixed
     */
    private function protect($uri)
    {
        $tags = [
            '@\'@si',
            '@\[\[(.*?)\]\]@si',
            '@\[!(.*?)!\]@si',
            '@\[\~(.*?)\~\]@si',
            '@\[\((.*?)\)\]@si',
            '@{{(.*?)}}@si',
            '@\[\+(.*?)\+\]@si',
            '@\[\*(.*?)\*\]@si'
        ];

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
