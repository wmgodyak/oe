<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.03.16 : 17:31
 */

namespace models\engine\plugins;

use models\Engine;

defined("CPATH") or die();

class ContentImages extends Engine
{
    /**
     * @param $content_id
     * @return array|mixed
     */
    public function getMaxSort($content_id)
    {
        return self::$db
            ->select("select MAX(position) as t from content_images where content_id={$content_id}")
            ->row('t');
    }

    /**
     * @param $content_id
     * @return array|mixed
     */
    public function getLastInsertID($content_id)
    {
        return self::$db
            ->select("select MAX(id) as t from content_images where content_id={$content_id}")
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
                select s.size, s.width, s.height
                from content c
                join content_types_images_sizes cs on cs.types_id=c.types_id
                join content_images_sizes s on s.id=cs.images_sizes_id
                where c.id = {$content_id}
            ")
            ->all();
    }

    public function create($data)
    {
        return $this->createRow('content_images', $data);
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function get($content_id)
    {
        $thumb = \controllers\core\Settings::getInstance()->get('content_images_thumb_dir');
        return self::$db
            ->select("select id, CONCAT('/',path, '{$thumb}', image) as src from content_images where content_id={$content_id} order by abs(position) asc")
            ->all();
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        return parent::rowData('content_images', $id, $key);
    }

    public function delete($id)
    {
        $data = $this->getData($id);
        // визачити розміри
        $sizes = self::$db
            ->select("select cis.size
                      from content_images ci
                      join content c on c.id=ci.content_id
                      join content_types_images_sizes ctis on ctis.types_id=c.subtypes_id
                      join content_images_sizes cis on ctis.images_sizes_id=cis.id
                      where ci.id = {$id}")
            ->all('size');


        // source size
        $sizes[] = \controllers\core\Settings::getInstance()->get('content_images_thumb_dir');
        $sizes[] = \controllers\core\Settings::getInstance()->get('content_images_source_dir');

        if($this->hasDBError()) echo $this->getDBErrorMessage();

        $dir = \controllers\core\Settings::getInstance()->get('content_images_dir');

        foreach ($sizes as $size) {
            $path = str_replace('//', '/', DOCROOT . $dir . $data['path'] .  $size . '/' . $data['image']);
            @unlink($path);
        }

        $this->deleteRow('content_images', $id);

        return true;
    }

    public function deleteContentImages($content_id)
    {
        $items  = self::$db
            ->select("select path, image from content_images where content_id = {$content_id} ")
            ->all();

        if(empty($items)) return ;

        // визачити розміри
        $sizes = self::$db
            ->select("select cis.size
                      from content c
                      join content_types_images_sizes ctis on ctis.types_id=c.subtypes_id
                      join content_images_sizes cis on ctis.images_sizes_id=cis.id
                      where c.id = {$content_id}")
            ->all('size');

        $sizes[] = \controllers\core\Settings::getInstance()->get('content_images_thumb_dir');
        $sizes[] = \controllers\core\Settings::getInstance()->get('content_images_source_dir');

        if($this->hasDBError()) echo $this->getDBErrorMessage();

        foreach ($items as $item) {
            foreach ($sizes as $size) {
                $path = str_replace('//', '/', DOCROOT . $item['path'] .  $size . '/' . $item['image']);
                @unlink($path);
            }
        }
    }

    public function sort()
    {
        $order = $this->request->post('order');
        $s=0;
        $a = explode(',', $order);
        foreach ($a as $position=>$images_id) {
            $images_id = str_replace('im-', '', $images_id);
           $s+= $this->updateRow('content_images', $images_id, ['position' =>$position]);
        }

        return $s;
    }
}