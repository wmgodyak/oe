<?php

namespace modules\newsletter\models\campaigns;

use system\models\Model;

/**
 * Class Queues
 * @package modules\newsletter\models\campaigns
 */
class Queues extends Model
{
    /**
     * @param $campaigns_id
     * @param int $limit
     * @return mixed
     */
    public function getNotSentSubscribers($campaigns_id, $limit = 30)
    {
        return self::$db
            ->select("
                select q.id, s.email, s.languages_id
                from __newsletter_queues q
                join __newsletter_subscribers s on s.id = q.subscribers_id
                where q.campaigns_id = {$campaigns_id} and q.sent = 0
                limit {$limit}
            ")
            ->all();
    }

    public function setSent($id)
    {
        return parent::updateRow('__newsletter_queues', $id, ['sent' => 1, 'sent_at' => date('Y-m-d H:i:s')]);
    }
}