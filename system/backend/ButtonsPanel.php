<?php

namespace system\backend;

class ButtonsPanel
{
    private static $items = [];

    final public static function add($button)
    {
        self::$items[] = $button;
    }

    final public static function get()
    {
        return self::$items;
    }

    public final static function prepend($button)
    {
        array_unshift(self::$items, $button);
    }
}