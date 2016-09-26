<?php
namespace modules\newsletter\models\subscribers;

use system\models\Model;

/**
 * Class Groups
 * @package modules\newsletter\models\subscribers
 */
class Groups extends Model
{
    /**
     * @param $name
     * @return bool|string
     */
    public function create($name)
    {
        return $this->createRow('__newsletter_subscribers_group', ['name' => $name]);
    }

    /**
     * @param $id
     * @param $name
     * @return bool
     */
    public function update($id, $name)
    {
        return $this->updateRow('__newsletter_subscribers_group', $id, ['name' => $name]);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('__newsletter_subscribers_group', $id);
    }

    public function get()
    {
        return self::$db->select("
          select id, name as text, name
          from __newsletter_subscribers_group
          ")->all();
    }

    public function getData($id)
    {
        return $this->rowData('__newsletter_subscribers_group', $id);
    }
}