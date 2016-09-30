<?php

namespace modules\newsletter\models;

use modules\newsletter\models\subscribers\Meta;
use modules\newsletter\models\subscribers\GroupSubscribers;
use system\models\Model;

/**
 * Class Subscribers
 * @package modules\newsletter\models
 */
class Subscribers extends Model
{
    public $meta;
    public $groups_subscribers;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new Meta();
        $this->groups_subscribers = new GroupSubscribers();
    }

    /**
     * @param $email
     * @return bool
     */
    public function is($email)
    {
        return self::$db
            ->select("select id from __newsletter_subscribers where email = '{$email}' limit 1")
            ->row('id') > 0;
    }

    public function getData($id, $key= '*')
    {
        return $this->rowData('__newsletter_subscribers', $id, $key);
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        if(empty($data['code'])) {
            $data['code'] = md5($data['email'] . time());
        }

        if(empty($data['ip'])){
            if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
                $ip = $_SERVER['HTTP_CLIENT_IP'];
            } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
                $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
            } else {
                $ip = $_SERVER['REMOTE_ADDR'];
            }
            $data['ip'] = $ip;
        }

        if(!isset($data['languages_id'])){
            $data['languages_id'] = $this->languages_id;
        }

        return $this->createRow('__newsletter_subscribers', $data);
    }

    public function confirm($code)
    {
        return self::$db->update('__newsletter_subscribers', ['status' => 'confirmed'], " code = '{$code}' limit 1");
    }
    public function unsubscribe($code)
    {
        return self::$db->delete('__newsletter_subscribers', " code = '{$code}' limit 1");
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function edit($id, $data)
    {
        return $this->updateRow('__newsletter_subscribers', $id, $data);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('__newsletter_subscribers', $id);
    }

    public function importFromContacts()
    {
        $conf = [
            5 => 2,
            6 => 3,
            7 => 4,
            8 => 5
        ];

        $in = "5,6,7,8";

        foreach (self::$db->select("select group_id, languages_id, email, name, surname from __users where group_id in ({$in}) ")->all() as $item) {
            if($this->is($item['email'])) continue;

            $users_id = $this->create([
               'email'        => $item['email'],
               'languages_id' => $item['languages_id'],
                'status'      => 'confirmed',
                'form'        => 'users'
            ]);

            if($users_id > 0){

                // set meta
                $this->meta->create($users_id, 'name', $item['name']);
                $this->meta->create($users_id, 'surname', $item['surname']);
                $this->meta->create($users_id, 'group_id', $item['group_id']);

                // assign to group
                if(!isset($conf[$item['group_id']])) continue;
                $this->groups_subscribers->create($conf[$item['group_id']], $users_id);

            }
        }

        return !$this->hasError();
    }
}