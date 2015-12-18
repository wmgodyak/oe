<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 02.05.14
 * Time: 16:25
 */

namespace controllers\core;

defined('CPATH') or die();

class Settings {
    
    private static $_instance;
    private static $_data;
    private static $ms;

    public function __construct()
    {
        self::$ms = new \models\Settings();
    }

    /**
     * @return Settings
     */
    public static function instance(){
        if(self::$_instance == null){
            self::$_instance = new Settings();
            self::load();
        }

        return self::$_instance;
    }

    /**
     *
     */
    private static function load(){
        $r= self::$ms->load();
        foreach($r as $row){
            self::$_data[$row['name']] = $row['value'];
        }
    }

    /**
     * change setting value by key
     * @param $n
     * @param $v
     * @return mixed
     */
    public function set($n, $v)
    {
        self::$_data[$n] = $v;
        return self::$ms->set($n, $v);
    }

    /**
     * @param null $key
     * @return mixed
     */
    public function get($key=null)
    {
        return $key ? self::$_data[$key] : self::$_data;
    }
    /**
     * @param null $key
     * @return mixed
     */
    public function del($key)
    {
        return self::$ms->delete($key);
    }

    /**
     * @param $key
     * @param $val
     * @return mixed
     */
    public function __set($key,$val)
    {

        if(isset(self::$_data[$key])){
            self::$_data[$key] = $val;
        }

        return self::$_instance;
    }


} 