<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 16:26
 */

namespace models\engine;

use helpers\Image;
use models\Engine;

defined("CPATH") or die();

/**
 * Class Banners
 * @package models\engine
 */
class Banners extends Engine
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key = '*')
    {
        $s = self::$db->select("select {$key} from banners where id={$id}")->row($key);
        return $s;
    }

    /**
     * @param $place_id
     */
    public function getSize($place_id)
    {
        return self::$db
            ->select("select width, height from banners_places where id={$place_id} limit 1")
            ->row();
    }

    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        $data['skey'] = md5(base64_encode(time()));

        if(!empty($data['df'])) {
            $data['df'] = date('Y-m-d', strtotime($data['df']));
        }

        if(!empty($data['dt'])) {
            $data['dt'] = date('Y-m-d', strtotime($data['dt']));
        }

        $id   = $this->createRow('banners', $data);
        if(isset($_FILES['image'])) {
            $size = $this->getSize($data['banners_places_id']);
            $this->uploadImage($id, $size);
        }

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        if(!empty($data['df'])) {
            $data['df'] = date('Y-m-d', strtotime($data['df']));
        }

        if(!empty($data['dt'])) {
            $data['dt'] = date('Y-m-d', strtotime($data['dt']));
        }
        $s = $this->updateRow('banners', $id, $data);
        if(isset($_FILES['image'])){

            $place_id = $this->getData($id, 'banners_places_id');
            $size = $this->getSize($place_id);
            $this->uploadImage($id, $size);

        }
        return $s;
    }

    private function uploadImage($banners_id, $size)
    {
        foreach ($size as $k=>$v) {
            $size[$k] = (int)$v;
        }

        $allowed = ['image/png', 'image/jpeg']; $s=0; $m=[]; $fname = null;

        $img = $_FILES['image'];

        if(!in_array($img['type'], $allowed)){
            $m = 'not_allowed';
        } else {

            $path = "/uploads/content/" . date('Y/m/d/');

            if(!is_dir(DOCROOT . $path)){
                @mkdir(DOCROOT . $path , 0777 , true);
            }

            $fname =  $path . md5($banners_id) . '.jpg';

            if(file_exists(DOCROOT . $fname)) unlink(DOCROOT. $fname);

            include_once DOCROOT . '/vendor/acimage/AcImage.php';

            $img = \AcImage::createImage($img['tmp_name']);
            if($size['width'] == 0) {
                $img->resizeByHeight($size['height']);
            } elseif($size['height'] == 0 ) {
                $img->resizeByWidth($size['width']);
            } /* elseif($size['width'] == $size['height']){
                Image::createSquare($source_im, $size_path .'/'. $fname, $size['width'] );
            } */else {
                $img->resize($size['width'], $size['height']);
            }

            $img->saveAsPNG(DOCROOT . $fname);

            $s= $this->updateRow('banners', $banners_id, ['img' => $fname]);
        }

        return ['s' => $s, 'm' => $m, 'img' => $fname . '?_=' . time()];
    }

    public function delete($id)
    {
        return self::$db->delete('banners', " id={$id} limit 1");
    }

    public function getLanguages()
    {
        $r = self::$db->select("select id,name from languages")->all();
        $res = [];
        foreach ($r as $row) {
            $res[$row['id']] = $row['name'];
        }
        return $res;
    }
}