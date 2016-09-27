<?php

namespace modules\newsletter\models\admin;
use modules\newsletter\models\subscribers\Groups;
use modules\newsletter\models\subscribers\GroupSubscribers;

/**
 * Class Subscribers
 * @package modules\newsletter\models\admin
 */
class Subscribers extends \modules\newsletter\models\Subscribers
{
    public $groups;
    public $groups_subscribers;

    public function __construct()
    {
        parent::__construct();

        $this->groups = new Groups();
        $this->groups_subscribers = new GroupSubscribers();
    }

    public function export($group_id)
    {
        $join = "";
        if($group_id){
            $join = "join __newsletter_subscribers_group_subscribers gs on gs.group_id={$group_id} and gs.subscribers_id=s.id";
        }

        return self::$db
            ->select("
                select s.id, s.email, s.status, s.created, s.confirmdate
                from __newsletter_subscribers s
                {$join}
                ")
            ->all();
    }
}