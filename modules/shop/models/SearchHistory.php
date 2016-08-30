<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 12.07.16 : 15:18
 */

namespace modules\shop\models;

use system\models\Front;

defined("CPATH") or die();

/**
 * Class SearchHistory
 * @package modules\shop\models
 */
class SearchHistory extends Front
{
    /**
     * @param $q
     * @throws \system\core\exceptions\Exception
     */
    public function add($q)
    {
        $id = self::$db->select("select id from __search_history where q='{$q}' limit 1")->row('id');
        if(empty($id)){
            $id = $this->createRow('__search_history', ['q' => $q]);
        }

        $this->addToStat($id);
    }

    /**
     * @param $search_history_id
     * @throws \system\core\exceptions\Exception
     */
    private function addToStat($search_history_id)
    {
        $d = date('Y-m-d');

        $r = self::$db
            -> select("
                select id, hits
                from __search_history_stat
                where search_history_id = {$search_history_id} and `date`= '{$d}' limit 1")
            -> row();

        if(empty($r['id'])){
            $this->createRow
            (
                '__search_history_stat',
                ['search_history_id' => $search_history_id, 'date'=> $d, 'hits' => 1 ]
            );
        } else {
            $this->updateRow('__search_history_stat', $r['id'], ['hits' => ++ $r['hits']]);
        }
    }
}