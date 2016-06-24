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
class Tags extends Model
{
    /**
     * @param $post_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($post_id)
    {
        return self::$db
            ->select("
              select ct.id, t.tag
              from __content_tags ct
              join __tags t on t.id=ct.tags_id
              where ct.content_id={$post_id} and ct.languages_id = {$this->languages_id}
            ")
            ->all();
    }
}