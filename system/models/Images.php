<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 18.06.16
 * Time: 16:40
 */

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
            return "uploads/noimage.jpg";
        }

        if(!$size) return $image;

        return APPURL . $image['path'] . $size .'/'. $image['image'];
    }

    /**
     * @param $content_id
     * @param null $size
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function get($content_id, $size = null, $start = 0, $num = 1000)
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