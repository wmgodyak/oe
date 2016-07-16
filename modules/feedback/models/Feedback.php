<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 16:42
 */

namespace modules\feedback\models;

use system\models\Model;

defined("CPATH") or die();

class Feedback extends Model
{
    public function create($data)
    {
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        return parent::createRow('__feedbacks', $data);
    }


    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $data = self::$db->select("select {$key} from __feedbacks where id={$id} limit 1")->row($key);
        if($key != '*') return $data;

        return $data;
    }

    public function getStatuses()
    {
        return self::$db->enumValues('__feedbacks', 'status');
    }

    public function getManagerData($id)
    {
        return self::$db
            ->select("select CONCAT(name, ' ', surname) as name from __users where id={$id} limit 1")
            ->row('name');
    }

    public function update($id, $data)
    {
        $data['updated'] = date('Y-m-d H:i:s');
        return $this->updateRow('__feedbacks', $id, $data);
    }

    public function spam($id, $manager_id)
    {
        return $this->updateRow('__feedbacks', $id, ['status' => 'spam', 'manager_id' => $manager_id]);
    }

    public function restore($id, $manager_id)
    {
        return $this->updateRow('__feedbacks', $id, ['status' => 'new', 'manager_id' => $manager_id]);
    }

    public function delete($id)
    {
        return $this->deleteRow('__feedbacks', $id);
    }
}