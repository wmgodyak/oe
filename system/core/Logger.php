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
     * @param $text
     * @return int
     */
    public static function log($text)
    {
        $text = date('c') . '   ' . $text . "\r\n";

        return file_put_contents(self::$filename , $text, FILE_APPEND);
    }
}