<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 31.03.16 : 9:37
 */

namespace system\core;

defined("CPATH") or die();

class Logger
{
    const EMERGENCY = 'emergency';
    const ALERT     = 'alert';
    const CRITICAL  = 'critical';
    const ERROR     = 'error';
    const WARNING   = 'warning';
    const NOTICE    = 'notice';
    const INFO      = 'info';
    const DEBUG     = 'debug';

    private static $root = 'logs/';
    private static $filename;

    /**
     * @param $dir
     * @param $filename
     * @param string $ext
     */
    public static function init($dir, $filename = '', $ext = 'log')
    {
        $path = self::$root . $dir . '/';

        if(!is_dir(DOCROOT . $path)) mkdir(DOCROOT . $path, 0777, true);

        if(!empty($filename)) {
            $filename = preg_replace('/[^\w_]+/u', '', $filename);
            $filename .= '-';
        }

        self::$filename = DOCROOT . $path . $filename . date('Y-m-d') . '.' . $ext;
    }

    /**
     * @param $level
     * @param $message
     * @param array $context
     * @return int
     */
    private static function write($level, $message, array $context)
    {
        $message = self::interpolate($message, $context);
        $level = empty($level) ? '' : "    [$level]";
        $text = date('c') . "$level    $message\r\n";

        return file_put_contents(self::$filename , $text, FILE_APPEND);
    }

    /**
     * System is unusable.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function emergency($message, array $context = array())
    {
        self::write(self::EMERGENCY, $message, $context);
    }

    /**
     * Action must be taken immediately.
     *
     * Example: Entire website down, database unavailable, etc. This should
     * trigger the SMS alerts and wake you up.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function alert($message, array $context = array())
    {
        self::write(self::ALERT, $message, $context);
    }

    /**
     * Critical conditions.
     *
     * Example: Application component unavailable, unexpected exception.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function critical($message, array $context = array())
    {
        self::write(self::CRITICAL, $message, $context);
    }

    /**
     * Runtime errors that do not require immediate action but should typically
     * be logged and monitored.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function error($message, array $context = array())
    {
        self::write(self::ERROR, $message, $context);
    }

    /**
     * Exceptional occurrences that are not errors.
     *
     * Example: Use of deprecated APIs, poor use of an API, undesirable things
     * that are not necessarily wrong.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function warning($message, array $context = array())
    {
        self::write(self::WARNING, $message, $context);
    }

    /**
     * Normal but significant events.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function notice($message, array $context = array())
    {
        self::write(self::NOTICE, $message, $context);
    }

    /**
     * Interesting events.
     *
     * Example: User logs in, SQL logs.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function info($message, array $context = array())
    {
        self::write(self::INFO, $message, $context);
    }

    /**
     * Detailed debug information.
     *
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function debug($message, array $context = array())
    {
        self::write(self::DEBUG, $message, $context);
    }

    /**
     * Logs with an arbitrary level.
     *
     * @param mixed $level
     * @param string $message
     * @param array $context
     * @return null
     */
    public static function log($message, array $context = array())
    {
        self::write('', $message, $context);
    }

    /**
     * Interpolates context values into the message placeholders.
     */
    private static function interpolate($message, array $context = array())
    {
        // build a replacement array with braces around the context keys
        $replace = array();
        foreach ($context as $key => $val) {
            $replace['{' . $key . '}'] = $val;
        }

        // interpolate replacement values into the message and return
        return strtr($message, $replace);
    }
}