<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 16:58
 */

namespace system\core;
use system\core\exceptions\Exception;

/**
 * Class Lang
 * @package system\core
 */
class Lang
{
    private static $instance;

    private $langs = array();

    private $translations = [];
    private $dir;
    private $lang = null;

    /**
     * Lang constructor.
     * @param $theme
     * @param $lang
     */
    private function __construct($theme, $lang)
    {
        $this->dir  = "themes/$theme/lang/";
        $this->lang = $lang;
//        echo "Lang::construct $theme $lang";
        $this->setTranslations();
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
            self::$instance = new self($theme, $lang);
        }

        return self::$instance;
    }

    public function getAllowedLanguages()
    {
        return Config::getInstance()->get('langs');
    }

    /**
     * @param null $theme
     * @return array
     */
    public function getLangs($theme = null)
    {
        $dir = $this->dir;
        $allowed = $this->getAllowedLanguages();

        if($theme){
            $dir = "themes/$theme/lang/";
        }

        if ($handle = opendir($dir)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".."){

                    $entry = mb_strtolower($entry);
                    $entry = str_replace('.json','', $entry);

                    if( !isset($allowed[$entry])) continue;

                    $this->langs[$entry] = $allowed[$entry];
                }
            }
            closedir($handle);
        }

        return $this->langs;
    }

    public function getLang()
    {
        return $this->lang;
    }

    /**
     * @param null $dir
     * @throws Exception
     */
    public function setTranslations($dir = null)
    {
        $dir = !$dir ? $this->dir : $dir;

        if(!is_dir(DOCROOT . $dir )) {
            return;
        }

        if(empty($this->lang)) $this->lang = 'en';

        $fn = DOCROOT . $dir . '/' . $this->lang .'.json';
        if(! file_exists($fn)) $this->lang = 'en';

        $fn = DOCROOT . $dir . '/' . $this->lang .'.json';
        if(! file_exists($fn)) return ;

        $a = file_get_contents($fn, true);
        $a = json_decode($a, true);

        $this->translations = array_merge($this->translations, $a);
    }

    /**
     * @param $key
     * @param $translations
     */
    public function addTranslations($key, $translations)
    {
        $this->translations[$key] = $translations;
    }

    public function parseFile($path, $parent = null)
    {
        $a = file_get_contents($path);
        $a = json_decode($a, true);
        if($parent){
            $this->translations[$parent] = $a;
        } else {
            $this->translations = array_merge($this->translations, $a);
        }
    }

    /**
     * @param null $key
     * @return null
     */
    public function get($key = null)
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
                } else if($c == 4){
                    if(isset($this->translations[$parts[0]][$parts[1]][$parts[2]][$parts[3]])){
                        $data = $this->translations[$parts[0]][$parts[1]][$parts[2]][$parts[3]];
                    }
                } else if($c == 5){
                    if(isset($this->translations[$parts[0]][$parts[1]][$parts[2]][$parts[3]][$parts[4]])){
                        $data = $this->translations[$parts[0]][$parts[1]][$parts[2]][$parts[3]][$parts[4]];
                    }
                }
                return $data;
            }

            return isset($this->translations[$key])? $this->translations[$key] : $key;
        }


        return $this->translations;
    }
}