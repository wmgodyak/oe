<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 13:29
 */

namespace controllers\core;

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
    public static function init(){
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
    public static function set($key, $value){
        $_SESSION[$key] = $value;
    }

    /**
     * gets/returns the value of a specific key of the session
     * @param mixed $key
     * @return mixed
     */
    public static function get($key){
        $parsed = explode('.', $key);
        $result = $_SESSION;
        while ($parsed) {
            $next = array_shift($parsed);
            if (isset($result[$next])) {
                $result = $result[$next];
            } else {
                return null;
            }
        }
        return $result;
    }

    /**
     * deletes the session
     */
    public static function destroy(){
        session_destroy();
    }
}