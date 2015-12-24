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
        self::$ms = new \models\core\Settings();
    }

    /**
     * @return Settings
     */
    public static function getInstance(){
        if(self::$_instance == null){
            self::$_instance = new Settings();
            self::refresh();
        }

        return self::$_instance;
    }

    /**
     *
     */
    private static function refresh(){
        $r= self::$ms->get();
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
     * @param $n
     * @param $v
     * @param $t
     * @param $d
     * @return int
     */
    public function add($n, $v, $t, $d='')
    {
        if(self::$ms->create($n, $v, $t, $d)){
            $this->refresh();
            return 1;
        }
        return 0;
    }

} 