<?php

if ( !defined('CPATH') ) die();

/**
 * @param $className
 */
    function autoLoad($className)
    {
        $className = ltrim($className, '\\');
        $fileName = '';
        if ($lastNsPos = strrpos($className, '\\')) {
            $namespace = substr($className, 0, $lastNsPos);
            $className = substr($className, $lastNsPos + 1);
            $fileName = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
        }
        $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
        if (file_exists($fileName)) {
            require $fileName;
            return;
        }
    }

    /**
     * PHP as CGI
     */
    if (get_magic_quotes_gpc()) {
        function clearGpc($array)
        {
            return is_array($array) ? array_map('clearGpc', $array) : stripslashes($array);
        }

        $_COOKIE  = clearGpc($_COOKIE);
        $_FILES   = clearGpc($_FILES);
        $_GET     = clearGpc($_GET);
        $_POST    = clearGpc($_POST);
        $_REQUEST = clearGpc($_REQUEST);
    }
/**
 * debug var
 * @param $var
 */
    function d($var)
    {
        echo '<pre class="sys-dump">'; print_r($var); echo '</pre>';
        echo "<style type='text/css'>.sys-dump{text-align: left; z-index:99999; position: relative; display: block; font-size: 1em; font-family: monospace; line-height: 1.2em; color: white; background-color: #2d0922; padding: 1em; margin-bottom: 1em;}</style>";
    }

    function dd($var)
    {
        d($var); die;
    }

    function ddo($var)
    {
        d(json_decode(json_encode($var))); die;
    }

if (!function_exists('http_response_code')) {
    function http_response_code($code = NULL) {

        if ($code !== NULL) {

            switch ($code) {
                case 100: $text = 'Continue'; break;
                case 101: $text = 'Switching Protocols'; break;
                case 200: $text = 'OK'; break;
                case 201: $text = 'Created'; break;
                case 202: $text = 'Accepted'; break;
                case 203: $text = 'Non-Authoritative Information'; break;
                case 204: $text = 'No Content'; break;
                case 205: $text = 'Reset Content'; break;
                case 206: $text = 'Partial Content'; break;
                case 300: $text = 'Multiple Choices'; break;
                case 301: $text = 'Moved Permanently'; break;
                case 302: $text = 'Moved Temporarily'; break;
                case 303: $text = 'See Other'; break;
                case 304: $text = 'Not Modified'; break;
                case 305: $text = 'Use Proxy'; break;
                case 400: $text = 'Bad Request'; break;
                case 401: $text = 'Unauthorized'; break;
                case 402: $text = 'Payment Required'; break;
                case 403: $text = 'Forbidden'; break;
                case 404: $text = 'Not Found'; break;
                case 405: $text = 'Method Not Allowed'; break;
                case 406: $text = 'Not Acceptable'; break;
                case 407: $text = 'Proxy Authentication Required'; break;
                case 408: $text = 'Request Time-out'; break;
                case 409: $text = 'Conflict'; break;
                case 410: $text = 'Gone'; break;
                case 411: $text = 'Length Required'; break;
                case 412: $text = 'Precondition Failed'; break;
                case 413: $text = 'Request Entity Too Large'; break;
                case 414: $text = 'Request-URI Too Large'; break;
                case 415: $text = 'Unsupported Media Type'; break;
                case 500: $text = 'Internal Server Error'; break;
                case 501: $text = 'Not Implemented'; break;
                case 502: $text = 'Bad Gateway'; break;
                case 503: $text = 'Service Unavailable'; break;
                case 504: $text = 'Gateway Time-out'; break;
                case 505: $text = 'HTTP Version not supported'; break;
                default:
                    exit('Unknown http status code "' . htmlentities($code) . '"');
                    break;
            }

            $protocol = (isset($_SERVER['SERVER_PROTOCOL']) ? $_SERVER['SERVER_PROTOCOL'] : 'HTTP/1.0');

            header($protocol . ' ' . $code . ' ' . $text);

            $GLOBALS['http_response_code'] = $code;

        } else {

            $code = (isset($GLOBALS['http_response_code']) ? $GLOBALS['http_response_code'] : 200);

        }

        return $code;

    }
}

