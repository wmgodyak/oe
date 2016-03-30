<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 10:08
 */

namespace models\app;

use controllers\core\exceptions\Exception;
use controllers\core\Settings;
use models\core\DB;

defined("CPATH") or die();

/**
 * Class Lang
 * @package models\app
 */
class Lang
{
    private $code = null;
    private static $instance;
    private $data = [];
    private $lang_file;

    private function __construct($code)
    {
        if($code){
            $this->code = $code;
        }

        $this->lang_file = Settings::getInstance()->get('themes_path') .
                           Settings::getInstance()->get('app_theme_current') . '/'.
                           'lang/' .
                           $code . '.ini';
        
        $this->setData();
    }

    private function __clone(){}

    /**
     * @param null $code
     * @return Lang
     */
    public static function getInstance($code=null){
        if(self::$instance == null){
            self::$instance = new Lang($code);
        }

        return self::$instance;
    }

    /**
     * @param null $key
     * @return array|string
     */
    public function get($key = null)
    {
        if($key){

            if(strpos($key,'.')){

                $data = $key;

                $parts = explode('.', $key);
                $c = count($parts);

                if($c == 1){
                    if(isset($this->data[$parts[0]])){
                        $data = $this->data[$parts[0]];
                    }
                } else if($c == 2){
                    if(isset($this->data[$parts[0]][$parts[1]])){
                        $data = $this->data[$parts[0]][$parts[1]];
                    }
                } else if($c == 3){
                    if(isset($this->data[$parts[0]][$parts[1]][$parts[2]])){
                        $data = $this->data[$parts[0]][$parts[1]][$parts[2]];
                    }
                }

                return $data;
            }
        }

        return $key && isset($this->data[$key])? $this->data[$key] : $this->data;
    }

    private function setData()
    {
        if(! $this->code){
            throw new Exception("Languages code cannot be null");
        }

        if(!file_exists($this->lang_file)) {
            throw new Exception("Languages file not exists");
        }

        $a = parse_ini_file($this->lang_file, true);

        foreach ($a as $k=>$v) {
            $this->data[$k] = $v;
        }
    }
}