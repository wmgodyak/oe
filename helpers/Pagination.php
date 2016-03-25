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
//    private static $total;
//    private static $ipp;
//    private static $num_pages;
    private static $limit = [];

    private static $prev;
    private static $next;
    private static $all;

    private static $pages = [];

    public static function init($total, $ipp, $cur_p,  $url, $page = 'p', $mid_range = 7)
    {
        if($ipp == "All") {
            $num_pages = 1;
        } else {
            $num_pages = ceil($total/$ipp);
        }

        $qs = !empty($_GET) ? '?' . http_build_query($_GET) : '';
        
        if($num_pages > 1) {
            if($cur_p > 1 ){
                self::$prev = "$url$page=".($cur_p-1)."$qs";
            }

            $start_range = $cur_p - floor($mid_range/2);
            $end_range = $cur_p + floor($mid_range/2);
            if($start_range <= 0) {
                $end_range += abs($start_range)+1;
                $start_range = 1;
            }
            if($end_range > $num_pages) {
                $start_range -= $end_range-$num_pages;
                $end_range = $num_pages;
            }
            $range = range($start_range,$end_range);
            for($i=1;$i<=$num_pages;$i++) {

                if($range[0] > 2 && $i == $range[0]) {
                    self::addPage('', ' ... ', 'disabled');
                }

                if($i==1 Or $i==$num_pages Or in_array($i,$range)) {
                    if($i == $cur_p && $ipp != "All"){
                        self::addPage('', $i, 'active');
                    } else {
                        $u = $i == 1 ? '' : "$page=$i";
                        self::addPage("$url$u$qs", $i);
                    }
                }

                if($range[$mid_range-1] < $num_pages-1 && $i == $range[$mid_range-1]) {
                    self::addPage('', ' ... ', 'disabled');
                }
            }

            if(($cur_p < $num_pages ) && ($ipp != "All") && $cur_p > 0) {
                self::$next = "$url$page=" . ($cur_p+1) ."$qs";
            }
        } else	{
            for($i=1;$i<=$num_pages;$i++) {
                if($i == $cur_p) {
                    self::addPage('', $i, 'active');
                } else if($i > 1) {
                    self::addPage("$url$page=$i$qs", $i);
                }

            }
        }
        
        self::$all = "{$url}ipp=all". str_replace('?', '&', $qs);
        
        self::$limit['start'] = ($cur_p <= 0) ? 0 : ($cur_p-1) * $ipp;
        
        self::$limit['num'] = ($ipp == "All") ? (int) $total : (int) $ipp;
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
    
    public static function getLimit()
    {
        return self::$limit;
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