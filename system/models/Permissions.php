<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 11.06.16
 * Time: 23:49
 */

namespace system\models;

defined("CPATH") or die();

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