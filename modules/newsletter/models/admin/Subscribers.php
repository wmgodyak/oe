<?php

namespace modules\newsletter\models\admin;
use modules\newsletter\models\subscribers\Groups;

/**
 * Class Subscribers
 * @package modules\newsletter\models\admin
 */
class Subscribers extends \modules\newsletter\models\Subscribers
{
    public $groups;

    public function __construct()
    {
        parent::__construct();

        $this->groups = new Groups();
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

    public function getByGroupID($group_id)
    {
        return self::$db
            ->select("
                select s.id, s.email, s.status, s.created, s.confirmdate
                from __newsletter_subscribers_group_subscribers gs
                join __newsletter_subscribers s on gs.subscribers_id=s.id and s.status = 'confirmed'
                where gs.group_id={$group_id}
                ")
            ->all();
    }
}