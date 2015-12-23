<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 16:58
 */

namespace controllers\engine;

class Localization
{
    private static $instance;

    private $langs = array();

    private function __construct()
    {
        $dir = DOCROOT . '/themes/engine/languages/';
        if ($handle = opendir($dir)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".."){

                    $fn = $dir. $entry . '/core.ini';
                    if(!file_exists($fn)) continue;

                    $a = parse_ini_file($fn, true);
                    $this->langs[] = $a['lang'];
                }
            }
            closedir($handle);
        }
    }
    private function __clone(){}

    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new Localization();
        }

        return self::$instance;
    }

    public function getLangs()
    {
        return $this->langs;
    }
}