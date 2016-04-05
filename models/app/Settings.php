<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.03.16 : 11:37
 */

namespace models\app;

use controllers\core\exceptions\Exception;
use models\core\DB;

defined("CPATH") or die();

class Settings
{
    private static $instance;
    private $data = [];

    private function __construct()
    {
        $r = DB::getInstance()->select("select name, value from settings")->all();
        foreach ($r as $item) {
            $this->data[$item['name']] = $item['value'];
        }
    }

    private function __clone(){}

    /**
     * @return Settings
     */
    public static function getInstance(){
        if(self::$instance == null){
            self::$instance = new Settings();
        }

        return self::$instance;
    }

    public function get($key)
    {
        if(!isset($this->data[$key])) {
            throw new Exception("$key not found on settings");
        }

        return $this->data[$key];
    }
}