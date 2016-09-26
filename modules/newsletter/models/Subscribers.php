<?php

namespace modules\newsletter\models;

use modules\newsletter\models\subscribers\Meta;
use system\models\Model;

/**
 * Class Subscribers
 * @package modules\newsletter\models
 */
class Subscribers extends Model
{
    protected $meta;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new Meta();
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

        return $this->createRow('__newsletter_subscribers', $data);
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
}