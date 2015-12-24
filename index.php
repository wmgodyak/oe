<?php
    /**
     * OYiEngine 7
     *
     * Швидка і потужна CMF для вирішення будь-яких завдань
     *
     * @package		OYi.Engine
     * @author		wmgodyak mailto:wmgoyak@gmail.com
     * @copyright	Copyright (c) 2015 Otakoyi.com
     * @license		http://Otakoyi.com
     * @link		http://Egine.Otakoyi.com
     * @since		Version 7.0
     */

    if (version_compare(phpversion(), '5.3.0', '<') == true) { die ('PHP 5.3+ Only'); }

    $time_start = microtime(true);

    if(!defined('DOCROOT')) define('DOCROOT', str_replace("\\", "/", $_SERVER['DOCUMENT_ROOT'] . '/'));
    if(!defined('CPATH')) define('CPATH', DOCROOT . 'controllers/');

    // load startup file
    include_once "config/bootstrap.php";

    // Routing
    \controllers\core\Route::run();

    \controllers\core\Response::instance()->render();
