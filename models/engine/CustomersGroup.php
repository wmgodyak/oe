<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 06.04.16 : 17:13
 */

namespace models\engine;

use models\core\Model;

defined("CPATH") or die();

class CustomersGroup extends Model
{
    public function get($parent_id = 0)
    {
        $items = self::$db
            ->select("
                select ug.id, ugi.name, ug.isfolder
                from __users_group ug
                join __users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}
                where ug.parent_id={$parent_id} and ug.backend=0
                ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->get($item['id']);
            }
        }

        return $items;
    }
}