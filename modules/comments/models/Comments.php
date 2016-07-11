<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\comments\models;

use system\models\Front;
use system\models\Mailer;
use system\models\Model;

/**
 * Class Comments
 * @package modules\comments\models
 */
class Comments extends Model
{
    public $comment;

    /**
     * @param $content_id
     * @param int $parent_id
     * @return array
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id, $parent_id = 0)
    {
        $res = array();

        $r = self::$db->select("
            select *, UNIX_TIMESTAMP(created) as created
            from __comments
            where content_id = '{$content_id}' and parent_id={$parent_id} and status='approved'
            order by abs(id) desc
        ")->all();

        foreach ( $r as $row) {
            $row['user'] = self::$db->select("select id, name, surname from __users where id={$row['users_id']} limit 1")->row();

            if($row['isfolder']){
                $row['items'] = $this->get($content_id, $row['id']);
            }
            $res[] = $row;
        }

        return $res;
    }

    /**
     * @param $content_id
     * @param string $status
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getTotal($content_id = 0, $status = 'approved')
    {
        $w = $content_id > 0 ? "content_id={$content_id} and " : "";
        return self::$db->select("
            select count(id) as t
            from __comments
            where {$w} status='{$status}'
        ")->row('t');
    }

    /**
     * @param $content_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getAverageRating($content_id)
    {
        return self::$db->select("
            select AVG(rate) as t
            from __comments
            where content_id={$content_id} and status='approved'
        ")->row('t') * 1;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        return  self::$db->insert('__comments', $data);
    }

    /**
     * @param $skey
     * @return bool
     */
    public function approve($skey)
    {
        $com = self::$db->select("select id, parent_id, content_id, users_id from __comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;

        $this->comment = $com;
        $s = $this->updateRow('__comments', $com['id'],  ['status' => 'approved']);

        if($s > 0){
            if($com['parent_id'] > 0){
                $this->updateRow('__comments', $com['parent_id'],  ['isfolder' => 1]);
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
        $com = self::$db->select("select id, parent_id from __comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;

        $this->comment = $com;

        $s = $this->deleteRow('__comments', $com['id']);
        if($s > 0 && $com['parent_id'] > 0){
            $t = self::$db
                ->select("select count(id) as t from __comments where parent_id = {$com['parent_id']} and status='approved'")
                ->row('t');
            if($t == 0){
                $this->updateRow('__comments', $com['parent_id'],  ['isfolder' => 0]);
            }
        }

        return $s;
    }

    public function like($skey, $users_id)
    {
        $com = self::$db->select("select id, likes from __comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;

        $k = self::$db->select("select id from __comments_likers where comments_id={$com['id']} and users_id={$users_id} limit 1")->row('id');
        if($k) return false;

        $this->createRow('__comments_likers', ['comments_id'=> $com['id'], 'users_id' => $users_id]);

        $com['likes'] ++;
        return $this->updateRow('__comments', $com['id'],  ['likes' => $com['likes']]);
    }

    public function dislike($skey, $users_id)
    {
        $com = self::$db->select("select id, dislikes from __comments where skey= '{$skey}' limit 1")->row();
        if(empty($com)) return false;

        $k = self::$db->select("select id from __comments_likers where comments_id={$com['id']} and users_id={$users_id} limit 1")->row('id');
        if($k) return false;

        $this->createRow('__comments_likers', ['comments_id'=> $com['id'], 'users_id' => $users_id]);

        $com['dislikes'] ++;

        return $this->updateRow('__comments', $com['id'],  ['dislikes' => $com['dislikes']]);
    }

    public function getLikes($skey)
    {
        return self::$db->select("select likes from __comments where  skey= '{$skey}' limit 1")->row('likes');
    }

    public function getDisLikes($skey)
    {
        return self::$db->select("select dislikes from __comments where  skey= '{$skey}' limit 1")->row('dislikes');
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getInfo($id, $key = '*')
    {
        return self::$db->select("select {$key} from __comments where id={$id} limit 1")->row($key);
    }

    /**
     * @param $users_id
     * @param $content_id
     * @return bool
     */
    public function isSubscribe($users_id, $content_id)
    {
        return self::$db
            ->select("select id from __comments_subscribers where users_id={$users_id} and content_id={$content_id} limit 1")
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
            '__comments_subscribers',
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
            '__comments_subscribers',
            "users_id={$users_id} and content_id={$content_id} limit 1"
        );
    }

    /**
     * @param $data
     * @throws \system\core\exceptions\Exception
     */
    public function notifySubscribers($data)
    {
        $r = self::$db
            ->select("
                select u.id, u.name, u.surname, u.email, i.name as page_name
                from __comments_subscribers cs
                join __users u on u.id=cs.users_id
                join __content_info i on i.content_id={$data['content_id']} and i.languages_id={$this->languages_id}
                where cs.content_id={$data['content_id']} and users_id <> {$data['users_id']}
                ")
            ->all();

        if(empty($r)) return;

//        Logger::init('comments', 'notify_subscribers');

        $content = new Front();
        $url = $content->getUrlById($data['content_id']);

        foreach ($r as $item) {
            if(empty($item['email'])) continue;

            $item['page_url'] = $url;
            $mailer = new Mailer('comments_notify_subscribers', $item);
            $mailer->addAddress($item['email'], $item['name']);

            if(!$mailer->send()){
//                Logger::log("CID:{$data['content_id']} UID: {$item['id']} {$item['name']} {$item['email']}. ERROR");
            } else {
//                Logger::log("CID:{$data['content_id']} UID: {$item['id']} {$item['name']} {$item['email']}. OK");
            }
            $mailer->clearAddresses();
        }
    }
}