<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.12.15 : 18:05
 */

namespace models\engine;


use models\core\Model;

class User extends Model
{

    /**
     * generate random password
     * @param int $number
     * @return string
     */
    public static function generatePassword($number = 6)
    {
        $arr = array(
            'A','B','C','D','E','F',
            'G','H','I','J','K','L',
            'M','N','O','P','R','S',
            'T','U','V','X','Y','Z',
            '1','2','3','4','5','6',
            '7','8','9','0'
        );

        $pass = "";
        for($i = 0; $i < $number; $i++)
        {
            $index = rand(0, count($arr) - 1);
            $pass .= $arr[$index];
        }
        return $pass;
    }

    /**
     * @param $password
     * @return string
     */
    public static function cryptPassword($password)
    {
        $salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');

        return crypt($password, $salt);
    }

    /**
     * @param $password
     * @param $hash
     * @return bool
     */
    public static function checkPassword($password, $hash)
    {
        return crypt($password, $hash) == $hash;
    }
}