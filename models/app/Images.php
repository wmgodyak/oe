<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 13:40
 */

namespace models\app;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class Images
 * @package models\app
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
            ->select("select path, image from content_images where content_id={$content_id} order by abs(position) asc limit 1")
            ->row();

        if(empty($image)) return null;

        if(!$size) return $image;

        return $image['path'] . $size .'/'. $image['image'];
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
              from content_images
              where content_id={$content_id}
              order by abs(position) asc limit {$start}, {$num}
              ")
            ->all();

        if(empty($items)) return null;

        if(!$size) return $items;

        foreach ($items as $k=>$item) {
            $items[$k]['src'] = $item['path'] . $size . '/' . $item['image'];
        }

        return $items;
    }
}