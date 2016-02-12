<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace models;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class Engine
 * @package models
 */
class Engine extends Model
{
    /**
     * @return array
     */
    public function nav()
    {
        $res = [];
        foreach ($this->items(0) as $item) {

            if($item['isfolder']) $item['children'] = $this->items($item['id']);
            $res[] = $item;
        }
        return $res;
    }

    /**
     * @param $parent_id
     * @return mixed
     */
    private function items($parent_id)
    {
        return self::$db
            ->select("
                    select id, icon, isfolder, controller, rang
                    from components
                    where parent_id={$parent_id}
                    order by abs(position) asc
                ")
            ->all();
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
    protected function updateRow($table, $id, $data)
    {
        return self::$db->update($table, $data, "id={$id} limit 1");
    }

    /**
     * @param $table
     * @param $id
     * @return int
     */
    protected function deleteRow($table, $id)
    {
        return self::$db->delete($table, "id={$id} limit 1");
    }
}