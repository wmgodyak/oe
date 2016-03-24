<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 16:26
 */

namespace models\engine;

use controllers\core\Settings;
use helpers\Image;
use models\Engine;

defined("CPATH") or die();

/**
 * Class ImagesSizes
 * @package models\engine
 */
class ContentImagesSizes extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from content_images_sizes where id={$id}")->row($key);

        if($key != '*') return $data;

        $data['types'] = $this->getSelectedTypes($id);

        return $data;
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data  = $this->request->post('data');
        $types = $this->request->post('types');
        $this->beginTransaction();

        $images_sizes_id = $this->createRow('content_images_sizes', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        if($types){

            foreach ($types as $k=>$types_id) {
                $this->createRow(
                    'content_types_images_sizes',
                    [
                        'types_id'        => $types_id,
                        'images_sizes_id' => $images_sizes_id
                    ]
                );

                if($this->hasDBError()){
                    $this->rollback();
                    return false;
                }
            }

        }

        $this->commit();
        return true;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $types = $this->request->post('types');

        $this->beginTransaction();

        $this->updateRow('content_images_sizes', $id, $data);

        if($this->hasDBError()){
            return false;
        }

        $selected = $this->getSelectedTypes($id);

        foreach ($types as $k=>$types_id) {

            if(isset($selected[$types_id])){
                unset($selected[$types_id]);
                continue;
            }

            $this->createRow(
                'content_types_images_sizes',
                [
                    'types_id'        => $types_id,
                    'images_sizes_id' => $id
                ]
            );

            if($this->hasDBError()){
                $this->rollback();
                return false;
            }
        }

        if(!empty($selected)){
            self::$db->delete('content_types_images_sizes', " images_sizes_id={$id} and types_id in (". implode(',', $selected) .")");
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function delete($id)
    {
        $items = self::$db
            -> select
                ("
                      select CONCAT(ci.path,cis.size, '/',ci.image) as img
                      from content_types_images_sizes ctis
                      join content_images_sizes cis on ctis.images_sizes_id=cis.id
                      join content c on c.subtypes_id=ctis.types_id
                      join content_images ci on ci.content_id=c.id
                      where ctis.images_sizes_id={$id}
                ")
            -> all('img');

        foreach ($items as $i=>$src) {
            @unlink(DOCROOT. $src);
        }

        return self::$db->delete('content_images_sizes', " id={$id} limit 1");
    }

    public function getContentTypes($parent_id)
    {
        $res = [];
        foreach (self::$db->select("select id, name, isfolder from content_types where parent_id={$parent_id}")->all() as $item) {
            if($item['isfolder']){
                $item['items'] = $this->getContentTypes($item['id']);
            }
            $res[] = $item;
        }
        return $res;
    }
    
    public function getSelectedTypes($images_sizes_id)
    {
        $r = [];
        foreach (self::$db->select("select types_id from content_types_images_sizes where images_sizes_id={$images_sizes_id}")->all() as $item) {
            $r[$item['types_id']] = $item['types_id'];
        }
        return $r;
    }

    public function resizeGetTotal($sizes_id)
    {
        return self::$db
            -> select
            ("
                  select count(ci.id) as t
                  from content_types_images_sizes ctis
                  join content c on c.subtypes_id=ctis.types_id and c.status='published'
                  join content_images_sizes cis on cis.id=ctis.images_sizes_id
                  join content_images ci on ci.content_id=c.id
                  where ctis.images_sizes_id={$sizes_id}
                ")
            -> row('t');
    }

    /**
     * @param $sizes_id
     * @param $start
     * @param int $num
     * @return mixed
     */
    public function resizeItems($sizes_id, $start, $num = 10)
    {
        $r = self::$db
            -> select
            ("
                  select ci.path, ci.image, cis.size, cis.width, cis.height, ci.content_id
                  from content_types_images_sizes ctis
                  join content c on c.subtypes_id=ctis.types_id and c.status='published'
                  join content_images_sizes cis on cis.id=ctis.images_sizes_id
                  join content_images ci on ci.content_id=c.id
                  where ctis.images_sizes_id={$sizes_id}
                  limit {$start}, {$num}
                ")
            -> all();

        echo $this->getDBErrorMessage();

        if(empty($r)) return 0;

        include_once DOCROOT . "vendor/acimage/AcImage.php";

        $source = Settings::getInstance()->get('content_images_source_dir');

        foreach ($r as $item) {

            $item['width']  = (int)$item['width'];
            $item['height'] = (int)$item['height'];

            $image_src  = DOCROOT . $item['path'] . $source . $item['image'];

            $img = \AcImage::createImage($image_src);
            \AcImage::setRewrite(true);
            \AcImage::setQuality(80);


            $size_path =  $item['path'] . $item['size'] .'/';

            $image_dest = $size_path . $item['image'];

            if(!is_dir($size_path)) mkdir($size_path, 0775, true);

            if($item['width'] == 0) {
                $img->resizeByHeight($item['height']);
                $img->save(DOCROOT . $image_dest);
            } elseif($item['height'] == 0 ) {
                $img->resizeByWidth($item['width']);
                $img->save(DOCROOT . $image_dest);
            } elseif($item['width'] == $item['height']){
               Image::createSquare($image_src, DOCROOT . $image_dest, $item['width'] );
            } else {
                $img->resize($item['width'], $item['height']);
                $img->save(DOCROOT . $image_dest);
            }
        }

        return true;
    }
}
