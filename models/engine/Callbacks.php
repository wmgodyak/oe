<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 11.04.16 : 10:52
 */

namespace models\engine;

use models\components\Callback;

defined("CPATH") or die();

class Callbacks extends Callback
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $data = self::$db->select("select {$key} from callbacks where id={$id} limit 1")->row($key);
        if($key != '*') return $data;

        return $data;
    }

    public function getManagerData($id)
    {
        return self::$db
            ->select("select CONCAT(name, ' ', surname) as name from users where id={$id} limit 1")
            ->row('name');
    }

    public function update($id, $data)
    {
        $data['updated'] = date('Y-m-d H:i:s');
        return $this->updateRow('callbacks', $id, $data);
    }

    public function spam($id, $manager_id)
    {
        return $this->updateRow('callbacks', $id, ['status' => 'spam', 'manager_id' => $manager_id]);
    }

    public function restore($id, $manager_id)
    {
        return $this->updateRow('callbacks', $id, ['status' => 'new', 'manager_id' => $manager_id]);
    }

    public function delete($id)
    {
        return $this->deleteRow('callbacks', $id);
    }
}