<?php

namespace modules\newsletter\models\admin;

class Subscribers extends \modules\newsletter\models\Subscribers
{
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