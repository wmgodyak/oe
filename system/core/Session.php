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
 * Class Session
 * @package system\core
 */
class Session
{
    public static function start()
    {
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
     * @param $key
     * @param $val
     */
    public function set($key, $val)
    {
        dots_set($_SESSION, $key, $val);
    }
    /**
     * gets/returns the value of a specific key of the session
     * @param mixed $key
     * @return mixed
     */
    public static function get($key)
    {
        return dots_get($_SESSION, $key);
    }

    public static function delete($key)
    {
        if(!isset($_SESSION[$key])) return;

        unset($_SESSION[$key]);
    }

    /**
     * deletes the session
     */
    public static function destroy()
    {
        session_destroy();
    }
}