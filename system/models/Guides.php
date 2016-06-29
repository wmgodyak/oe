<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 16:30
 */

namespace system\models;

defined("CPATH") or die();

class Guides extends Model
{
    public function get($key)
    {
        $res = self::$db
            ->select("
                select c.id, i.name
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where c.external_id='{$key}' limit 1
              ")
            ->row();

        $res['items'] = self::$db
            ->select("
                select c.id, i.name, c.external_id
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where c.parent_id = {$res['id']} and c.status = 'published'
              ")
            ->all();

        return $res;
    }
}