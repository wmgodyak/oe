<?php

namespace system\models;

use system\core\Session;

defined('CPATH') or die();

/**
 * Class Users
 * @package system\models
 */
class Users extends Frontend
{
    public $meta;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new UsersMeta();
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data = self::$db->select(
            "select u.{$key}, g.backend, gi.name as group_name
            from __users u
            join __users_group g on g.id=u.group_id
            join __users_group_info gi on gi.group_id=u.group_id and gi.languages_id={$this->languages->id}
            where u.id = '{$id}'
            limit 1"
        )->row($key);

        return $data;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        if(isset($data['password'])){
            $data['password'] = $this->cryptPassword($data['password']);
        }
        return self::$db->insert('__users', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        if(isset($data['password'])){
            if(empty($data['password'])) {
                
            } else {
                $data['password'] = $this->cryptPassword($data['password']);
            }
        }

        $data['updated'] = $this->now();

        return self::$db->update('__users', $data, " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function delete($id)
    {
        return self::$db->update('__users', ['status' => 'deleted'], " id={$id} limit 1");
    }
    /**
     * @param $id
     * @return bool
     */
    public function restore($id)
    {
        return self::$db->update('__users', ['status' => 'active'], " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function ban($id)
    {
        return self::$db->update('__users', ['status' => 'ban'], " id={$id} limit 1");
    }

    /**
     * @param $id
     * @return int
     */
    public function remove($id)
    {
        return self::$db->delete('__users', " id={$id} limit 1");
    }

    /**
     * @param $id
     * @param $password
     * @return bool
     */
    public function changePassword($id, $password)
    {
        $password = self::cryptPassword($password);
        return self::$db->update('__users', ['password' => $password], " id = {$id} limit 1");
    }

    /**
     * generate random password
     * @param int $number
     * @return string
     */
    public function generatePassword($number = 6)
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
    public function cryptPassword($password)
    {
        $salt = strtr(base64_encode(mt_rand()), '+', '.');
        return crypt($password, $salt);
    }

    /**
     * @param $password
     * @param $hash
     * @return bool
     */
    public function checkPassword($password, $hash)
    {
        return crypt($password, $hash) == $hash;
    }


    public function changeAvatar($id)
    {
        $path = "uploads/avatars/";
        if(! is_dir(DOCROOT . $path)) mkdir(DOCROOT . $path, 0775, true);

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

            $s = self::$db->update('__users', ['avatar' => $fname], "id = '{$id}' limit 1");
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
        return self::$db->select("select id from __users where {$and} email = '{$email}'  limit 1")->row('id') > 0;
    }


    /**
     * @param $id
     * @param $sid
     * @return bool
     */
    public static function isOnline($id, $sid)
    {
        if(! $id) return false;

        return self::$db
            ->select("select id from __users where id = '{$id}' and sessid = '{$sid}' limit 1")
            ->row('id') > 0;
    }

    /**
     * @param $email
     * @return array|mixed
     */
    public function getUserByEmail($email)
    {
        $u = self::$db->select("
            select u.*, g.backend, g.permissions
            from __users u
            join __users_group g on g.id=u.group_id
            where u.email = '{$email}'
            limit 1
          ")->row();
        if(!empty($u['permissions'])){
            $u['permissions'] = unserialize($u['permissions']);
        }
        return $u;
    }

    /**
     * @param $phone
     * @return array|mixed
     */
    public function getUserByPhone($phone)
    {
        $u = self::$db->select("
            select u.*, g.backend, g.permissions
            from __users u
            join __users_group g on g.id=u.group_id
            where u.phone = '{$phone}'
            limit 1
          ")->row();

        if(!empty($u['permissions'])){
            $u['permissions'] = unserialize($u['permissions']);
        }
        return $u;
    }

    /**
     * @param $skey
     * @return array|mixed
     */
    public function getUserBySkey($skey)
    {
        return self::$db->select("
            select u.*, g.backend
            from __users u
            join __users_group g on g.id=u.group_id
            where u.skey = '{$skey}'
            limit 1
          ")->row();
    }

    /**
     * @param int $backend
     * @param array $where
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($backend = 0, $where  = [])
    {
        $w = '';
        if( ! empty($where)){
            $w = ' where '. implode(' and ', $where);
        }
        return self::$db->select("
            select SQL_CALC_FOUND_ROWS u.*
            from __users u
            join __users_group g on g.id=u.group_id and g.backend = {$backend}
            {$w}
          ")->all();
    }

    public function getTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }

    public function login($user)
    {
        Session::set('user', $user);
        return self::$db->update('__users', ['sessid' => Session::id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }

    public function logout($id)
    {
        if(empty($id)) return null;

        self::$db->update('__users', array('sessid'=>''), " id = '{$id}' limit 1");
        Session::delete('user');
    }

}