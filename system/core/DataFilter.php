<?php

namespace system\core;
/**
 * Class DataFilter
 * @package system\core
 */
class DataFilter
{
    /**
     * @var array
     */
    private static $filters = [];

    /**
     * @param $param
     * @param $value
     * @return mixed|null
     */
    public static function apply($param, $value)
    {
        if(!isset(self::$filters[$param])) return $value;

        foreach (self::$filters[$param] as $callback) {
            if(is_array($callback) && isset($callback[1])){
                if(is_callable($callback, true, $callable_name)){
                    $value = call_user_func_array($callback, is_array($value) ? [$value] : $value);
                }
            } elseif(is_callable($callback, true, $callable_name)){
                $value = call_user_func_array($callback, is_array($value) ? [$value] : $value);
            }
        }

        return $value;
    }

    /**
     * @param $param
     * @param $callback
     * @param int $priority
     */
    public static function add($param, $callback, $priority = 10)
    {
        while(isset(self::$filters[$param][$priority])){
            $priority += 5;
        }

        self::$filters[$param][$priority] = $callback;
    }
}