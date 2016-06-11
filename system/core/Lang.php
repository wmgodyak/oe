<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 16:58
 */

namespace system\core;

use controllers\core\Config;

/**
 * Class Lang
 * @package system\core
 */
class Lang
{
    private static $instance;

    private $langs = array();

    private $translations;
    private $dir;

    /**
     * Lang constructor.
     * @param $theme
     * @param $lang
     */
    private function __construct($theme, $lang)
    {
        $this->dir = DOCROOT . "themes/$theme/lang/";

        if ($handle = opendir($this->dir)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".."){

                    $fn = $this->dir. $entry . '/core.ini';

                    if(!file_exists($fn)) continue;

                    $a = parse_ini_file($fn, true);

                    $this->langs[] = $a['lang'];
                }
            }
            closedir($handle);
        }

        $this->setTranslations($lang);
    }

    private function __clone(){}

    /**
     * @param null $theme
     * @param null $lang
     * @return Lang
     */
    public static function getInstance($theme = null, $lang = null)
    {
        if(self::$instance == null){
            self::$instance = new Lang($theme, $lang);
        }

        return self::$instance;
    }

    /**
     * @return array
     */
    public function getLangs()
    {
        return $this->langs;
    }

    /**
     * @param $lang
     */
    private function setTranslations($lang)
    {
        if ($handle = opendir($this->dir . $lang. '/')) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".."){

                    $fn = $this->dir . $lang .'/' . $entry;

                    if(!file_exists($fn)) continue;

                    $a = parse_ini_file($fn, true);

                    foreach ($a as $k=>$v) {
                        $this->translations[$k] = $v;
                    }
                }
            }
            closedir($handle);
        }
    }

    /**
     * @param null $key
     * @return null
     */
    public function t($key = null)
    {
        if($key){

            if(strpos($key,'.')){

                $data = $key;

                $parts = explode('.', $key);
                $c = count($parts);

                if($c == 1){
                    if(isset($this->translations[$parts[0]])){
                        $data = $this->translations[$parts[0]];
                    }
                } else if($c == 2){
                    if(isset($this->translations[$parts[0]][$parts[1]])){
                        $data = $this->translations[$parts[0]][$parts[1]];
                    }
                } else if($c == 3){
                    if(isset($this->translations[$parts[0]][$parts[1]][$parts[2]])){
                        $data = $this->translations[$parts[0]][$parts[1]][$parts[2]];
                    }
                }

                return $data;
            }
        }

        return $key && isset($this->translations[$key])? $this->translations[$key] : $this->translations;
    }
}