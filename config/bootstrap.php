<?php
    /**
     * OYiEngine 7
     * @author    Volodymyr Hodiak mailto:support@otakoi.com
     * @copyright Copyright (c) 2015 Otakoyi.com
     * Date: 18.12.15 : 11:50
     */

    if ( !defined('CPATH') ) die();

    if(!defined('MPATH')) define('MPATH', 'models\\');

    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ? "https://" : "http://";

    if(!defined('APPURL')) define('APPURL', $protocol . "{$_SERVER['HTTP_HOST']}/");

    if (!ini_get('zlib.output_compression') && function_exists('ob_gzhandler')) ob_start('ob_gzhandler');

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
//            throw new Exception("Try to load className: <b>{$className}</b> on line 32. Error, file: {$fileName} not found");
        }

        require $fileName;
    }

    spl_autoload_register('autoLoad');

    // init session
    \controllers\core\Session::init();

     if(!defined('TOKEN')) define('TOKEN', md5(\controllers\core\Session::id()));

    /**
     * PHP as CGI
     */
    if (get_magic_quotes_gpc()) {
        function clearGpc($array)
        {
            return is_array($array) ? array_map('clearGpc', $array) : stripslashes($array);
        }

        $_COOKIE = clearGpc($_COOKIE);
        $_FILES = clearGpc($_FILES);
        $_GET = clearGpc($_GET);
        $_POST = clearGpc($_POST);
        $_REQUEST = clearGpc($_REQUEST);
    }
