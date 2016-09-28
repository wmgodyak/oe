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
 * Class Campaigns
 * @package modules\newsletter\models\admin
 */
class Campaigns extends Model
{
    private $info;

    public function __construct()
    {
        parent::__construct();

        $this->info = new CampaignsInfo();
    }

    public function getData($id, $key= '*')
    {
        $res = $this->rowData('__newsletter_campaigns', $id, $key);

        if($key == '*'){
            $res['info'] = [];
            foreach ($this->info->get($id) as $item) {
                $res['info'][$item['languages_id']] = $item;
            }
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
        return $this->deleteRow('__newsletter_campaigns', $id);
    }
}