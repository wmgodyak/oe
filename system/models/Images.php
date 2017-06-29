<?php

namespace system\models;
/**
 * Class ContentImages
 * @package system\models
 */
class Images extends Model
{
    /**
     * @param $content_id
     * @param null $size
     * @return array|mixed|string
     */
    public function cover($content_id, $size = null)
    {
        $image = self::$db
            ->select("select path, image from __content_images where content_id='{$content_id}' order by abs(position) asc limit 1")
            ->row();

        if(empty($image)) {
            return null;
        }

        if(!$size) return $image;

        return APPURL . $image['path'] . $size .'/'. $image['image'];
    }

    /**
     * @param $content_id
     * @param null $size
     * @param int $num
     * @param int $start
     * @return mixed|null
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id, $size = null, $num = 1000, $start = 0)
    {
        $items = self::$db
            ->select("
              select path, image
              from __content_images
              where content_id={$content_id}
              order by abs(position) asc limit {$start}, {$num}
              ")
            ->all();

        if(empty($items)) return null;

        if(!$size) return $items;

        foreach ($items as $k=>$item) {
            $items[$k]['src'] = APPURL . $item['path'] . $size . '/' . $item['image'];
        }

        return $items;
    }
}