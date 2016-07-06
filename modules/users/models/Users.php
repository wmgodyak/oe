<?php
namespace modules\users\models;
/**
 * Class users
 * @package modules\users\models
 */
class users extends \system\models\Users
{
    public function setOnline($user)
    {
        return self::$db->update('__users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }
}