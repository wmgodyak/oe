<?php
    /**
     * OYiEngine 7
     * @author    Volodymyr Hodiak mailto:support@otakoi.com
     * @copyright Copyright (c) 2015 Otakoyi.com
     * Date: 18.12.15 : 11:50
     */

    if ( !defined('CPATH') ) die();

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
        if (!file_exists($fileName)) {
            return;
    //      throw new Exception("Try to load className: <b>{$className}</b> on line 32. Error, file: {$fileName} not found");
        }

        require $fileName;
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

    function d($var)
    {
        echo '<pre>'; print_r($var); echo '</pre>';
    }

    if(!defined('MPATH')) define('MPATH', 'models\\');

    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ? "https://" : "http://";

    if(!defined('APP')) define('APP', "{$_SERVER['HTTP_HOST']}");
    if(!defined('APPURL')) define('APPURL', $protocol . APP . '/');

    if (!ini_get('zlib.output_compression') && function_exists('ob_gzhandler')) ob_start('ob_gzhandler');

    spl_autoload_register('autoLoad');

    // init session
    system\core\Session::init();

    if(!defined('TOKEN')) define('TOKEN', md5(\system\core\Session::id()));

    // custom error handler
//    $config = \system\core\Config::getInstance();
//    if($config['core.debug']){
//
//    }

    function on_error($num, $str, $file, $line) {
        print "Encountered error $num in $file, line $line: $str\n";
    }

    set_error_handler("on_error");

    // events
    include_once "events.php";