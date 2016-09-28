<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.09.16 : 15:21
 */

namespace modules\newsletter\models\admin;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class CampaignsInfo
 * @package modules\newsletter\models\admin
 */
class CampaignsInfo extends Model
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        return $this->rowData('__newsletter_campaigns_info', $id, $key);
    }

    public function get($campaigns_id)
    {
        return self::$db
            ->select("select * from __newsletter_campaigns_info where campaigns_id={$campaigns_id} ")
            ->all();
    }

    /**
     * @param $campaigns_id
     * @param $languages_id
     * @return array|mixed
     */
    public function getID($campaigns_id, $languages_id)
    {
        return self::$db
            ->select("select id from __newsletter_campaigns_info where campaigns_id={$campaigns_id} and languages_id={$languages_id} limit 1")
            ->row('id');
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        return $this->createRow('__newsletter_campaigns_info', $data);
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        return $this->updateRow('__newsletter_campaigns_info', $id, $data);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('__newsletter_campaigns_info', $id);
    }
}