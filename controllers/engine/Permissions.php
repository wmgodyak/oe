<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 12:12
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;

defined("CPATH") or die();

/**
 * Class Permissions
 * @package controllers\engine
 */
class Permissions
{
    /**
     * @var
     */
    private static $permissions;

    /**
     * @param $permissions
     */
    public static function set($permissions)
    {
        self::$permissions = $permissions;
    }

    /**
     * @param $controller
     * @param $action
     * @return bool
     */
    public static function check($controller, $action)
    {
        if(self::$permissions['full_access']) return true;

        if(!isset(self::$permissions[$controller])) return false;

        if(in_array($action, self::$permissions[$controller])) return true;

        return false;
    }
}