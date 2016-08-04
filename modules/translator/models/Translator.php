<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.08.16 : 18:29
 */

namespace modules\translator\models;

use system\models\Model;

defined("CPATH") or die();

class Translator extends Model
{
    /**
     * витягує список таблиць з суфіксом info
     * @return array|mixed
     */
    public function getInfoTables()
    {
        $res = [];
        $r = self::$db->select("SHOW TABLES LIKE '%_info'")->all();
        foreach ($r as $row) {
            foreach ($row as $n=>$table) {
                $res[] = $table;
            }
        }
        return $res;
    }

    /**
     * витягує список коонок таблиці з детальною інформацією про них
     * @param $table
     * @return array|mixed
     */
    public function describe($table)
    {
        return self::$db->select("DESCRIBE {$table}")->all();
    }

    /**
     * @param $table
     * @param $languages_id
     * @return array|mixed
     */
    public function getTotalTableRecords($table, $languages_id)
    {
        return self::$db->select("select count(*) as t from {$table} where languages_id = {$languages_id}")->row('t');
    }

    public function getTableRow($table, $languages_id, $start)
    {
        return self::$db->select("select * from {$table} where languages_id = {$languages_id} order by id asc limit {$start}, 1 ")->row();
    }

    public function insertTranslatedData($table, $iv, $debug=0)
    {
        return self::$db->insert($table, $iv,$debug);
    }
}