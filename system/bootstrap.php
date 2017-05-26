<?php
    /**
     * OYiEngine 7
     * @author    Volodymyr Hodiak mailto:support@otakoi.com
     * @copyright Copyright (c) 2015 Otakoyi.com
     * Date: 18.12.15 : 11:50
     */

    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    if ($handle = opendir(DOCROOT . 'helpers/functions/')) {
        while (false !== ($entry = readdir($handle))) {
            if ($entry != "." && $entry != "..") {
                include_once DOCROOT . 'helpers/functions/' . $entry;
            }
        }
        closedir($handle);
    }


    // todo move it to request
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ? "https://" : "http://";

    if(!defined('APP')) define('APP', "{$_SERVER['HTTP_HOST']}");
    if(!defined('APPURL')) define('APPURL', $protocol . APP . '/');

    if (!ini_get('zlib.output_compression') && function_exists('ob_gzhandler')) ob_start('ob_gzhandler');

    spl_autoload_register('autoLoad');

    require DOCROOT . "vendor/autoload.php";
    include_once DOCROOT . "config/routes.php";

    // init session
    system\core\Session::init();

    if(!defined('TOKEN')) define('TOKEN', md5(\system\core\Session::id()));

    $config = \system\core\Config::getInstance();
    if($config->get('db') == null){
        $installer = new \system\components\install\controllers\Install();
        $installer->index();
        die;
    }

    \system\models\Modules::getInstance();

//    events()->debug();
    events()->call('boot');