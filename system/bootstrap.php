<?php
    /**
     * OYiEngine 7
     * @author    Volodymyr Hodiak mailto:support@otakoi.com
     * @copyright Copyright (c) 2015 Otakoyi.com
     * Date: 18.12.15 : 11:50
     */
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

    // On Windows IIS
    if (!isset($_SERVER['DOCUMENT_ROOT'])) {
        if (isset($_SERVER['SCRIPT_FILENAME'])) {
            $_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr($_SERVER['SCRIPT_FILENAME'], 0, 0 - strlen($_SERVER['PHP_SELF'])));
        }
    }

    if (!isset($_SERVER['DOCUMENT_ROOT'])) {
        if (isset($_SERVER['PATH_TRANSLATED'])) {
            $_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr(str_replace('\\\\', '\\', $_SERVER['PATH_TRANSLATED']), 0, 0 - strlen($_SERVER['PHP_SELF'])));
        }
    }

    if (!isset($_SERVER['REQUEST_URI'])) {
        $_SERVER['REQUEST_URI'] = substr($_SERVER['PHP_SELF'], 1);

        if (isset($_SERVER['QUERY_STRING'])) {
            $_SERVER['REQUEST_URI'] .= '?' . $_SERVER['QUERY_STRING'];
        }
    }


    if (!isset($_SERVER['HTTP_HOST'])) {
        $_SERVER['HTTP_HOST'] = getenv('HTTP_HOST');
    }

    if ((isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) || (isset($_SERVER['HTTPS']) && (isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == 443))) {
        $_SERVER['HTTPS'] = true;
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' || !empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on') {
        $_SERVER['HTTPS'] = true;
    } else {
        $_SERVER['HTTPS'] = false;
    }

    if(!defined('DOCROOT')) define('DOCROOT', str_replace("\\", "/", $_SERVER['DOCUMENT_ROOT'] . '/'));

    if(!defined('CPATH')) define('CPATH', 1);

    if (!ini_get('date.timezone')) {
        date_default_timezone_set('UTC');
    }

    if ($handle = opendir(DOCROOT . 'helpers/functions/')) {
        while (false !== ($entry = readdir($handle))) {
            if ($entry != "." && $entry != "..") {
                include_once DOCROOT . 'helpers/functions/' . $entry;
            }
        }
        closedir($handle);
    }

    $protocol = $_SERVER['HTTPS'] ? "https://" : "http://";

    if(!defined('APP')) define('APP', "{$_SERVER['SERVER_NAME']}");
    if(!defined('APPURL')) define('APPURL', $protocol . APP . '/');

    spl_autoload_register('autoLoad');

    require DOCROOT . "vendor/autoload.php";

    // init session
    system\core\Session::start();

    if(!defined('TOKEN')) define('TOKEN', token_make());

    $config = \system\core\Config::getInstance();

    if($config->get('db') == null){
        $installer = new \system\components\install\controllers\Install();
        $installer->index();
        die;
    }

    switch ($config->get('core.environment')){
        case 'development':
        case 'debugging':
            break;
        default:
            ini_set('display_errors', 0);
            ini_set('display_startup_errors', 0);
            error_reporting(0);
            break;
    }

    \system\models\Modules::getInstance();

    events()->call('boot');

    $res = \system\core\Route::getInstance()->run();

    \system\core\Response::getInstance()->body($res)->display();