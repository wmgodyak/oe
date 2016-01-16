<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.01.16 : 10:10
 */


namespace models\engine;


defined("CPATH") or die();

/**
 * Class Admins
 * @package models\engine
 */
class Admins extends Users
{
    /**
     * @return array
     */
    public function getUsersGroups()
    {
        $res = [];
        foreach ($this->usersGroups(0) as $usersGroup) {
            if($usersGroup['isfolder']){
                $usersGroup['items'] = $this->usersGroups($usersGroup['id']);
            }
            $res[] = $usersGroup;
        }
        return $res;
    }

    /**
     * @param $parent_id
     * @return mixed
     */
    private function usersGroups($parent_id)
    {
        return self::$db
            -> select("
                  select g.id, i.name, g.isfolder
                  from users_group g, users_group_info i 
                  where g.parent_id={$parent_id} and g.rang > 100 and i.group_id=g.id and i.languages_id = {$this->languages_id}
              ")
            -> all();
    }
}