<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 26.06.16
 * Time: 10:10
 */

namespace system\core;

class WidgetsAreas
{
    private static $areas;

    public static function register($id, $name, $description = null)
    {
        self::$areas[$id] = ['name' => $name, 'description' => $description];
    }

    public static function get()
    {
        return self::$areas;
    }
}