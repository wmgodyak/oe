<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 16:58
 */

namespace system\core;
use system\core\exceptions\Exception;
use system\models\Settings;

/**
 * Class Lang
 * @package system\core
 */
class Lang
{
    private static $instance;

    private $langs = [];

    private $translations = [];
    private $lang;

    /**
     * Lang constructor.
     */
    private function __construct(){}

    private function __clone(){}

    /**
     * @return Lang
     */
    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param $theme
     * @param $lang
     */
    public function set($theme, $lang)
    {
        $this->lang = $lang;

        $this->setTranslations($theme, $lang);
    }

    public function getAllowedLanguages()
    {
        return Config::getInstance()->get('langs');
    }

    /**
     * @param $theme
     * @return array
     */
    public function getLangs($theme)
    {
        $allowed = $this->getAllowedLanguages();

        $dir = "themes/$theme/lang/";

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
     * @param $theme
     * @param $lang
     */
    public function setTranslations($theme, $lang)
    {
        $dir  = "themes/$theme/lang/";

        if(!is_dir(DOCROOT . $dir )) {
            return;
        }

        if(empty($lang)) $lang = 'en';

        $fn = DOCROOT . $dir . '/' . $lang .'.json';
        if(! file_exists($fn)) $lang = 'en';

        $fn = DOCROOT . $dir . '/' . $lang .'.json';
        if(! file_exists($fn)) return ;

        $a = file_get_contents($fn, true);
        $a = json_decode($a, true);

        $this->translations = array_merge($this->translations, $a);


        $this->readModules($lang);
    }

    /**
     * @param $lang
     */
    private function readModules($lang)
    {
        $mode = Request::getInstance()->getMode();

        $active = Settings::getInstance()->get('modules');
        if(empty($active)){
            return;
        }

        foreach ($active as $module=>$params) {

            if($params['status'] != 'enabled') continue;

            $module = lcfirst($module);

            if($mode == 'backend'){

                // replace module path
                $t_path = DOCROOT . "modules/{$module}/lang/backend/$lang.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$module}/lang/backend/en.json";
                }
            } else {
                $t_path = DOCROOT . "modules/{$module}/lang/$lang.json";
                if(!file_exists($t_path)){
                    $t_path = DOCROOT . "modules/{$module}/lang/en.json";
                }
            }


            if(!file_exists($t_path)){
                continue;
            }

            // load translations
            $this->parseFile($t_path, $module);
        }

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