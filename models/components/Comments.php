<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.03.16 : 14:36
 */

namespace models\components;

use controllers\core\Logger;
use models\App;
use models\app\Content;

defined("CPATH") or die();

class Comments extends App
{
    public $comment;

    public function get($content_id, $parent_id=0)
    {
        $res = array();
        $r = self::$db->select("
            select *, DATE_FORMAT(created, '%d.%m.%Y') as pubdate
            from comments
            where content_id = '{$content_id}' and parent_id={$parent_id} and status='approved'
            order by abs(id) asc
        ")->all();
        foreach ( $r as $row) {
            $row['user'] = self::$db->select("select id, name, surname from users where id={$row['users_id']} limit 1")->row();

            if($row['isfolder']){
                $row['items'] = $this->get($content_id, $row['id']);
            }
            $res[] = $row;
        }

        return $res;
    }

    /**
     * @param $content_id
     * @return array|mixed
     */
    public function getTotal($content_id)
    {
        return self::$db->select("
            select count(id) as t
            from comments
            where content_id={$content_id} and status='approved'
        ")->row('t');
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        return  self::$db->insert('comments', $data);
    }

    /**
     * @param $skey
     * @return bool
     */
    public function approve($skey)
    {
        $com = self::$db->select("select id, parent_id, content_id, users_id from comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;
        $this->comment = $com;
        $s = $this->updateRow('comments', $com['id'],  ['status' => 'approved']);

        if($s > 0){
            if($com['parent_id'] > 0){
                $this->updateRow('comments', $com['parent_id'],  ['isfolder' => 1]);
            }

            // notify subscribers
            $this->notifySubscribers($com);
        }

        return true;
    }

    /**
     * @param $skey
     * @return bool|int
     */
    public function del($skey)
    {
        $com = self::$db->select("select id, parent_id from comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;

        $s = $this->deleteRow('comments', $com['id']);
        if($s > 0 && $com['parent_id'] > 0){
            $t = self::$db
                ->select("select count(id) as t from comments where parent_id = {$com['parent_id']} and status='approved'")
                ->row('t');
            if($t == 0){
                $this->updateRow('comments', $com['parent_id'],  ['isfolder' => 0]);
            }
        }

        return $s;
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getInfo($id, $key = '*')
    {
        return self::$db->select("select {$key} from comments where id={$id} limit 1")->row($key);
    }

    /**
     * @param $users_id
     * @param $content_id
     * @return bool
     */
    public function isSubscribe($users_id, $content_id)
    {
        return self::$db
            ->select("select id from comments_subscribers where users_id={$users_id} and content_id={$content_id} limit 1")
            ->row('id') > 0;
    }

    /**
     * @param $users_id
     * @param $content_id
     * @return bool|string
     */
    public function subscribe($users_id, $content_id)
    {
        return self::$db->insert(
            'comments_subscribers',
            array('content_id' => $content_id, 'users_id' => $users_id)
        );
    }
    /**
     * @param $users_id
     * @param $content_id
     * @return bool|string
     */
    public function unSubscribe($users_id, $content_id)
    {
        return self::$db->delete(
            'comments_subscribers',
            "users_id={$users_id} and content_id={$content_id} limit 1"
        );
    }

    public function notifySubscribers($data)
    {
        $r = self::$db
            ->select("
                select u.id, u.name, u.surname, u.email, i.name as page_name
                from comments_subscribers cs
                join users u on u.id=cs.users_id
                join content_info i on i.content_id={$data['content_id']} and i.languages_id={$this->languages_id}
                where cs.content_id={$data['content_id']} and users_id <> {$data['users_id']}
                ")
            ->all();

        if(empty($r)) return;

        Logger::init('comments', 'notify_subscribers');

        $content = new Content();
        $url = $content->getUrlById($data['content_id']);

        foreach ($r as $item) {
            if(empty($item['email'])) continue;

            $item['page_url'] = $url;
            $mailer = new Mailer('comments_notify_subscribers', $item);
            $mailer->addAddress($item['email'], $item['name']);

            if(!$mailer->send()){
                Logger::log("CID:{$data['content_id']} UID: {$item['id']} {$item['name']} {$item['email']}. ERROR");
            } else {
                Logger::log("CID:{$data['content_id']} UID: {$item['id']} {$item['name']} {$item['email']}. OK");
            }
            $mailer->clearAddresses();
        }
    }
}