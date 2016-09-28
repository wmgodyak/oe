<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.09.16 : 15:21
 */

namespace modules\newsletter\models\admin;

use modules\newsletter\models\admin\campaigns\Queues;
use modules\newsletter\models\admin\campaigns\SubscribersGroups;
use modules\newsletter\models\subscribers\Groups;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Campaigns
 * @package modules\newsletter\models\admin
 */
class Campaigns extends Model
{
    private $info;
    public $groups;
    public $subscribers_groups;
    public $queues;
    private $subscribers;

    public function __construct()
    {
        parent::__construct();

        $this->info = new CampaignsInfo();
        $this->groups = new Groups();
        $this->subscribers_groups = new SubscribersGroups();
        $this->queues = new Queues();
        $this->subscribers = new Subscribers();
    }

    public function getData($id, $key= '*')
    {
        $res = $this->rowData('__newsletter_campaigns', $id, $key);

        if($key == '*'){
            $res['info'] = [];
            foreach ($this->info->get($id) as $item) {
                $res['info'][$item['languages_id']] = $item;
            }

            $res['groups'] = $this->subscribers_groups->get($id);
        }

        return $res;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        $this->beginTransaction();
        $id = $this->createRow('__newsletter_campaigns', $data);

        if($id > 0){
            foreach ($this->request->post('info') as $languages_id => $item) {
                $item['campaigns_id'] = $id;
                $item['languages_id'] = $languages_id;
                $this->info->create($item);
            }
        }

        if($this->hasError()) {
           $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    /**
     * @param $id
     * @param $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->beginTransaction();

        $this->updateRow('__newsletter_campaigns', $id, $data);

        foreach ($this->request->post('info') as $languages_id => $item) {
            $aid = $this->info->getID($id, $languages_id);

            if($aid > 0){
                $this->info->update($aid, $item);
            } else {
                $item['campaigns_id'] = $id;
                $item['languages_id'] = $languages_id;

                $this->info->create($item);
            }
        }

        if($this->hasError()) {
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        $s = $this->deleteRow('__newsletter_campaigns', $id);
        if($s){
            $this->queues->clear($id);
        }
        return $s;
    }

    public function run($id)
    {
        $this->beginTransaction();
        $s = self::$db->update('__newsletter_campaigns', ['status' => 'in_progress'], "id={$id} limit 1");

        $this->queues->clear($id);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $groups = $this->subscribers_groups->get($id);

        foreach ($groups as $k=>$group_id) {
            $subscribers = $this->subscribers->getByGroupID($group_id);
            if(empty($subscribers)) continue;

            foreach ($subscribers as $subscriber) {
                $this->queues->create($id, $subscriber['id']);
            }
        }

        $this->commit();
        return $s;
    }

    public function pause($id)
    {
        return self::$db->update('__newsletter_campaigns', ['status' => 'paused'], "id={$id} limit 1");
    }

    public function stop($id)
    {
        $this->queues->clear($id);
        return self::$db->update('__newsletter_campaigns', ['status' => 'new'], "id={$id} limit 1");
    }
}