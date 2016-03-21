<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 22.04.15 23:46
 */

namespace models\core;

use controllers\core\Request;

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
    protected $languages_id = 0;

    protected static $db;

    protected $error = [];

    protected $request;

    public function __construct()
    {
        self::$db = DB::getInstance();

        $this->request = Request::getInstance();
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
        return !empty($this->error) || self::$db->hasError();
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


    /**
     * @param $table
     * @param $data
     * @param int $debug
     * @return bool|string
     */
    protected function createRow($table, $data, $debug = 0)
    {
        return self::$db->insert($table, $data, $debug);
    }

    /**
     * @param $table
     * @param $id
     * @param $data
     * @return bool
     */
    protected function updateRow($table, $id, $data, $debug = 0)
    {
        return self::$db->update($table, $data, "id={$id} limit 1", $debug);
    }

    /**
     * @param $table
     * @param $id
     * @param int $debug
     * @return int
     */
    protected function deleteRow($table, $id, $debug = 0)
    {
        return self::$db->delete($table, "id={$id} limit 1", $debug);
    }

    /**
     * @param $table
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    protected function rowData($table, $id, $key = '*')
    {
        return self::$db->select("select {$key} from {$table} where id={$id} limit 1")->row($key);
    }
} 