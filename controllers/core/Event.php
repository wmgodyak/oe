<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 14:05
 */

namespace controllers\core;

/**
 * Class Event
 * Events like
 * on
 * before
 * @package controllers\core
 */
class Event
{
    private static $events = array();

    private function __construct(){}

    private function __clone(){}

    /**
     * @param $event string example auth.login, user.*
     * @param $callback
     * @param int $priority
     */
    public static function listen($event, $callback, $priority = 10)
    {
        foreach (self::$events as $e) {
            if($e['event'] == $event) return;
        }

        self::$events[] = array(
            'event'    => $event,
            'callback' => $callback,
            'priority' => $priority
        );
    }

    public static function get()
    {
        return self::$events;
    }

    /**
     * @param $controller
     * @param $action
     * @param array $args
     * @return bool
     */
    public static function fire($controller, $action, $args = array())
    {
//        echo $controller, '::', $action, "\r\n";

        foreach (self::$events as $event) {
            if($event['event'] != $controller . '::' . $action) continue;

            $a = explode('::', $event['callback']);
            $_controller = $a[0]; $_action = isset($a[1]) ? $a[1] : 'index';

            $c = new $_controller;
            if(!is_callable(array($c, $_action))) return true;

            if(!empty($args)){
                call_user_func_array(array($c, $_action), $args);
            } else{
                call_user_func(array($c, $_action));
            }
        }
    }

    public static function flush($controller, $action, $args = array())
    {
        if(empty(self::$events)) return true;

        $s = $controller  . '.' . $action;

        foreach (self::$events as $event) {
            if($event['event'] != $s) continue;

            $a = explode('.', $event['event']);

            if(isset($a[1])) self::fire($a[0], $a[1], $args);
        }
    }
}