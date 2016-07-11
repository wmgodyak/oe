<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.03.16 : 17:27
 */

namespace helpers;

defined("CPATH") or die();

class Pagination
{
    private static $prev;
    private static $next;
    private static $all;

    private static $pages = [];

    public static function init( $total, $ipp, $cur_p,  $url, $mid_range = 7)
    {
        $g = $_GET; if(isset($g['p'])) unset($g['p']);

        foreach ($g as $k=>$v) {
            if(empty($v)) unset($g[$k]);
        }

        $qs = empty($g) ? '' : '&' . http_build_query($g);

        $last = ceil($total / $ipp);

        $start = (($cur_p - $ipp) > 0) ? $cur_p - $ipp : 1;
        $end = (($cur_p + $ipp) < $last) ? $cur_p + $ipp : $last;

        $class = ($cur_p == 1) ? "disabled" : "";
        self::addPage("$url?p=" . ($cur_p - 1) . "&ipp={$ipp}{$qs}", '&laquo;', $class);

        if ($start > 1) {
            self::addPage("$url?p=1{$qs}", 1);
            self::addPage(null, "...", 'disabled');
        }
        for ($i = $start, $c=0; $i <= $end && $c < $mid_range; $i++, $c++) {
            $class = ($cur_p == $i) ? "active" : "";
            self::addPage("$url?p=$i{$qs}", $i, $class);
        }

        if ($end < $last) {
            self::addPage(null, '...', 'disabled');
            self::addPage("$url?p=$last{$qs}", $last);
        }

        $class = ($cur_p == $last) ? "disabled" : "";
        self::addPage("$url?p=" . ($cur_p + 1) . $qs, '&raquo;', $class );
    }
    /**
     * @param $url
     * @param $name
     * @param null $class
     */
    private static function addPage($url, $name, $class = null)
    {
        self::$pages[] = [ 'url'   => $url, 'name'  =>$name, 'class' => $class ];
    }

    public static function getPages()
    {
        return [
            'pages' => self::$pages, 
            'prev'  => self::$prev, 
            'next'  => self::$next, 
            'all'   => self::$all 
        ];
    }
}