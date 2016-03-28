<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.01.16 : 10:10
 */

namespace models\engine;

use models\components\Users;
use models\Engine;

defined("CPATH") or die();

/**
 * Class Admins
 * @package models\engine
 */
class Admins extends Users
{
    public function __construct()
    {
        parent::__construct();

        $this->languages_id  = Engine::$language_id;
    }

    /**
     * @param int $parent_id
     * @param int $rang
     * @return array
     */
    public function getGroups($parent_id = 0, $rang = 101)
    {
        $res = self::$db
            -> select("
                  select g.id, i.name, g.isfolder
                  from users_group g, users_group_info i
                  where g.parent_id={$parent_id} and g.rang >= {$rang} and i.group_id=g.id and i.languages_id = {$this->languages_id}
              ")
            -> all();

        foreach ($res as $k=>$r) {
            if($r['isfolder']){
                $res[$k]['items'] = $this->getGroups($r['id'], $rang);
            }
        }

        return $res;
    }
}