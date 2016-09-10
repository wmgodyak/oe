<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 20:44
 */

namespace system\components\contentImagesSizes\models;

use helpers\Image;
use system\models\Engine;
use system\models\Settings;

/**
 * Class ContentImagesSizes
 * @package system\components\contentImagesSizes\models
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
        $data = self::$db->select("select {$key} from __content_images_sizes where id={$id}")->row($key);

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

        $images_sizes_id = $this->createRow('__content_images_sizes', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        if($types){

            foreach ($types as $k=>$types_id) {
                $this->createRow(
                    '__content_types_images_sizes',
                    [
                        'types_id'        => $types_id,
                        'images_sizes_id' => $images_sizes_id
                    ]
                );

                if($this->hasError()){
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

        $this->updateRow('__content_images_sizes', $id, $data);

        if($this->hasError()){
            return false;
        }

        $selected = $this->getSelectedTypes($id);

        foreach ($types as $k=>$types_id) {

            if(isset($selected[$types_id])){
                unset($selected[$types_id]);
                continue;
            }

            $this->createRow(
                '__content_types_images_sizes',
                [
                    'types_id'        => $types_id,
                    'images_sizes_id' => $id
                ]
            );

            if($this->hasError()){
                $this->rollback();
                return false;
            }
        }

        if(!empty($selected)){
            self::$db->delete('__content_types_images_sizes', " images_sizes_id={$id} and types_id in (". implode(',', $selected) .")");
        }

        if($this->hasError()){
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
                      from __content_types_images_sizes ctis
                      join __content_images_sizes cis on ctis.images_sizes_id=cis.id
                      join __content c on c.subtypes_id=ctis.types_id
                      join __content_images ci on ci.content_id=c.id
                      where ctis.images_sizes_id={$id}
                ")
            -> all('img');

        foreach ($items as $i=>$src) {
            if(file_exists(DOCROOT. $src)){
                @unlink(DOCROOT. $src);
            }
        }

        return self::$db->delete('__content_images_sizes', " id={$id} limit 1");
    }

    public function getContentTypes($parent_id)
    {
        $res = [];
        foreach (self::$db->select("select id, name, isfolder from __content_types where parent_id={$parent_id}")->all() as $item) {
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
        foreach (self::$db->select("select types_id from __content_types_images_sizes where images_sizes_id={$images_sizes_id}")->all() as $item) {
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
                  from __content_types_images_sizes ctis
                  join __content c on c.subtypes_id=ctis.types_id and c.status='published'
                  join __content_images_sizes cis on cis.id=ctis.images_sizes_id
                  join __content_images ci on ci.content_id=c.id
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
    public function resizeItems($sizes_id, $start, $num = 1)
    {
        $r = self::$db
            -> select
            ("
                  select ci.path, ci.image, cis.size, cis.width, cis.height,cis.quality, cis.watermark,cis.watermark_position, ci.content_id
                  from __content_types_images_sizes ctis
                  join __content c on c.subtypes_id=ctis.types_id and c.status='published'
                  join __content_images_sizes cis on cis.id=ctis.images_sizes_id
                  join __content_images ci on ci.content_id=c.id
                  where ctis.images_sizes_id={$sizes_id}
                  limit {$start}, {$num}
                ")
            -> all();

        echo $this->getErrorMessage();

        if(empty($r)) return 0;

        include_once DOCROOT . "vendor/acimage/AcImage.php";

        $watermark_src = Settings::getInstance()->get('watermark_src');
        $source = Settings::getInstance()->get('content_images_source_dir');

        foreach ($r as $item) {

            $item['width']  = (int)$item['width'];
            $item['height'] = (int)$item['height'];
            $item['quality'] = (int)$item['quality'];

            $image_src  = DOCROOT . $item['path'] . $source . $item['image'];

            $img = \AcImage::createImage($image_src);
            \AcImage::setRewrite(true);
            \AcImage::setQuality($item['quality']);


            $size_path =  $item['path'] . $item['size'] .'/';

            $image_dest = $size_path . $item['image'];

            if(!is_dir(DOCROOT. $size_path)) mkdir(DOCROOT . $size_path, 0775, true);

            if($item['width'] == 0) {
                $img->resizeByHeight($item['height']);
            } elseif($item['height'] == 0 ) {
                $img->resizeByWidth($item['width']);
            } elseif($item['width'] == $item['height']){
                Image::createSquare($image_src, DOCROOT . $image_dest, $item['width'] , $item['quality']);
                continue;
            } else {
                $img->resize($item['width'], $item['height']);
            }

            if($item['watermark'] == 1 && $watermark_src != ''){
                $w_img = DOCROOT . $watermark_src;
                if(file_exists($w_img)){
                    $img->drawLogo($w_img, $item['watermark_position']);
                }
            }

            $img->save(DOCROOT . $image_dest);
        }

        return true;
    }
}