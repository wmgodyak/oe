<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.01.16 : 10:10
 */


namespace models\engine;


use models\core\Model;

defined("CPATH") or die();

class Users extends Model
{
    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id)
    {
        return self::$db->select("select * from users where id='{$id}'")->row();
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $data['password'] = $this->cryptPassword($data['password']);
        return self::$db->insert('users', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        if(empty($data['password'])){
            unset($data['password']);
        } else {
            $data['password'] = $this->cryptPassword($data['password']);
        }
        $data['updated'] = $this->now();
        return self::$db->update('users', $data, " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function delete($id)
    {
        return self::$db->update('users', ['status' => 'deleted'], " id={$id} limit 1");
    }
    /**
     * @param $id
     * @return bool
     */
    public function restore($id)
    {
        return self::$db->update('users', ['status' => 'active'], " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function ban($id)
    {
        return self::$db->update('users', ['status' => 'ban'], " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return int
     */
    public function remove($id)
    {
        return self::$db->delete('users', " id={$id} limit 1");
    }

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

    /**
     * @param $email
     * @param null $id
     * @return bool
     */
    public function issetEmail($email, $id = null)
    {
        $and = $id ? " id <> {$id} and " : '';
        return self::$db->select("select id from users where {$and} email = '{$email}'  limit 1")->row('id') > 0;
    }
}