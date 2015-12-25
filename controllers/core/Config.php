<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 02.05.14
 * Time: 16:25
 */

namespace controllers\core;

defined('CPATH') or die();

/**
 * Class Config
 * @package system\core
 */
class Config
{
    private static $instance;
    private static $data;

    public function __construct()
    {
        $dir = DOCROOT . 'config/';

        if ($handle = opendir($dir)) {
            while (false !== ($f = readdir($handle))) {
                if ($f != '.' && $f != '..' && $f != 'bootstrap.php'){

                    $ext = pathinfo($f, PATHINFO_EXTENSION);
                    if($ext != 'php') continue;

                    $k = str_replace(array('.php'), array(), $f);
                    self::$data[$k] = include($dir . $f);
                }

                
            }
            closedir($handle);
        }

//        echo '<pre>';print_r(self::$data);die('<< CONFIG');

        if(!isset(self::$data['db'])){
            header('Location: /install'); die();   
        }
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
    public function get($key=null){

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

        return $key ? self::$data[$key] : self::$data;
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