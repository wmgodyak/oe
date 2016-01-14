<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 12.01.16 : 11:59
 */

namespace models\engine;

use models\core\Model;

/**
 * Class Components
 * @package models\engine
 */
class Component extends Model
{
    private $id;

    public function __construct($id)
    {
        parent::__construct();

        $this->id = $id;
    }

    public static function create($id)
    {
        $class = __CLASS__;
        return new $class($id);
    }

    /**
     * @param string $key
     * @return array|mixed
     */
    public function data($key = '*')
    {
        return self::$db->select("select {$key} from components where id = '{$this->id}' limit 1")->row($key);
    }

    /**
     * @return bool
     */
    public function pub()
    {
        return self::$db->update('components', ['published' => 1], "id = '{$this->id}' limit 1");
    }

    /**
     * @return bool
     */
    public function hide()
    {
        return self::$db->update('components', ['published' => 1], "id = '{$this->id}' limit 1");
    }

    /**
     * @param $data
     * @return bool
     */
    public function update($data)
    {
        return self::$db->update('components', $data, "id = '{$this->id}' limit 1");
    }
}