<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.01.16 : 10:10
 */

namespace models\engine;

use models\components\Users;
use models\Engine;

defined("CPATH") or die();

/**
 * Class Admins
 * @package models\engine
 */
class Comments extends \models\components\Comments
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $data = self::$db->select("select {$key} from comments where id={$id} limit 1")->row($key);
        if($key != '*') return $data;

        $data['user'] = self::$db->select("select name, surname from users where id={$data['users_id']}")->row();

        return $data;
    }

    public function update($id, $data)
    {
        return $this->updateRow('comments', $id, $data);
    }

    public function spam($id)
    {
        return $this->updateRow('comments', $id, ['status' => 'spam']);
    }
    public function restore($id)
    {
        return $this->updateRow('comments', $id, ['status' => 'new']);
    }
    public function delete($id)
    {
        return $this->deleteRow('comments', $id);
    }


}