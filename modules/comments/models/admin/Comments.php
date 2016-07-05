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
     * @param int $limit
     * @return array
     * @throws \system\core\exceptions\Exception
     */
    public function getLatest($limit = 5 )
    {
        $res = array();

        $r = self::$db->select("
            select *
            from __comments
            where status in ('approved', 'new')
            order by abs(id) desc
            limit {$limit}
        ")->all();

        foreach ( $r as $row) {
            $row['user'] = self::$db->select("select id, name, surname from __users where id={$row['users_id']} limit 1")->row();
            $res[] = $row;
        }

        return $res;
    }
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