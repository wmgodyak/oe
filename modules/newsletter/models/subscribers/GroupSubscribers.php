<?php

namespace modules\newsletter\models\subscribers;

use system\models\Model;

/**
 * Class GroupSubscribers
 * @package modules\newsletter\models\subscribers
 */
class GroupSubscribers extends Model
{
    public function create($group_id, $subscribers_id)
    {
        $aid = self::$db
            ->select("select id from __newsletter_subscribers_group_subscribers where group_id={$group_id} and subscribers_id={$subscribers_id} limit 1")
            ->row('id');
        if($aid > 0) return false;

        return parent::createRow(
            '__newsletter_subscribers_group_subscribers',
            ['group_id' => $group_id, 'subscribers_id' => $subscribers_id]
        );
    }

    public function delete($group_id, $subscribers_id)
    {
        return self::$db->delete("__newsletter_subscribers_group_subscribers", "group_id={$group_id} and subscribers_id={$subscribers_id} limit 1");
    }
}