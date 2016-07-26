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

/**
 * Class PostsViews
 * @package modules\blog\models
 */
class PostsViews extends Model
{
    /**
     * @param $posts_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getTotal($posts_id)
    {
        return self::$db->select("select sum(views) as t from __posts_views where posts_id='{$posts_id}'")->row('t');
    }

    /**
     * @param $posts_id
     * @return bool|string
     * @throws \system\core\exceptions\Exception
     */
    public function set($posts_id)
    {
        $d = date('Y-m-d');
        $a = self::$db->select("select id,views from __posts_views where posts_id='{$posts_id}' and date='{$d}' limit 1")->row();
        if(empty($a['id'])){
            return $this->createRow('__posts_views', ['posts_id' => $posts_id, 'date' => $d, 'views' => 1]);
        }
        return $this->updateRow('__posts_views', $a['id'], ['views' => ++ $a['views']]);
    }
}