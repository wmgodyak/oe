<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 23:09
 */

namespace modules\blog\models;

use system\models\Frontend;

/**
 * Class Tags
 * @package modules\blog\models
 */
class Tags extends Frontend
{
    /**
     * @param $tag
     * @return array|bool|mixed|string
     */
    public function create($tag)
    {
        return $this->createRow('__tags', ['tag' => $tag]);
    }

    /**
     * @param int $post_id
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function get($post_id, $start = 0, $num = 100)
    {
        return self::$db
            ->select("
              select ct.id, t.tag
              from __posts_tags ct
              join __tags t on t.id=ct.tags_id
              where ct.posts_id={$post_id} and ct.languages_id = '{$this->languages->id}'
              limit {$start}, {$num}
            ")
            ->all();
    }

    /**
     * @param int $num
     * @return mixed
     */
    public function popular($num)
    {
        return self::$db
            ->select("select id, tag from __tags limit {$num}")
            ->all();
    }

    /**
     * @param $tag
     * @return array|mixed
     */
    public function getId($tag)
    {
        return self::$db
            ->select("select id from __tags where tag = '{$tag}' limit 1")
            ->row('id');
    }

    public function delete($id)
    {
        return $this->deleteRow('__tags', $id);
    }

    public function getContentType($content_id)
    {
        return self::$db
            ->select("
                select ct.type
                from __content c
                join __content_types ct on ct.id=c.types_id
                where c.id={$content_id}
                limit 1
                ")
            ->row('type');
    }
    /**
     * @param $tag
     * @return array|mixed
     */
    public function data($tag)
    {
        return self::$db
            ->select("select * from __tags where tag = '{$tag}' limit 1")
            ->row();
    }

}