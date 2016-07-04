<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 0:47
 */

namespace modules\account\models;

defined("CPATH") or die();

use system\models\Mailer;
use system\models\Users;

/**
 * Class Account
 * @package modules\account\models
 */
class Account extends Users
{
    public function create($data)
    {
        $s = parent::create($data);

        if($s && isset($data['email'])){
            $mailer = new Mailer('account_register', $data);
            $mailer
                ->addAddress($data['email'], $data['name'])
                ->send();
        }

        return $s;
    }

    public function setOnline($user)
    {
        return self::$db->update('__users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }
}