<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 25.06.16
 * Time: 20:39
 */

namespace modules\comments\models\admin;
/**
 * Class Comments
 * @package modules\comments\models\admin
 */
class Comments extends \modules\comments\models\Comments
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $data = self::$db->select("select {$key} from __comments where id={$id} limit 1")->row($key);
        if($key != '*') return $data;

        $data['user'] = self::$db->select("select name, surname from __users where id={$data['users_id']}")->row();

        return $data;
    }

    public function update($id, $data)
    {
        return $this->updateRow('__comments', $id, $data);
    }

    public function spam($id)
    {
        return $this->updateRow('__comments', $id, ['status' => 'spam']);
    }

    public function restore($id)
    {
        return $this->updateRow('__comments', $id, ['status' => 'new']);
    }

    public function delete($id)
    {
        return $this->deleteRow('__comments', $id);
    }
}