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
        $str = mb_strtolower($str);

        $str = strtr($str,
            "абвгдежзийклмнопрстуфыэ",
            "abvgdegziyklmnoprstufie"
        );

        $str = strtr($str, array(
            'ё'=>"yo",    'х'=>"h",  'ц'=>"ts",  'ч'=>"ch", 'ш'=>"sh",
            'щ'=>"shch",  'ъ'=>'',   'ь'=>'',    'ю'=>"yu", 'я'=>"ya",
            'і'=>"i"
        ));

        $str = preg_replace('/[^a-z0-9_\-]+/', '', $str);

        $str = trim($str, "-");

        return $str;
    }
}