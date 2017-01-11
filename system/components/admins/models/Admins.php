<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 18.06.16
 * Time: 1:26
 */

namespace system\components\admins\models;

use system\models\Users;

class Admins extends Users
{
    public function getGroups($parent_id = 0)
    {
        $res = self::$db
            -> select("
                  select g.id, i.name, g.isfolder
                  from __users_group g, __users_group_info i
                  where g.parent_id={$parent_id} and g.backend = 1 and i.group_id=g.id and i.languages_id = {$this->languages_id}
              ")
            -> all();

        foreach ($res as $k=>$r) {
            if($r['isfolder']){
                $res[$k]['items'] = $this->getGroups($r['id']);
            }
        }

        return $res;
    }
}