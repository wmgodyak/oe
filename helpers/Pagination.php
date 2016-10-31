<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.03.16 : 17:27
 */

namespace helpers;

defined("CPATH") or die();

/**
 * Class Pagination
 * @package helpers
 */
class Pagination
{
    private static $prev;
    private static $next;
    private static $all;
    private static $ipp;
    private static $p;

    private static $pages = [];

    public static function init( $total, $ipp, $cur_p,  $url, $mid_range = 7)
    {
        self::$ipp = (int)$ipp;
        self::$p   = (int)$cur_p;

        $g = $_GET;

        if(isset($g['p'])) unset($g['p']);

        foreach ($g as $k=>$v) {
            if(empty($v)) unset($g[$k]);
        }

        $qs = empty($g) ? '' : '&' . http_build_query($g);

        $last = ceil($total / $ipp);

        $start = (($cur_p - $ipp) > 0) ? $cur_p - $ipp : 1;
        $end = (($cur_p + $ipp) < $last) ? $cur_p + $ipp : $last;

        $p = $cur_p - 1;
        $class = ($cur_p == 1) ? "disabled" : "";
        $p = ($p > 1) ? "?p=$p&ipp={$ipp}" : "";

        self::$prev = [ 'url'   => "{$url}{$p}{$qs}", 'name'  =>'&laquo;', 'class' => $class ];

//        if ($start > 1 && $end > 1) {
//            self::addPage("{$url}{$qs}", 1);
////                self::addPage(null, "...", 'disabled');
//        }

        for ($i = $start, $c=0; $i <= $end && $c < $mid_range; $i++, $c++) {
            $class = ($cur_p == $i) ? "active" : "";

            $p = ($i > 1) ? "?p=$i&ipp={$ipp}" : "";
            self::addPage("{$url}{$p}{$qs}", $i, $class);
        }

        if ($end < $last) {
//            self::addPage(null, '...', 'disabled');
            self::addPage("$url?p={$last}{$qs}", $last);
        }

//        self::addPage("$url?p=" . ($cur_p + 1) . $qs, '&raquo;', $class );
//        self::addPage(, '&raquo;', $class );
        if($cur_p > 1){
            $class = ($cur_p == $last) ? "disabled" : "";
            self::$next = [ 'url'   => "$url?p=" . ($cur_p + 1) . $qs, 'name'  =>'&raquo;', 'class' => $class ];
        }
    }

    public static function getLimit()
    {
        $start = self::$p;
        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * self::$ipp;
        }

        return [$start, self::$ipp];
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