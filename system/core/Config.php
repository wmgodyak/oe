<?php

namespace system\core;

defined('CPATH') or die();

/**
 * Class Config
 * @package system\core
 */
class Config
{
    private static $instance;
    private static $data;

    private function __construct()
    {
        $dir = DOCROOT . 'config/';

        if ($handle = opendir($dir)) {
            while (false !== ($f = readdir($handle))) {
                if ($f != '.' && $f != '..' ){
                    $ext = pathinfo($f, PATHINFO_EXTENSION);
                    if($ext != 'php') continue;

                    $k = str_replace('.php', '', $f);
                    self::$data[$k] = include_once($dir . $f);
                }
            }
            closedir($handle);
        }
    }

    private function __clone(){}

    /**
     * @return Config
     */
    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new Config();
        }

        return self::$instance;
    }

    /**
     * @param null $key
     * @return array|mixed|null
     */
    public function get($key=null)
    {
        if($key == null) return self::$data;

        return dots_get(self::$data, $key);
    }

    /**
     * @param $key
     * @param $val
     * @return mixed
     */
    public function set($key, $val)
    {
        self::$data = dots_set(self::$data, $key, $val);

        return self::$instance;
    }
} 