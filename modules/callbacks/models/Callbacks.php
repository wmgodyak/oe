<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\callbacks\models;

use system\core\Session;
use system\models\Model;

/**
 * Class Callback
 * @package modules\callback\models
 */
class Callbacks extends Model
{
    public function create($data)
    {
        $user = Session::get('user');
        if($user){
            $data['users_id'] = $user['id'];
        }

        $data['ip'] = $_SERVER['REMOTE_ADDR'];

        return parent::createRow('__callbacks', $data);
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $data = self::$db->select("select {$key} from __callbacks where id={$id} limit 1")->row($key);
        if($key != '*') return $data;

        return $data;
    }

    public function getStatuses()
    {
        return self::$db->enumValues('__callbacks', 'status');
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
        return $this->updateRow('__callbacks', $id, $data);
    }

    public function spam($id, $manager_id)
    {
        return $this->updateRow('__callbacks', $id, ['status' => 'spam', 'manager_id' => $manager_id]);
    }

    public function restore($id, $manager_id)
    {
        return $this->updateRow('__callbacks', $id, ['status' => 'new', 'manager_id' => $manager_id]);
    }

    public function delete($id)
    {
        return $this->deleteRow('__callbacks', $id);
    }
}