<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 17.10.16 : 12:22
 */

defined("CPATH") or die();
if(! function_exists('shortText')) {

    /**
     * @param $text
     * @param int $len
     * @param string $dots
     * @return string
     */
    function shortText($text, $len = 60, $dots = " ...")
    {
        $c = mb_strlen($text);

        if ($c <= $len) return $text;

        return mb_substr($text, 0, $len, 'UTF-8') . $dots;
    }
}

if(! function_exists('isSerialized')) {
    /**
     * @param $data
     * @param bool $strict
     * @return bool
     */
    function isSerialized($data, $strict = true)
    {
        // if it isn't a string, it isn't serialized.
        if (!is_string($data)) {
            return false;
        }
        $data = trim($data);
        if ('N;' == $data) {
            return true;
        }
        if (strlen($data) < 4) {
            return false;
        }
        if (':' !== $data[1]) {
            return false;
        }
        if ($strict) {
            $lastc = substr($data, -1);
            if (';' !== $lastc && '}' !== $lastc) {
                return false;
            }
        } else {
            $semicolon = strpos($data, ';');
            $brace = strpos($data, '}');
            // Either ; or } must exist.
            if (false === $semicolon && false === $brace)
                return false;
            // But neither must be in the first X characters.
            if (false !== $semicolon && $semicolon < 3)
                return false;
            if (false !== $brace && $brace < 4)
                return false;
        }
        $token = $data[0];
        switch ($token) {
            case 's' :
                if ($strict) {
                    if ('"' !== substr($data, -2, 1)) {
                        return false;
                    }
                } elseif (false === strpos($data, '"')) {
                    return false;
                }
            // or else fall through
            case 'a' :
            case 'O' :
                return (bool)preg_match("/^{$token}:[0-9]+:/s", $data);
            case 'b' :
            case 'i' :
            case 'd' :
                $end = $strict ? '$' : '';
                return (bool)preg_match("/^{$token}:[0-9.E-]+;$end/", $data);
        }
        return false;
    }
}
/**
 * @param int $length
 * @param bool $only_uppercase
 * @param bool $numbers
 * @return string
 */
function random_string($length = 10, $only_uppercase = false, $numbers = true ) {

    $c = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    if(! $only_uppercase) $c .= 'abcdefghijklmnopqrstuvwxyz';

    if($numbers) $c .= '0123456789';

    $l = strlen($c);

    $s = '';

    for ($i = 0; $i < $length; $i++) {
        $s .= $c[rand(0, $l - 1)];
    }

    return $s;
}

if(! function_exists('mb_strcasecmp')) {
    function mb_strcasecmp($str1, $str2, $encoding = null) {
        if (null === $encoding) { $encoding = mb_internal_encoding(); }
        return strcasecmp(mb_strtoupper($str1, $encoding), mb_strtoupper($str2, $encoding));
    }
}