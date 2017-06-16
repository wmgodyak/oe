<?php

namespace modules\catalog\models\backend;

use system\models\Content;

/**
 * Class Categories
 * @package modules\catalog\models\backend
 */
class Products extends Content
{
    public function updateParams($id, $data)
    {
        $aid = self::$db->select("select id from __products where content_id = {$id} limit 1")->row('id');

        if(empty($aid)){
            $data['content_id'] = $id;
            return $this->createRow('__products', $data);
        }

        return $this->updateRow('__products', $aid, $data);
    }


    public function getParams($id)
    {
        return self::$db->select("select * from __products where content_id = {$id} limit 1")->row();
    }
}