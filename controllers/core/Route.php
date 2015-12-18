<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 07.05.14 21:56
 */
namespace controllers\core;

defined('CPATH') or die();

class Route
{
    /**
     * The URI pattern the route responds to.
     *
     * @var string
     */
    private static $uri;

    private static $rules = array();
    
    /**
     * @var array
     */
    private static $placeholder = array
        (
            '/:module'     =>'/([a-zA-Z]+)',
            '/:controller' => '/([a-zA-Z]+)',
            '/:action'     =>'/([a-zA-Z]+)',
            ':params'      =>'(.*)',
            '/:namespace'  =>'([a-zA-Z]+)',
            '/:int'        =>'/([0-9]+)',
            '~|'           => '(?:',
            '|~'           => '/)?'
        );

    private static function add($pattern, $rule)
    {
        if (strpos($pattern, '(') !== FALSE) {
            $pattern = strtr($pattern, self::$placeholder);
        }
        self::$rules[] = array($pattern,$rule);
    }

    /**
     * Додає роутер
     * @param string $regex
     * @param string $namespace
     * @param string $params
     * @return $this
     */
    private static function setRules($regex, $namespace , $params ='')
    {
        self::$rules[] = array(
            'params'     => $params,
            'regex'      => $regex,
            'namespace'  => $namespace
        );
    }

    private static function getRules(){
        return self::$rules;
    }

    /**
     * @return array
     */
    private static function getRoutes()
    {
        return Config::instance()->get('routes');
    }

    public static function run()
    {
        $namespace = ''; $controller = ''; $action = ''; $params = array();

        $uri = self::protect($_SERVER['QUERY_STRING']);

        $request = Request::instance();

        if(strpos($uri, '?')){
            $a = explode('?', $uri);
            $uri=$a[0];
            foreach ($_GET as $k=>$v) {
               $request->param($k,$v);
            }
        }

        $routes = self::getRoutes();

        foreach ($routes as $route) {
            if(preg_match("@^" . $route['regex'] . "$@u",$uri,$matches)){
//                echo '<pre>FOUND:'; print_r($route);
//                echo 'Matches: '; print_r($matches);

                if(empty($route['params'])) {
                    // вирізаю з неймспейсу :controller :action
                    if(strpos($route['namespace'], ':controller') !== false) {
                        $s = explode(':', $route['namespace']);
//                        echo '<b>NS String:</b> ';

//                        print_r($s);

                        $namespace = $s[0];

                        if(isset($s[1]) && $s[1] == 'controller') {
                            $controller = $matches[1];
                        }

                        if(isset($s[2]) && $s[2] == 'action') {
                            $action = $matches[2];
                        }

                        if(isset($matches[3]) && !empty($matches[3])) {
//                            echo '----------';
                            $params = explode('/', trim($matches[3],'/'));
                        }

//                        var_dump($params);

                    } else {
                        // задано виклик конкретного контрола
                        $controller = substr(strrchr($route['namespace'], '\\'), 1);
                        $namespace  = str_replace($controller, '', $route['namespace']);
                    }

                } else {

//                    echo '---<br>Чітко задана назва і послідовнсть параметрів: ';
                    // чітко задана послідовність параметрів і назви
                    $namespace = $route['namespace'];

                    $request = Request::instance();
                    $s = explode('/', $route['params']);
//                    echo 'Params: '; print_r($s);

                    foreach ($s as $k=>$param) {
//                        echo $k, ':', $param,'<br>';
                        $k++;
                        if(!isset($matches[$k])) continue;
                        $request->param($param, $matches[$k]);

                    }
                }

//                echo '<br><b>Storage</b>: ';
//                print_r($storage);

                break;
            }
        }
        echo "NS: $namespace. C: $controller. A: $action.";
        // save data to request storage
//        $request->setStorage($storage);

//        $this->route();
    }

    private final function route()
    {
        try{
            if(empty($this->storage)) return;
            $namespace = $this->namespace;
            $controller = ucfirst($this->controller);
            $action = $this->action == '' ? 'index' : $this->action;
            $action = rtrim($action,'/');
            $params = $this->params;

//            echo '<pre>'; print_r($this->storage); echo '<br>';

            $c  = $namespace . $controller;
            $path= str_replace("\\", "/", $c);

            if(!file_exists(DOCROOT . $path . '.php')) {
                die('file not exist:' . DOCROOT . $path . '.php');
            }

            $controller = new $c;

            if(!is_callable(array($controller,$action))){
                die('File not is_callable: ' . DOCROOT . $path . '.php');
            }

//            $action = (is_callable(array($controller,$action))) ? $action : 'index';

            if(!empty($params)){
               $res = call_user_func_array(array($controller,$action),$params);
            } else{
               $res = call_user_func(array($controller,$action));
            }

            // save data to request storage
            $request = Request::instance();
            if($res) $request->body = $res;

        } catch (Exceptions $e){
            echo $e->showError();
        }

    }

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
                $$key = null; // This is NOT paranoid because
                unset ($$key); // unset may not work.
            }
        }

        $uri = preg_replace($tags, "", $uri);

        unset($tags,$key,$value);

        return $uri;
    }
}
