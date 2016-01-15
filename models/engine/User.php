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
     * @param $id
     * @param $password
     * @return bool
     */
    public static function changePassword($id, $password)
    {
        $password = self::cryptPassword($password);
        return self::$db->update('users', ['password' => $password], " id = {$id} limit 1");
    }

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
        $salt = strtr(base64_encode(mt_rand()), '+', '.');

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

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function updateProfile($id, $data)
    {
        $data['updated'] = $this->now();
        if(isset($data['password'])){
            $data['password'] = $this->cryptPassword($data['password']);
        }
        return self::$db->update('users', $data, " id={$id} limit 1");
    }

    public function changeAvatar($id)
    {
        $path = "uploads/avatars/";
        $fname =  '/'.$path . md5($id) . '.png';

        $allowed = ['image/png', 'image/jpeg']; $size = 500000; $s=0; $m=[];

        $img = $_FILES['avatar'];

        if(!in_array($img['type'], $allowed)){
            $m = 'not_allowed';
        } elseif($img['size'] > $size){
            $m = 'max_size';
        } else {

            if(file_exists(DOCROOT . $fname)) unlink(DOCROOT. $fname);

            include_once DOCROOT . '/vendor/acimage/AcImage.php';

            $img = \AcImage::createImage($img['tmp_name']);
            $img->thumbnail(160, 120);
            $img->saveAsPNG(DOCROOT . $fname);

            $s = self::$db->update('users', ['avatar' => $fname], "id = '{$id}' limit 1");
        }

        return ['s' => $s, 'm' => $m, 'f' => $fname];
    }
}
