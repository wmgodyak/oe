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
        if($key){

            if(strpos($key, '.') !== false){

                $data = null;

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
                } else if($c == 4){
                    if(isset($this->data[$parts[0]][$parts[1]][$parts[2]][$parts[3]])){
                        $data = $this->data[$parts[0]][$parts[1]][$parts[2]][$parts[3]];
                    }
                } else if($c == 5){
                    if(isset($this->data[$parts[0]][$parts[1]][$parts[2]][$parts[3]][$parts[4]])){
                        $data = $this->data[$parts[0]][$parts[1]][$parts[2]][$parts[3]][$parts[4]];
                    }
                }

                return $data;
            }

            return isset($this->data[$key]) ? $this->data[$key] : null;
        }

        return $this->data;
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
        if(is_array($value) || is_object($value)) $value = serialize($value);

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