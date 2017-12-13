<?php

namespace system\backend;

class Menu
{
    private static $items = [];

    final public static function add($name, $url, $icon = null, $parent = null, $position = 0)
    {
        while(isset(self::$items[$position])){
            $position += 5;
        }

        self::$items[$position] = [
            'name'     => $name,
            'url'      => $url,
            'icon'     => $icon,
            'parent'   => $parent,
            'isfolder' => 0
        ];
    }

    final public static function get()
    {
        $nav = []; $ws_parents = [];
        foreach (self::$items as $k=>$item) {
            if($item['parent'] != null){
                $ws_parents[] = $item;
                continue;
            }

            $nav[$k] = $item;
        }

        foreach ($ws_parents as $item) {
            foreach ($nav as $k=>$n) {
                if($n['url'] == $item['parent']){
                    $nav[$k]['isfolder'] = 1;
                    $nav[$k]['items'][] = $item;
                }
            }
        }

        ksort($nav);

        return $nav;
    }

    public final static function prepend($name, $url, $icon = null, $parent = null)
    {
        array_unshift
        (
            self::$items,
            [
                'name'     => $name,
                'url'      => $url,
                'icon'     => $icon,
                'parent'   => $parent,
                'isfolder' => 0
            ]
        );
    }
}