<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 10:08
 */

namespace models\app;

use controllers\core\exceptions\Exception;
use models\core\DB;

defined("CPATH") or die();

/**
 * Class Translations
 * @package models\app
 */
class Translations
{
    private $languages_id = null;
    private static $instance;
    private static $data = [];

    private function __construct($languages_id)
    {
        if($languages_id){
            $this->languages_id = $languages_id;
        }

        $this->setData();
    }

    private function __clone(){}

    /**
     * @param null $languages_id
     * @return Translations
     */
    public static function getInstance($languages_id=null){
        if(self::$instance == null){
            self::$instance = new Translations($languages_id);
        }

        return self::$instance;
    }

    /**
     * @param null $key
     * @return array|string
     */
    public function get($key = null)
    {
        if(! $key) return self::$data;

        if(isset(self::$data[$key])) return self::$data[$key];

        return "t.{$key}";
    }

    private function setData()
    {
        if(! $this->languages_id){
            throw new Exception("Languages_id cannot be null");
        }
        $r = DB::getInstance()
            ->select(
                "select t.code, i.value
                 from translations t
                 join translations_info i on i.translations_id=t.id and i.languages_id='{$this->languages_id}'
                "
            )
            ->all();
        foreach ($r as $item) {
            self::$data[$item['code']] = $item['value'];
        }
    }
}