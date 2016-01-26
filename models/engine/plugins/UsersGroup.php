<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */


namespace models\engine\plugins;

use models\core\Model;

defined("CPATH") or die();

class UsersGroup extends Model
{
    public function getItems($parent_id, $rang = 101)
    {
        $parent_id = (int) $parent_id;

        return self::$db->select("
          select g.id, g.isfolder, i.name
          from users_group g
          join users_group_info i on i.group_id=g.id and i.languages_id = {$this->languages_id}
          where g.parent_id={$parent_id} and g.rang >= {$rang}
          ")->all();
    }
}