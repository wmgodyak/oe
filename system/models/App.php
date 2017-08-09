<?php

namespace system\models;

use system\core\exceptions\Exception;

class App
{
    private static $instance;

    const NS = 'system\models\\';
    const EXT = '.php';
    private static $storage = [];

    public $module;

    private $allowed = ['nav', 'languages', 'images', 'guides', 'contentMeta', 'cache', 'page', 'pagination', 'usersMeta'];


    private function __construct(){}
    private function __clone(){}


    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param $model
     * @return mixed
     * @throws Exception
     */
    public function __get($model)
    {
        if(isset(self::$storage[$model])){
            return self::$storage[$model];
        }

        if(!in_array($model, $this->allowed)){
            throw new Exception("Model $model not allowed.");
        }

        $c  = self::NS . ucfirst($model);

        $path = str_replace("\\", "/", $c);

        if(!file_exists(DOCROOT . $path . self::EXT)) {
            throw new Exception("Model $model issue.");
        }

        include_once(DOCROOT . $path . self::EXT);

        // cache him
        self::$storage[$model] = new $c();

        return self::$storage[$model];
    }

    /**
     * @param $module
     * @return bool
     */
    public function issetModule($module)
    {
        $module = lcfirst($module);
        return isset($this->module->{$module});
    }
}