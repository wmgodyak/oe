<?php

namespace system\models;

use system\core\DB;

defined('CPATH') or die();

/**
 * Class Settings
 * @package system\models
 */
class Settings
{
    private static $instance;
    private $data;

    private function __construct()
    {
        $this->reload();
    }

    private function __clone(){}

    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param null $key
     * @return mixed
     */
    public function get($key=null)
    {
        if(!$key)
            return $this->data;

        if($key && !isset($this->data[$key])) {
            return null;
        }

        return $this->data[$key];
    }

    /**
     * @param $name
     * @param $value
     * @param null $block
     * @param null $type
     * @throws \system\core\exceptions\Exception
     */
    public function set($name, $value, $block=null, $type=null)
    {
        if(is_array($value)) $value = serialize($value);

        $a = DB::getInstance()->select("select id from __settings where name = '{$name}' limit 1")->row('id');

        if($a > 0){
            $this->update($name, $value);
        } else {
            $this->create($name, $value, $block, $type);
        }

        if(! DB::getInstance()->hasError()){
            $this->reload();
        }
    }

    /**
     * @param $name
     * @param $value
     * @param $block
     * @param $type
     * @return bool|string
     */
    private function create($name, $value, $block, $type)
    {
        return DB::getInstance()->insert
            (
                '__settings',
                [
                    'name'  => $name,
                    'value' => $value,
                    'block' => $block ? $block : 'common',
                    'type'  => $type ? $type : 'text'
                ]
            );
    }

    /**
     * @param $name
     * @param $value
     * @return bool
     * @throws \system\core\exceptions\Exception
     */
    private function update($name, $value)
    {
        return DB::getInstance()->update("__settings", ['value' => $value], " name = '{$name}' limit 1");
    }

    private function reload()
    {
        $r = DB::getInstance()->select("select name, value from __settings order by id asc")->all();

        foreach ($r as $row) {

            if(isSerialized($row['value'])) $row['value'] = unserialize($row['value']);

            $this->data[$row['name']] = $row['value'];
        }
    }

} 