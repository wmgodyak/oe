<?php
    /**
     * OYiEngine
     *
     * Швидка і проста CMF для вирішення будь-яких завдань
     *
     * @package		OYi.Engine
     * @author		wmgodyak mailto:wmgoyak@gmail.com
     * @copyright	Copyright (c) 2015 Otakoyi.com
     * @license		http://otakoyi.com
     * @link		http://egine.otakoyi.com
     * @since		Version 7.0
     */

    if (version_compare(phpversion(), '5.5.0', '<') == true) {
        exit('PHP5.5+ Required');
    }

    include_once "system/bootstrap.php";