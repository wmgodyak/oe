<?php

namespace modules\newsletter\models\admin\campaigns;

use system\models\Model;

/**
 * Class SubscribersGroups
 * @package modules\newsletter\models\admin\campaigns
 */
class SubscribersGroups extends Model
{
    /**
     * @param $campaigns_id
     * @param $group_id
     * @return bool|string
     */
    public function create($campaigns_id, $group_id)
    {
        $aid = self::$db
            ->select("select id from __newsletter_campaigns_subscribers_groups
              where campaigns_id={$campaigns_id} and group_id={$group_id} limit 1")
            ->row('id');

        if($aid > 0) return false;

        return parent::createRow(
            '__newsletter_campaigns_subscribers_groups',
            ['campaigns_id' => $campaigns_id, 'group_id' => $group_id]
        );
    }

    /**
     * @param $campaigns_id
     * @return int
     * @throws \system\core\exceptions\Exception
     */
    public function deleteByCampaigns($campaigns_id)
    {
        return self::$db
            ->delete
            (
                "__newsletter_campaigns_subscribers_groups",
                "where campaigns_id={$campaigns_id}"
            );
    }

    public function get($campaigns_id)
    {
        return self::$db
            ->select("select group_id as id from __newsletter_campaigns_subscribers_groups
              where campaigns_id={$campaigns_id}")
            ->all('id');
    }
}