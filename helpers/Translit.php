<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.03.16 : 17:37
 */

namespace helpers;

defined("CPATH") or die();

class Translit
{
    public static function str2url($str)
    {
        $str = mb_strtolower($str, 'utf8');
        $str = strtr
        (
            $str,
            [
            'а' =>'a',
            'б' => 'b',
            'в'=> 'v',
            'г'=> 'g',
            'ґ'=> 'g',
            'д'=> 'd',
            'е'=> 'e',
            'є'=> 'e',
            'ж'=> 'zh',
            'з'=> 'z',
            'и'=> 'y',
            'і'=> 'i',
            'ї'=> 'yi',
            'й'=> 'y',
            'к'=> 'k',
            'л'=> 'l',
            'м'=> 'm',
            'н'=> 'n',
            'о'=> 'o',
            'п'=> 'p',
            'р'=> 'r',
            'с'=> 's',
            'т'=> 't',
            'у'=> 'u',
            'ф'=> 'f',
            'х'=> 'kh',
            'ц'=> 'ts',
            'ч'=> 'ch',
            'ш'=> 'sh',
            'щ'=> 'sch',
            'ь'=> '',
            'ю'=> 'yu',
            'я'=> 'ya',
            'ё'=> 'e',
            'ы'=> 'y',
            'э'=> 'e',
            'ъ'=> '',
            ' '=> '-',
            'ʹ'=> '',
            '/'=> '-',
            ]
        );
        $str = preg_replace('/[^a-z0-9_\-]+/', '', $str);

        $str = trim($str, "-");

        return $str;
    }
}