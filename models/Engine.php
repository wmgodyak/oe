<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace models;

use controllers\core\Session;
use models\core\Model;
use models\engine\Languages;

defined("CPATH") or die();

/**
 * Class Engine
 * @package models
 */
class Engine extends Model
{
    protected $admin;
    protected $languages;

    public function __construct()
    {
        parent::__construct();

        $this->admin = Session::get('engine.admin');

        $l = new Languages();
        $this->languages    = $l->get();
        $this->languages_id = $l->getDefault('id');
        self::$language_id  = $this->languages_id;
    }

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
}