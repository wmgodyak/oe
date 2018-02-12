<?php
    /**
     * OYiEngine 7
     * @author    Volodymyr Hodiak mailto:support@otakoi.com
     * @copyright Copyright (c) 2015 Otakoyi.com
     * Date: 18.12.15 : 11:50
     */

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

    switch ($config->get('core.environment')){
        case 'development':
        case 'debugging':
            ini_set('display_errors', 1);
            ini_set('display_startup_errors', 1);
            error_reporting(E_ALL);
            break;
        default:
            ini_set('display_errors', 0);
            ini_set('display_startup_errors', 0);
            error_reporting(0);
            break;
    }

    $request = \system\core\Request::getInstance();

    $uri = cleanURI($_SERVER['REQUEST_URI']);
    $url = APPURL . trim(parse_url($uri, PHP_URL_PATH), '/');
    $parsed = parse_url($url);

    if(!isset($parsed['path'])) $parsed['path'] = '/';

    if(!empty($parsed['query'])){
        parse_str($parsed['query'], $a);
        $parsed['args'] = $a;
    }

    foreach ($parsed as $k=>$v) {
        $request->{$k} = $v;
    }

    $request->uri = filter_apply('request.uri', trim($parsed['path'], '/'));

    $request->mode ='frontend';

    if($config->get('db') == null || system\core\Session::get('inst')){
        $installer = new \system\components\install\controllers\Install();
        $installer->index();
        die;
    }

    $route = \system\core\Route::getInstance();
    $route->beforeBoot($request);

    $language = \system\core\Languages::getInstance();
    $language->detect($request);

    \system\models\Modules::getInstance()->boot($request);

    events()->call('boot');

    $route->dispatch($request);

    $theme = 'app_theme_current';

    $l_code = $language->code;

    if($request->mode == 'backend'){

        $theme = 'backend_theme';
        $bl = \system\core\Session::get('backend_lang');
        $l_code = empty($bl) ? $l_code : $bl;

        if
        (
            $request->isPost()
            || $request->isPut()
            || $request->isDelete()
        )
        {
            token_validate();
        }

        $controller = $request->controller;
        $action     = $request->action;
        $controller = lcfirst($controller);

        if(
        (
        ! \system\components\auth\models\Auth::isOnline(\system\components\auth\controllers\Auth::id(), \system\core\Session::id())
        )
        ){
            if( $controller != 'auth' && $action != 'login' ){
                redirect(\system\models\Settings::getInstance()  ->get('backend_url') . "/auth/login");
            }
        }

        \system\models\Permissions::set(\system\components\auth\controllers\Auth::data('permissions'));

        if(
        ( $controller != 'auth' && $action != 'login' )
        ) {
            if( $controller != '\system\components\module\controllers\Module' ){
                if (!\system\models\Permissions::canComponent($controller, $action)) {
                    \system\models\Permissions::denied();
                }
            }
        }

    }

     \system\core\Lang::getInstance()->set($l_code, \system\models\Settings::getInstance()->get($theme));

    if($request->mode == 'backend') {
        \system\core\Components::init();
        \system\models\Modules::getInstance()->boot($request);
    }

    $res = $route->run();

    \system\core\Response::getInstance()
        ->withHeader('X-CSRF-Token: ' . TOKEN)
        ->withHeader('X-Accept-Language: ' . $language->code)
        ->body($res)
        ->display($request);