if (!function_exists('assets')){
    /**
     * Assign assets to template
     * @param $path
     * @param bool $theme_path
     * @param int $priority
     * @return string
     * @throws Exception
     * @throws \system\core\exceptions\Exception
     */
    function assets($path, $theme_path = true, $priority = 0)
    {
        $env = \system\core\Config::getInstance()->get('core.environment');
        $template = \system\core\Template::getInstance();

        $ext = pathinfo($path, PATHINFO_EXTENSION);
        $ext = mb_strtolower($ext);

        $file_path = ( $theme_path ? $template->theme_path . 'assets/' : '' ) . $path;

        switch($ext){
            case 'js':
                $template->assignScript($file_path, $priority);
                $link = "<script src='{$file_path}'></script>";
                break;
            case 'css':
                $template->assignStyle($file_path, $priority);
                $link = "<link href='{$file_path}' rel='stylesheet'>";
                break;
            case 'ico':
                return  "<link rel=\"icon\" href=\"$file_path\">";
                break;
            case 'png':
            case 'jpg':
            case 'jpeg':
            case 'gif':
                return  "<img src=\"$file_path\">";
                break;
            default:
                throw new Exception('Wrong file extension. Allowed only png,jpg,jpeg,gif,css and js');
                break;
        }

        if($env != 'production') return $link;
    }
}

if(!function_exists('t')){

    function t($key=null)
    {
        $lang = \system\core\Lang::getInstance();

        if(empty($key)){
            return $lang;
        }

        return $lang->get($key);
    }
}

if(!function_exists('dots_get')){
    function dots_get(array $array, $key)
    {
        $keys = explode('.', $key);
        if (empty($keys)) {
            return null;
        }

        $current = $array;

        foreach ($keys as $k) {
            if (!isset($current[$k])) {
                return null;
            }
            $current = $current[$k];
        }

        return $current;
    }
}
if(!function_exists('dots_set')){
    function dots_set(array $array, $key, $value)
    {
        $keys = explode('.', $key);
        if (empty($keys)) {
            return $array;
        }
        $keys = array_reverse($keys);

        foreach ($keys as $k) {
            $value = array($k => $value);
        }

        return array_replace_recursive($array, $value);
    }
}

if (!function_exists('filter_apply')){
    /**
     * example
     *
     *  filter_add('backend.login.logo', 'path/to/custom/logo.png');
     *  filter_add('backend.sidebar.logo', 'path/to/custom/logo.png');
     * @param $key
     * @param $value
     * @return mixed|null
     */
    function filter_apply($key, $value)
    {
        return \system\core\DataFilter::apply($key, $value);
    }
}

if (!function_exists('filter_add')){
    function filter_add($key, $value)
    {
        \system\core\DataFilter::add($key, $value);
    }
}

if (!function_exists('module_config')){
    function module_config($module)
    {
        static $config;

        if(isset($config[$module])){
            return $config[$module];
        }

        $path = "modules/$module/config.json";
        if(!file_exists(DOCROOT . $path)) return null;

        $a = file_get_contents(DOCROOT . $path);

        $config[$module] = json_decode($a);

        return $config[$module];
    }
}

if ( ! function_exists('settings')){

    function settings($name = null, $value=null, $block=null, $type=null)
    {
        if (is_null($name)) {
            return \system\models\Settings::getInstance();
        }

        if($value){
            return \system\models\Settings::getInstance()->set($name, $value, $block, $type);
        }

        return \system\models\Settings::getInstance()->get($name);
    }

}

if (!function_exists('events')){

    function events()
    {
        return \system\core\EventsHandler::getInstance();
    }

}

if( ! function_exists('route')){
    /**
     * @deprecated
     * @param $url
     * @return string
     */
    function route($url)
    {
        $url = trim($url, '/');
        $lang = \system\core\Languages::getInstance();

        $prefix = $lang->is_main ? "" : "$lang->code/";

        return APPURL . $prefix . $url;
    }

}

/**
 * Request token generator
 * @return mixed|string
 */
function token_make()
{
    $token = \system\core\Session::get('token');

    if(empty($token)){
        $token = hash('sha256', uniqid(mt_rand()));
        \system\core\Session::set('token', $token);
    }

    return $token;
}

/**
 * Request token validator
 * @param null $token
 */
function token_validate($token = null)
{
    $request = \system\core\Request::getInstance();

    if(! $token) {
        $token = $request->post('token');
    }

    if($token != TOKEN){

        if($request->isXhr()){
            header('Content-Type: application/json');
            echo json_encode(['error' => '#1201. Invalid token.']);
            die;
        }

        die('#1201. Invalid token.');
    }
}

/**
 * Simple redirect tool
 * @param $uri
 * @param int $status_code
 */
function redirect($uri, $status_code = null)
{
    if(strpos($uri, 'http') === false){
        $uri = APPURL . $uri;
    }

    header('Location: ' . $uri, true, $status_code);

    die;
}

if( ! function_exists('url')){

    function url($url)
    {
        $url = trim($url, '/');
        $lang = \system\core\Languages::getInstance();

        $prefix = $lang->is_main ? "" : "$lang->code/";

        return APPURL . $prefix . $url;
    }

}
