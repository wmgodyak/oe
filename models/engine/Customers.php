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
class Customers extends Users
{
    public function __construct()
    {
        parent::__construct();

        $this->languages_id  = Engine::$language_id;
    }

    public function getGroups($parent_id = 0)
    {
        $items = self::$db
            ->select("
                select ug.id, ugi.name, ug.isfolder
                from __users_group ug
                join __users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}
                where ug.parent_id={$parent_id} and ug.rang < 100
                ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->getGroups($item['id']);
            }
        }

        return $items;
    }
}