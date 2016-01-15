<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 14:43
 */

namespace helpers\bootstrap;

defined("CPATH") or die();

/**
 * Class Button
 * @package helpers\bootstrap
 */
class Button extends ButtonBuilder
{
    public static function create($text, array $args, $icon = false)
    {
        $class = __CLASS__;
        return new $class($text,  $args, $icon);
    }

}