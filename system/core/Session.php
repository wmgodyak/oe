<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 13:29
 */

namespace system\core;

defined('CPATH') or die();

/**
 * Session class
 *
 * handles the session stuff. creates session when no one exists, sets and
 * gets values, and closes the session properly (=logout). Those methods
 * are STATIC, which means you can call them with Session::get(XXX);
 */
class Session {
    /**
     * starts the session
     */
    public static function start(){
        // if no session exist, start the session
        if (session_id() == '') {
            session_name('oyiengine');
            session_start();
        }
    }

    public static function id()
    {
        return session_id();
    }

    /**
     * sets a specific value to a specific key of the session
     * @param mixed $key
     * @param mixed $value
     */
    public static function set($key, $value=null){
        if(is_array($key)){
            $_SESSION = array_merge($_SESSION, $key);
            return;
        }
        $_SESSION[$key] = $value;
    }

    /**
     * gets/returns the value of a specific key of the session
     * @param mixed $key
     * @return mixed
     */
    public static function get($key){

        if(strpos($key,'.')){

            $parts = explode('.', $key);
            $c = count($parts);

            if($c == 1){
                if(isset($_SESSION[$parts[0]])){
                    return $_SESSION[$parts[0]];
                }
            } else if($c == 2){
                if(isset($_SESSION[$parts[0]][$parts[1]])){
                    return  $_SESSION[$parts[0]][$parts[1]];
                }
            } else if($c == 3){
                if(isset($_SESSION[$parts[0]][$parts[1]][$parts[2]])){
                    return $_SESSION[$parts[0]][$parts[1]][$parts[2]];
                }
            }
        }

        return isset($_SESSION[$key]) ? $_SESSION[$key] : null;
    }

    public static function delete($key)
    {
        if(!isset($_SESSION[$key])) return;

        unset($_SESSION[$key]);
    }

    /**
     * deletes the session
     */
    public static function destroy(){
        session_destroy();
    }
}