<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 11:07
 */

namespace system\core;

defined("CPATH") or die();

class WidgetsFactory
{
    private static $widgets = [];

    public static function register($widget)
    {
        self::$widgets[(string)$widget] = $widget;
    }

    public static function get($widget_id = null)
    {
        if(! $widget_id)
            return self::$widgets;

        if(!self::$widgets[$widget_id])
            return null;

            return self::$widgets[$widget_id];
    }
}