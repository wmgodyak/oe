<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 20.05.14 23:35
 */

namespace controllers\core;

use controllers\engine\Auth;

defined('CPATH') or die();

class Output {

    private static $load;
    private static $request;

    /**
     * @param $time
     */
    public static function render($time){

        self::$load = Load::instance();
        self::$request = Request::instance();

        $debug = Config::instance()->get('debug');

        switch(self::$request->mode){
            case 'engine':
                    if(self::$request->isXhr()){
                        echo self::$request->body;
                    } else {
                        echo self::$load->view('index',array(
                            'title'          => self::$request->title,
                            'description'    => self::$request->description,
                            'body'           => self::$request->body,
                            'nav'            => self::$request->nav,
                            'js_file'        => self::getJs(),
                            'body_class'     => self::$request->controller == 'Dashboard' ?
                                                              'dashboard-page' : self::$request->controller
                        ));
                    }
                break;
            case 'app':

                if(self::$request->isXhr()){
                    echo self::$request->body;
                } else {
                    echo self::$request->content('body');
                }

                break;
            case 'install':
                echo self::$request->body;
                break;
            default:
                break;
        }

        $db = DB::instance();
        if($debug && ! self::$request->isXhr()){
            $q = $db->queryCount();

            echo "\r\n<!--\r\n";
            $time_end = microtime(true);
            $exec_time = round($time_end-$time, 4);
            $mu = memory_get_usage();
            $mp = 0; $mpf=0;
            if(function_exists('memory_get_peak_usage')){
                $mp = memory_get_peak_usage();
                $mpf = round(($mp / 1024) / 1024, 3);
            }
            $muf = round((memory_get_usage() / 1024) / 1024, 3);
            $ml=ini_get('memory_limit');

            if($mp > 0){
                echo "    Memory peak in use: $mp ($mpf M)\r\n";
            }

            echo "    Page generation time: ".$exec_time." seconds\r\n";
            echo "    Memory in use: $mu ($muf M) \r\n";
            echo "    Memory limit: $ml \r\n";
            echo "    Total queries: $q \r\n";
            echo  "-->";
        }

        $db->close();
    }

    private static function getJs()
    {
        $out = array();
        $path  = Settings::instance()->get('themes_path');
        $path .= Settings::instance()->get('engine_theme_current') .'/scripts/bootstrap/';
        if ($handle = opendir( DOCROOT . '/' . $path )){
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != "..") {
                    $file_path = $path . $file;
                    if(is_readable(DOCROOT . '/' .  $file_path )){
                        $out[] = APPURL . $file_path;
                    } else {
                        throw new \Exception("Не можу завантажити файл {$path}");
                    }
                }
            }
            closedir($handle);
        }
        return $out;
    }
} 