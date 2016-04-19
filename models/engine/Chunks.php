<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 16:42
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class Chunks
 * @package models\engine
 */
class Chunks extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        return self::$db->select("select {$key} from __chunks where id={$id} limit 1")->row($key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        return parent::createRow('chunks', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        return parent::updateRow('chunks', $id, $data);
    }

    public function delete($id)
    {
        $s = parent::deleteRow('chunks', $id);
        return $s;
    }

    public function issetTemplate($name, $id = null)
    {
        return self::$db->select("
            select id
            from __chunks
            where name='{$name}' ". ($id ? " and id <> $id" : '') ." limit 1")
            ->row('id');
    }

}