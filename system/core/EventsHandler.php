<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 14:05
 */

namespace system\core;

/**
 * Class Event
 * @description EventHandler
 * To add event just add this code in init() your in module Event::getInstance()->add('content.main.info', [$this, 'mainInfoBottom']);
 * To run event in template just call {$events->call('content.main.info')}
 * To run event in module just call Event::getInstance()->call('content.main.info')
 * Also you can run events()->call();
 * It`s simply!!!
 * @package system\core
 */
class EventsHandler
{
    /**
     * @var
     */
    private static $instance;

    /**
     * events
     * @var array
     */
    private static $events = [];

    private $debug;

    private function __construct(){}

    private function __clone(){}


    public static function getInstance()
    {
        if(!self::$instance instanceof self){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param $action
     * @param $callback
     * @param int $priority
     */
    public function add($action, $callback, $priority = 10)
    {
       while(isset(self::$events[$action][$priority])){
           $priority += 5;
       }
       if($this->debug)  echo "<code>Events::add  ". time() . $action . "</code><br>";
       self::$events[$action][$priority] = $callback;
    }

    /**
     * @param $action
     * @param array $params
     * @param bool $display
     * @return null|string
     */
    public function call($action, $params = [], $display = true)
    {
        if($this->debug) echo "<code>Events::call  ". time() . $action . "</code><br>";

        if(!isset(self::$events[$action])) {
            if($this->debug) echo "No callbacks for event {$action}<br>";
            return null;
        }

        $out = [];

        ksort(self::$events[$action]);

        foreach (self::$events[$action] as  $callback) {

            if(is_array($callback) && isset($callback[1])){
                if(is_callable($callback, true, $callable_name)){
                    if($this->debug)  echo 'Called: ', $callable_name, '<br>';
                    if($params && is_array($params)){
                        $out[] = call_user_func_array($callback, [$params]);
                    } else {
                        $out[] = call_user_func($callback, $params);
                    }
                }
            }  elseif (is_callable($callback, true) && !is_string($callback)){
                $out[] = call_user_func_array($callback, $params);
            }
        }

        if($display) {
            echo implode('', $out);
        } else {
            return implode('', $out);
        }
    }

    /**
     * @param int $status
     */
    public function debug($status = 1)
    {
        $this->debug = $status;
    }

    /**
     * display all events
     */
    public function display()
    {
        dd(self::$events);
    }

    public function getEvents()
    {
        return self::$events;
    }

    public function getEventCallbacks($action)
    {
        if(!isset(self::$events[$action])) return null;

        return self::$events[$action];
    }
}