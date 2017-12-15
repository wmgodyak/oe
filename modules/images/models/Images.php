<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 04.07.16 : 17:09
 */

namespace modules\images\models;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Images
 * @package modules\images\models
 */
class Images extends Model
{
    /**
     * Images module config
     * @var array
     */
    private $config;

    public function __construct()
    {
        parent::__construct();
        $this->config = module_config('images');
    }

    /**
     * @param $content_id
     * @return array|mixed
     */
    public function getMaxSort($content_id)
    {
        return self::$db
            ->select("select MAX(position) as t from __content_images where content_id={$content_id}")
            ->row('t');
    }

    /**
     * @param $content_id
     * @return array|mixed
     */
    public function getLastInsertID($content_id)
    {
        return self::$db
            ->select("select MAX(id) as t from __content_images where content_id={$content_id}")
            ->row('t');
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function getSizes($content_id)
    {
        return self::$db
            ->select
            ("
                select s.*
                from __content c
                join __content_types_images_sizes cs on cs.types_id=c.types_id
                join __content_images_sizes s on s.id=cs.images_sizes_id
                where c.id = {$content_id}
            ")
            ->all();
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create($data)
    {
        return $this->createRow('__content_images', $data);
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function get($content_id)
    {
        $thumb = $this->config->images_thumb_dir;
        return self::$db
            ->select("
                select id, CONCAT('/',path, '{$thumb}', image) as src from __content_images
                where content_id={$content_id} order by abs(position) asc
            ")->all();
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return parent::rowData('__content_images', $id, $key);
    }

    /**
     * @param $id
     * @return bool|int
     */
    public function delete($id)
    {
        $data = $this->getData($id);

        // get sizes for given content $id
        $getSizes = self::$db
            ->select("select cis.size
                      from __content_images ci
                      join __content c on c.id=ci.content_id
                      join __content_types_images_sizes ctis on ctis.types_id=c.subtypes_id
                      join __content_images_sizes cis on ctis.images_sizes_id=cis.id
                      where ci.id = {$id}")
            ->all('size');

        $sizes = [];
        if (!empty($getSizes)) {
            foreach ($getSizes as $size) {
                $sizes[] = $size;
            }
        }

        // default thumb & source sizes
        $sizes[] = $this->config->images_thumb_dir;
        $sizes[] = $this->config->images_source_dir;

        if ($this->hasError()) echo $this->getErrorMessage();

        $dir = isset($data['path']) ? $data['path'] : "";

        foreach ($sizes as $size) {
            $path = str_replace('//', '/',  DOCROOT . $dir .  $size . '/' . $data['image']);
            if (file_exists($path)) @unlink($path);
        }

        $s = $this->deleteRow('__content_images', $id);

        return $s;
    }

    /**
     * @param $content_id
     */
    public function deleteContentImages($content_id)
    {
        $items = self::$db
            ->select("select path, image from __content_images where content_id = {$content_id} ")
            ->all();

        if (empty($items)) return ;

        // get sizes for given content $id
        $getSizes = self::$db
            ->select("select cis.size
                      from __content c
                      join __content_types_images_sizes ctis on ctis.types_id=c.subtypes_id
                      join __content_images_sizes cis on ctis.images_sizes_id=cis.id
                      where c.id = {$content_id}")
            ->all('size');

        $sizes = [];
        if (!empty($getSizes)) {
            foreach ($getSizes as $size) {
                $sizes[] = $size;
            }
        }

        // default thumb & source sizes
        $sizes[] = $this->config->images_thumb_dir;
        $sizes[] = $this->config->images_source_dir;

        if ($this->hasError()) echo $this->getErrorMessage();

        foreach ($items as $item) {
            foreach ($sizes as $size) {
                $path = str_replace('//', '/', DOCROOT . $item['path'] .  $size . '/' . $item['image']);
                @unlink($path);
            }
        }
    }

    /**
     * @return bool|int
     */
    public function sort()
    {
        $order = $this->request->post('order');
        $s=0;
        $a = explode(',', $order);

        foreach ($a as $position=>$images_id) {
            $images_id = str_replace('im-', '', $images_id);
            $s += $this->updateRow('__content_images', $images_id, ['position' =>$position]);
        }

        return $s;
    }

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

        if (empty($image))
            return null;

        if (!$size)
            return $image;

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
    public function getImages($content_id, $size = null, $num = 1000, $start = 0)
    {
        $items = self::$db
            ->select("
              select path, image
              from __content_images
              where content_id={$content_id}
              order by abs(position) asc limit {$start}, {$num}
            ")->all();

        if (empty($items)) return null;

        if (!$size) return $items;

        foreach ($items as $k => $item) {
            $items[$k]['src'] = APPURL . $item['path'] . $size . '/' . $item['image'];
        }

        return $items;
    }
}