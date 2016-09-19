<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 11.06.16
 * Time: 23:49
 */

namespace system\models;

use system\core\Request;
use system\core\Response;

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
//        d($permissions);die;
        self::$permissions = $permissions;
    }

    /**
     * @param $controller
     * @param $action
     * @param string $type
     * @return bool
     */
    public static function check($controller, $action, $type = 'components')
    {
        if(self::$permissions['full_access']) return true;

        if(!isset(self::$permissions[$type][$controller])) return false;

        if(in_array($action, self::$permissions[$type][$controller])) return true;

        return false;
    }

    public static function canComponent($controller, $action)
    {
        return self::check($controller, $action, 'components');
    }

    public static function canModule($controller, $action)
    {
        return self::check($controller, $action, 'modules');
    }

    public static function denied()
    {
        Response::getInstance()->sendError(401);
        if(Request::getInstance()->isXhr()){
            die;
        }

        d(Request::getInstance());die;
    }

}