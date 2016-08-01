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
}