<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 22.04.15 23:46
 */

namespace models\core;

defined("CPATH") or die();

/**
 * Class Model
 * @package models
 */
class Model {
    /**
     * default languages id
     * @var int
     */
    protected static $language_id = 1;
    /**
     * default languages id not static only
     * @var int
     */
    protected $languages_id = 1;

    protected static $db;

    protected $error = [];

    public function __construct()
    {
        self::$db = DB::getInstance();
    }

    public function setError($msg)
    {
        $this->error[] = $msg;
    }

    public function getDBError()
    {
        return $this->error;
    }

    public function getDBErrorCode()
    {
        return self::$db->getErrorCode();
    }

    public function getDBErrorMessage()
    {
        return self::$db->getErrorMessage();
    }

    public function hasDBError()
    {
        return self::$db->hasError();
    }

    /**
     * @return bool
     */
    public function beginTransaction()
    {
        return self::$db->beginTransaction();
    }

    /**
     * @return bool
     */
    public function commit()
    {
        return self::$db->commit();
    }

    /**
     * @return bool
     */
    public function rollback()
    {
        return self::$db->rollback();
    }

    /**
     * return current timestamp
     * @return bool|string
     */
    protected function now()
    {
        return date('Y-m-d H:i:s');
    }
} 