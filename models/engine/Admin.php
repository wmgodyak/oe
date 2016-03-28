<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:13
 */

namespace models\engine;

use models\components\Users;

class Admin extends Users
{
    /**
     * @param $user
     * @return bool
     */
    public function login($user)
    {
        return self::$db->update('users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }
}