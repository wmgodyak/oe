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

    private $uri_filters = [];

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

    private function __construct(){}

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

    private $callback;

    public function dispatch(Request $request)
    {
        $uri = $request->uri;

        if(empty($uri)) $uri = "/";

        if (isset($_REQUEST['_method']) && in_array(strtoupper($_REQUEST['_method']), ['PUT', 'DELETE'])) {
            $method = strtoupper($_REQUEST['_method']);
        } else {
            $method = $_SERVER['REQUEST_METHOD'];
        }

        $actions = array_merge($this->actions['ANY'], $this->actions[$method]);

        $backend_url = Settings::getInstance()->get('backend_url');

        foreach ($this->uri_filters as $filter) {
            $uri = $filter($uri);
        }

        foreach ($actions as $route) {

            // for admin panel
            $regex = str_replace('backend', $backend_url, $route[0]);

            $regex = str_replace(['{', '}'], ['({','})'], $regex);

            if(strpos($regex,'{') !== false){
                foreach ($this->patterns as $slug => $pattern) {
                    $regex = str_replace('{'.$slug.'}', $pattern, $regex);
                }
            }

            if(strpos($regex,'{') !== false){
                $regex = preg_replace('(\{[[:alpha:]]+\})', $this->patterns['url'], $regex);
            }

            if(preg_match("@^$regex$@siu", $uri, $matches)){

                $request_params = [];

                $a = explode('/', $route[0]);
                foreach ($a as $k=>$pattern) {
                    if(strpos($pattern,'{') !== false){
                        $request_params[] = ['name' => str_replace(['{', '}'], [], $pattern)];
                    }
                }

                $params = [];
                $callback = $route[1];

                if(isset($matches[1])){
                    $params = array_slice($matches, 1);
                    foreach ($params as $k=>$v) {
                        $v = trim($v);
                        if(empty($v)) unset($params[$k]);

                        if(isset($request_params[$k])){
                            $request_params[$k]['value'] = $v;
                        }
                    }
                }

                if(!empty($request_params)){
                    foreach ($request_params as $param) {
                        $request->{$param['name']} = $param['value'];
                    }
                }

                if(is_array($callback) && isset($callback[1])){

                    if(is_callable($callback, true, $callable_name)){

                        $this->callback = [
                            'callback' => $callback,
                            'params'   => $params
                        ];
                        return;
                    }
                }

                if(is_callable($callback, true) && !is_string($callback)){

                    $this->callback = [
                        'callback' => $callback,
                        'params'   => $params
                    ];
                    return;
                }

                if(strpos($callback, 'system\components') !== false){
                    $request->mode = 'backend';
                }

                // only controller
                $controller = $callback;
                $action = "index";

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

                    $request->mode = 'backend';

                    $controller = array_shift($params);

                    $action = "index";
                    if(!empty($params)){
                        $action = array_shift($params);
                    }
                }

                $controller = ucfirst($controller);

                $request->controller = $controller;
                $request->action     = $action;

                // maybe it is module
                $_module  = "modules\\" . lcfirst($controller) . "\\controllers\\$controller";
                $m_path = str_replace("\\", DIRECTORY_SEPARATOR, $_module);

                // or system component
                $_component  = "system\\components\\" . lcfirst($controller) . "\\controllers\\$controller";
                $c_path = str_replace("\\", DIRECTORY_SEPARATOR, $_component);

                $_component_a  = "system\\components\\" . lcfirst($controller) . "\\controllers\\" . ucfirst($action);
                $ca_path = str_replace("\\", DIRECTORY_SEPARATOR, $_component_a);

                // or some controller
                $path = str_replace("\\", DIRECTORY_SEPARATOR, $controller);

                if($callback == 'module' && file_exists(DOCROOT . $m_path . '.php')) {

                    $controller = $_module;

                } elseif($callback == 'component' && file_exists(DOCROOT . $ca_path . '.php')) {

                    $controller = $_component_a;
                    $action = "index";
                    if(!empty($params)){
                        $action = array_shift($params);
                    }

                } elseif($callback == 'component' && file_exists(DOCROOT . $c_path . '.php')) {

                    $controller = $_component;

                } elseif(!file_exists(DOCROOT . $path . '.php')) {

                    throw new \Exception('Route not found', 404);
                }

                events()->call('route', ['request' => $request]);

                if(is_callable([$controller, $action])){

                    $this->callback = [
                        'callback' => [$controller, $action],
                        'params'   => $params
                    ];
                }
                break;
            }
        }
    }

    public function run()
    {
        if(empty($this->callback)){
            $this->callback = [
                'callback' => ['\system\frontend\Page', 'e404'],
                'params'   => []
            ];
        }

        if(is_array($this->callback['callback'])){
            $c = $this->callback['callback'][0]; $a = $this->callback['callback'][1];
            return call_user_func_array([new $c, $a], $this->callback['params']);
        }

        if(!empty($this->callback['params']) && is_array($this->callback['params'])){
            return call_user_func_array($this->callback['callback'], $this->callback['params']);
        }

        return call_user_func($this->callback['callback'], $this->callback['params']);
    }

    public function getCallback()
    {
        return $this->callback;
    }

    /**
     * @param $method
     * @param $uri
     * @param $callback
     * @return $this
     */
    private function add($method, $uri, $callback)
    {
        array_unshift($this->actions[$method], [$uri, $callback]);

        return $this;
    }

    public function uriFilter($callback)
    {
        $this->uri_filters[] = $callback;
        
        return $this;
    }
}
