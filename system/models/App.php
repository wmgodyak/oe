<?php

namespace system\models;

use system\core\exceptions\Exception;

class App
{
    const NS = 'system\models\\';
    const EXT = '.php';
    private static $storage = [];

    private $allowed = ['nav', 'languages'];
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
}