<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 17:23
 */

namespace helpers\bootstrap;

defined("CPATH") or die();

/**
 * Class Link
 * @package helpers\bootstrap
 */
class Link extends ButtonBuilder
{
    public static function create($text, $args, $icon = false)
    {
        $class = __CLASS__;

        if(is_string($args)){
            $href = $args;
            $args = [];
            $args['href']  = $href;
            $args['class'] = self::TYPE_LINK;
        }

        if(!isset($args['class'])){
            $args['class'] = self::TYPE_LINK;
        }

        return new $class($text,  $args, $icon, 'link');
    }

}