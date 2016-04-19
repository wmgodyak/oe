<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.03.16 : 10:12
 */

namespace models\modules;

use models\components\Mailer;
use models\components\Users;

defined("CPATH") or die();

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

    public function checkPass($password, $hash)
    {
       return parent::checkPassword($password, $hash);
    }
}