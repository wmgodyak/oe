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
        return $key ? $this->data[$key] : $this->data;
    }

    /**
     * @param $name
     * @param $value
     * @param null $title
     * @param null $description
     * @return bool|string
     * @throws \system\core\exceptions\Exception
     */
    public function set($name, $value, $title = null, $description = null)
    {
        if(is_array($value)) $value = serialize($value);

        $a = DB::getInstance()->select("select id from __settings where name = '{$name}' limit 1")->row('id');

        if($a > 0){
            $this->update($name, $value);
        } else {
            $this->create($name, $value, $title, $description);
        }

        if(! DB::getInstance()->hasError()){
            $this->reload();
        }
    }

    /**
     * @param $name
     * @param $value
     * @param $title
     * @param $description
     * @return bool|string
     */
    private function create($name, $value, $title, $description)
    {
        return DB::getInstance()->insert
            (
                '__settings',
                [
                    'name'        => $name,
                    'value'       => $value,
                    'title'       => $title,
                    'description' => $description
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

            if($this->isSerialized($row['value'])) $row['value'] = unserialize($row['value']);

            $this->data[$row['name']] = $row['value'];
        }
    }

    /**
     * @param $data
     * @param bool $strict
     * @return bool
     */
    private function isSerialized( $data, $strict = true ) {
        // if it isn't a string, it isn't serialized.
        if ( ! is_string( $data ) ) {
            return false;
        }
        $data = trim( $data );
        if ( 'N;' == $data ) {
            return true;
        }
        if ( strlen( $data ) < 4 ) {
            return false;
        }
        if ( ':' !== $data[1] ) {
            return false;
        }
        if ( $strict ) {
            $lastc = substr( $data, -1 );
            if ( ';' !== $lastc && '}' !== $lastc ) {
                return false;
            }
        } else {
            $semicolon = strpos( $data, ';' );
            $brace     = strpos( $data, '}' );
            // Either ; or } must exist.
            if ( false === $semicolon && false === $brace )
                return false;
            // But neither must be in the first X characters.
            if ( false !== $semicolon && $semicolon < 3 )
                return false;
            if ( false !== $brace && $brace < 4 )
                return false;
        }
        $token = $data[0];
        switch ( $token ) {
            case 's' :
                if ( $strict ) {
                    if ( '"' !== substr( $data, -2, 1 ) ) {
                        return false;
                    }
                } elseif ( false === strpos( $data, '"' ) ) {
                    return false;
                }
            // or else fall through
            case 'a' :
            case 'O' :
                return (bool) preg_match( "/^{$token}:[0-9]+:/s", $data );
            case 'b' :
            case 'i' :
            case 'd' :
                $end = $strict ? '$' : '';
                return (bool) preg_match( "/^{$token}:[0-9.E-]+;$end/", $data );
        }
        return false;
    }
} 