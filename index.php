<?php
    /**
     * OYiEngine 7.2
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

    if (version_compare(phpversion(), '5.4.0', '<') == true) { die ('PHP 5.4+ Only'); }

    if(!defined('DOCROOT')) define('DOCROOT', str_replace("\\", "/", $_SERVER['DOCUMENT_ROOT'] . '/'));
    if(!defined('CPATH')) define('CPATH', DOCROOT . 'system/controllers/');

    // load startup file
    include_once "config/bootstrap.php";

    // Routing
    \system\core\Route::getInstance()->run();

    \system\core\Response::getInstance()->render();