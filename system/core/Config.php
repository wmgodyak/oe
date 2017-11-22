<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 02.05.14
 * Time: 16:25
 */

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

                    $k = str_replace(array('.php'), array(), $f);
                    self::$data[$k] = include($dir . $f);
                }
            }
            closedir($handle);
        }
    }

    private function __clone()
    {

    }

    /**
     * @return Config
     */
    public static function getInstance(){
        if(self::$instance == null){
            self::$instance = new Config();
        }

        return self::$instance;
    }

    /**
     * @param null $key
     * @return array
     */
    public function get($key=null)
    {
        dd($key);
        if($key){

            $data = '';

            if(strpos($key,'.')){

                $parts = explode('.', $key);
                $c = count($parts);

                if($c == 1){
                    if(isset(self::$data[$parts[0]])){
                        $data = self::$data[$parts[0]];
                    }
                }else if($c == 2){
                    if(isset(self::$data[$parts[0]][$parts[1]])){
                        $data = self::$data[$parts[0]][$parts[1]];
                    }
                }else if($c == 3){
                    if(isset(self::$data[$parts[0]][$parts[1]][$parts[2]])){
                        $data = self::$data[$parts[0]][$parts[1]][$parts[2]];
                    }
                }

                return $data;
            }
        }

        return $key ? isset(self::$data[$key]) ? self::$data[$key] : null : self::$data;
    }

    /**
     * @param $key
     * @param $val
     * @return mixed
     */
    public function set($key,$val){
        if(strpos($key,'.')){

            $parts = explode('.', $key);
            $c = count($parts);

            if($c == 1){
                if(isset(self::$data[$parts[0]])){
                    self::$data[$parts[0]] = $val;
                }
            }else if($c == 2){
                if(isset(self::$data[$parts[0]][$parts[1]])){
                    self::$data[$parts[0]][$parts[1]] = $val;
                }
            }else if($c == 3){
                if(isset(self::$data[$parts[0]][$parts[1]][$parts[2]])){
                    self::$data[$parts[0]][$parts[1]][$parts[2]] = $val;
                }
            }

            return self::$instance;
        }

        if(isset(self::$data[$key])){
            self::$data[$key] = $val;
        }

        return self::$instance;
    }
} 