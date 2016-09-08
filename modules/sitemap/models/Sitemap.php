<?php

namespace modules\sitemap\models;

use system\models\Model;

/**
 * Class Sitemap
 * @package modules\sitemap\models
 */
class Sitemap extends Model
{
    /**
     * @param $languages_id
     * @param $types_id
     * @param int $parent_id
     * @param int $subtypes_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function tree($languages_id, $types_id, $parent_id = 0)
    {
        return self::$db->select("
          select c.id, c.isfolder, c.types_id, c.subtypes_id, c.published, ci.name, ci.url
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$languages_id}
          where
               c.parent_id = '{$parent_id}'
           and c.types_id = {$types_id}
           and c.status = 'published'
          ")->all();
    }
}