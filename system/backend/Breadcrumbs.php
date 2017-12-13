<?php

namespace system\backend;

class Breadcrumbs
{
    private static $items = [];

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
}