<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:vh@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 31.03.16 : 9:37
 */

namespace system\core;

defined("CPATH") or die();

/**
 * Class Log
 * @package system\core
 */
class Log
{
    const EMERGENCY = 'emergency';
    const ALERT     = 'alert';
    const CRITICAL  = 'critical';
    const ERROR     = 'error';
    const WARNING   = 'warning';
    const NOTICE    = 'notice';
    const INFO      = 'info';
    const DEBUG     = 'debug';

    private $root = 'logs/';
    private $filename;

    /**
     * Log constructor.
     * @param string $filename
     * @param string $ext
     */
    public function __construct($filename = '', $ext = 'log')
    {
        $dir = pathinfo($filename, PATHINFO_DIRNAME);
        $path = $this->root . $dir . '/';

        if(!is_dir(DOCROOT . $path)) mkdir(DOCROOT . $path, 0777, true);

        if(!empty($filename)) {
            $filename = preg_replace('/[^\w_]+/u', '', $filename);
            $filename .= '-';
        }

        $this->filename = DOCROOT . $path . $filename . date('Y-m-d') . '.' . $ext;
    }

    /**
     * @param $level
     * @param $message
     * @param array $context
     * @return int
     */
    private function write($level, $message, array $context)
    {
        $message = $this->interpolate($message, $context);
        $level = empty($level) ? '' : "    [$level]";
        $text = date('c') . "$level    $message\r\n";

        return file_put_contents($this->filename , $text, FILE_APPEND);
    }

    /**
     * System is unusable.
     *
     * @param string $message
     * @param array $context
     */
    public function emergency($message, array $context = array())
    {
        $this->write(self::EMERGENCY, $message, $context);
    }

    /**
     * Action must be taken immediately.
     *
     * Example: Entire website down, database unavailable, etc. This should
     * trigger the SMS alerts and wake you up.
     *
     * @param string $message
     * @param array $context
     */
    public function alert($message, array $context = array())
    {
        $this->write(self::ALERT, $message, $context);
    }

    /**
     * Critical conditions.
     *
     * Example: Application component unavailable, unexpected exception.
     *
     * @param string $message
     * @param array $context
     */
    public function critical($message, array $context = array())
    {
        $this->write(self::CRITICAL, $message, $context);
    }

    /**
     * Runtime errors that do not require immediate action but should typically
     * be logged and monitored.
     *
     * @param string $message
     * @param array $context
     */
    public function error($message, array $context = array())
    {
        $this->write(self::ERROR, $message, $context);
    }

    /**
     * Exceptional occurrences that are not errors.
     *
     * Example: Use of deprecated APIs, poor use of an API, undesirable things
     * that are not necessarily wrong.
     *
     * @param string $message
     * @param array $context
     */
    public function warning($message, array $context = array())
    {
        $this->write(self::WARNING, $message, $context);
    }

    /**
     * Normal but significant events.
     *
     * @param string $message
     * @param array $context
     */
    public function notice($message, array $context = array())
    {
        $this->write(self::NOTICE, $message, $context);
    }

    /**
     * Interesting events.
     *
     * Example: User logs in, SQL logs.
     *
     * @param string $message
     * @param array $context
     */
    public function info($message, array $context = array())
    {
        $this->write(self::INFO, $message, $context);
    }

    /**
     * Detailed debug information.
     *
     * @param string $message
     * @param array $context
     */
    public function debug($message, array $context = array())
    {
        $this->write(self::DEBUG, $message, $context);
    }

    /**
     * Logs with an arbitrary level.
     *
     * @param string $message
     * @param array $context
     */
    public function log($message, array $context = array())
    {
        $this->write('', $message, $context);
    }

    /**
     * @param $message
     * @param array $context
     * @return string
     */
    private function interpolate($message, array $context = array())
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