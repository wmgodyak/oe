<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 11:59
 */


namespace helpers;

defined("CPATH") or die();

/**
 * Class PHPDocReader
 * @package helpers
 */
class PHPDocReader
{
    public static function getMeta($cls)
    {
        $meta = array();
        $rc = new \ReflectionClass($cls);
        $dc = $rc->getDocComment();

        if(preg_match('#^/\*\*(.*)\*/#s', $dc, $comment) === false){
            $meta['name'] = 'Невірно внесено DocComment';
            return $meta;
        }

        if(empty($comment)) return $meta;

        $comment = trim($comment[1]);
        if(preg_match_all('#^\s*\*(.*)#m', $comment, $lines) === false){
            $meta['name'] = 'Невірно внесено DocComment';
            return $meta;
        }

        foreach ($lines[1] as $line) {
            $line = trim($line);

            if(empty($line)) continue;

            if(strpos($line, '@') === 0) {
                $param = substr($line, 1, strpos($line, ' ') - 1); //Get the parameter name
                $value = substr($line, strlen($param) + 2); //Get the value
                $meta[$param] = $value;
            }
        }

        return $meta;
    }
}