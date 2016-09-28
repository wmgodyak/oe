<?php

namespace modules\newsletter\models\admin\campaigns;

/**
 * Class Queues
 * @package modules\newsletter\models\admin\campaigns
 */
class Queues extends \modules\newsletter\models\campaigns\Queues
{
    public function create($campaigns_id, $subscribers_id)
    {
        return $this->createRow
        (
            '__newsletter_queues',
            ['campaigns_id' =>$campaigns_id, 'subscribers_id' =>$subscribers_id]
        );
    }

    public function clear($campaigns_id)
    {
        return self::$db->delete('__newsletter_queues', "campaigns_id={$campaigns_id}");
    }

    public function progressCount($campaigns_id)
    {
        return self::$db
            ->select("select count(*) as total, sum(sent) as sent from __newsletter_queues where campaigns_id={$campaigns_id}")
            ->row();
    }
}