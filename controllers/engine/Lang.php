<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 16:58
 */

namespace controllers\engine;

use controllers\core\Config;

class Lang
{
    private static $instance;

    private $langs = array();

    private $translations;
    private $dir;

    private function __construct()
    {
        $this->dir = DOCROOT . 'themes/engine/lang/';

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

        $this->setTranslations();
    }

    private function setTranslations()
    {
        $lang = Config::getInstance()->get('core.lang');
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

    public function t($key = null)
    {
        if($key){

            $data = '';

            if(strpos($key,'.')){

                $parts = explode('.', $key);
                $c = count($parts);

                if($c == 1){
                    if(isset($this->translations[$parts[0]])){
                        $data = $this->translations[$parts[0]];
                    }
                }else if($c == 2){
                    if(isset($this->translations[$parts[0]][$parts[1]])){
                        $data = $this->translations[$parts[0]][$parts[1]];
                    }
                }else if($c == 3){
                    if(isset($this->translations[$parts[0]][$parts[1]][$parts[2]])){
                        $data = $this->translations[$parts[0]][$parts[1]][$parts[2]];
                    }
                }

                return $data;
            }
        }

        return $key ? $this->translations[$key] : $this->translations;
    }

    private function __clone(){}

    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new Lang();
        }

        return self::$instance;
    }

    public function getLangs()
    {
        return $this->langs;
    }
}