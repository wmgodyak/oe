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

    protected static $db;

    public function __construct()
    {
        self::$db = DB::instance();
    }

    public function getErrorCode()
    {
        return self::$db->getErrorCode();
    }

    public function getErrorMessage()
    {
        return self::$db->getErrorMessage();
    }

    public function hasError()
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
} 