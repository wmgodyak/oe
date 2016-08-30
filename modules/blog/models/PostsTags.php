<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 23:09
 */

namespace modules\blog\models;

use system\models\Model;

/**
 * Class Tags
 * @package modules\blog\models
 */
class PostsTags extends Model
{
    public function get($post_id)
    {
        $tags = self::$db
            ->select("
              select t.id, t.tag, ct.languages_id
              from __posts_tags ct
              join __tags t on t.id=ct.tags_id
              where ct.posts_id={$post_id}
            ")
            ->all();
        $res = [];
        foreach ($tags as $tag) {
            $res[$tag['languages_id']][$tag['id']] = $tag['tag'];
        }
        return $res;
    }

    /**
     * @param $tags_id
     * @param $posts_id
     * @param $languages_id
     * @return bool|string
     */
    public function create($tags_id, $posts_id, $languages_id)
    {
        $id = self::$db
            ->select("
              select id
              from __posts_tags
              where posts_id={$posts_id} and tags_id={$tags_id} and languages_id={$languages_id} limit 1
              ")
            ->row('id');

        if($id > 0) return 0;

        return $this->createRow
        (
            '__posts_tags',
            ['tags_id' => $tags_id, 'posts_id' => $posts_id, 'languages_id' => $languages_id]
        );
    }

    /**
     * @param $tags_id
     * @param $posts_id
     * @return int
     * @throws \system\core\exceptions\Exception
     */
    public function delete($tags_id, $posts_id)
    {
        return self::$db->delete("__posts_tags", " tags_id={$tags_id} and posts_id={$posts_id}");
    }

    public function getTotal($tags_id)
    {
        return self::$db
            ->select("select count(id) as t from __posts_tags where tags_id={$tags_id}")
            ->row('t');
    }
}