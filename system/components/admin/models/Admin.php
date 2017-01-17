<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 11.06.16
 * Time: 23:35
 */

namespace system\components\admin\models;

defined("CPATH") or die();

use system\models\Users;

class Admin extends Users
{

    /**
     * @param $user
     * @return bool
     */
    public function login($user)
    {
        return self::$db->update('__users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }
}