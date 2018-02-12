<?php

namespace system\backend;

class Breadcrumbs
{
    private static $items = [];
    public static $default = true; //allow create default breadcrumb for module

    final public static function add($name, $url = null)
    {
        self::$items[] = ['name' => $name, 'url' => $url];
    }

    final public static function get()
    {
        return self::$items;
    }

    public final static function prepend($name, $url)
    {
        array_unshift(self::$items, ['name' => $name, 'url' => $url]);
    }

    public final static function customDefault($name, $url = null)
    {
        self::$default = false;
        self::add($name, $url);
    }
}