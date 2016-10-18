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
     * @param $key
     * @param $value
     * @return mixed|null
     */
    public static function apply($key, $value)
    {
        if(!isset(self::$filters[$key])) return $value;

        foreach (self::$filters[$key] as $callback) {

            if(is_array($callback) && isset($callback[1])){ // class :: method
                if(is_callable($callback, true)){
                    if(is_array($value)){
                        $value = call_user_func_array($callback, [$value]);
                    } else{
                        $value = call_user_func($callback, $value);
                    }
                }
                continue;
            }

            if(is_callable($callback, true, $callable_name)){ // some function

                if(is_array($value)){
                    $value = call_user_func_array($callback, [$value]);
                } else{
                    $value = call_user_func($callback, $value);
                }
                continue;
            }
        }

        return $value;
    }

    /**
     * @param $key
     * @param $callback
     * @param int $priority
     */
    public static function add($key, $callback, $priority = 10)
    {
        while(isset(self::$filters[$key][$priority])){
            $priority += 5;
        }

        self::$filters[$key][$priority] = $callback;
    }
}