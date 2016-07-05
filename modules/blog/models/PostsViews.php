<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.07.16 : 16:00
 */


namespace modules\blog\models;


use system\models\Model;

defined("CPATH") or die();

class PostsViews extends Model
{
    /**
     * @param $posts_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getTotal($posts_id)
    {
        return self::$db->select("select count(id) as t from __posts_views where posts_id='{$posts_id}'")->row('t');
    }

    public function set($posts_id)
    {
        $id = self::$db->select("select id from __posts_views where posts_id='{$posts_id}' limit 1")->row('id');
    }
}