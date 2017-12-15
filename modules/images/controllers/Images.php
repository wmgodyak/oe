<?php

namespace modules\images\controllers;

use helpers\Image;
use helpers\Translit;
use system\Frontend;

defined("CPATH") or die();

/**
 * Class Images
 * @author OTAKOYI
 * @description Модуль для завантаження та керування зображеннями, а також для додавання та редагування розмірів їх розмірів в залежності від типу контенту
 * @name Зображення
 * @version 2.0.0
 * @package modules\images\controllers
 */
class Images extends Frontend
{
    private $ci;
    /**
     * Images module config
     * @var \stdClass
     */
    private $config;
    /**
     * Images module upload dir
     * @var string
     */
    private $uploaddir;
    /**
     * Images module thumbnails dir
     * @var string
     */
    private $thumbs_dir = 'thumbs/';
    /**
     * Images module thumbnails size
     * @var mixed
     */
    private $thumbs_size;
    /**
     * Images module source directory
     * @var string
     */
    private $source_dir = 'source/';
    /**
     * Images module source size
     * @var mixed
     */
    private $source_size;
    /**
     * Images module image quality
     * @var int
     */
    private $quality = 80;
    /**
     * Images module watermark directory
     * @var string
     */
    private $watermark_dir;

    public function __construct()
    {
        parent::__construct();

        $this->ci = new \modules\images\models\Images();
        $this->config = module_config('images');

        $this->uploaddir      = $this->config->images_dir . date('Y/m/d/');
        $this->thumbs_dir     = $this->config->images_thumb_dir;
        $this->thumbs_size    = $this->config->images_thumbs_size;
        $this->source_dir     = $this->config->images_source_dir;
        $this->source_size    = $this->config->images_source_size;
        $this->quality        = (int) $this->config->images_quality;
        $this->watermark_dir  = $this->config->images_watermark_dir;
    }

    public function init()
    {
        parent::init();

        //Module events
        events()->add('images.frontend.upload', [$this, 'upload']);
        events()->add('images.frontend.delete', [$this, 'delete']);
    }

    /**
     * Images module get cover
     * @param $content_id
     * @param null $size
     * @return array|mixed|string
     */
    public function cover($content_id, $size = null)
    {
        return $this->ci->cover($content_id, $size);
    }

    /**
     * Images module get images
     * @param $content_id
     * @param null $size
     * @param int $num
     * @param int $start
     * @return mixed|null
     */
    public function getImages($content_id, $size = null, $num = 1000, $start = 0)
    {
        return $this->ci->getImages($content_id, $size, $num, $start);
    }

    /**
     * Images module process image
     * @param $id
     */
    public function process($id)
    {
        events()->call('images.frontend.upload', ['content_id' => $id]);
    }
    /**
     * Images module delete images, but not from database
     * @param $content_id
     */
    public function remove($content_id)
    {
        $this->ci->deleteContentImages($content_id);
    }

    /**
     * Images module delete image
     * @param $id
     * @return bool
     */
    public function delete($id)
    {
        return $this->ci->delete($id);
    }

    /**
     * Images module sort images
     * @return array
     */
    public function sort()
    {
        $s = $this->ci->sort();
        return ['s' => $s];
    }

    /**
     * Images module upload image
     * @param $content_id
     * @return array
     */
    public function upload($content_id)
    {
        include_once DOCROOT . "vendor/acimage/AcImage.php";

        $s = false; $m = null; $fname = null; $image_id = 0;

        if (empty($content_id)) {
            $m = "Empty ContentID";
        }

        if (!isset($_FILES['image'])) {
            die('empty files img');
        }

        $image = $_FILES['image'];
        if (!empty($image['error'][0])) {

            switch ($image['error'][0]) {
                case '1':
                    $m = 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
                    break;
                case '2':
                    $m = 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
                    break;
                case '3':
                    $m = 'The uploaded file was only partially uploaded';
                    break;
                case '4':
                    $m = 'No file was uploaded.';
                    break;

                case '6':
                    $m = 'Missing a temporary folder';
                    break;
                case '7':
                    $m = 'Failed to write file to disk';
                    break;
                case '8':
                    $m = 'File upload stopped by extension';
                    break;
                case '999':
                default:
                    $m = 'No error code avaiable';
            }
        } elseif (empty($image['tmp_name'][0]) || $image['tmp_name'][0] == 'none') {
            $m = 'No file was uploaded..';
        }

        if (empty($m)) {
            $path  = $this->uploaddir;
            $fname = $image['name'][0];
            $ext = '.' . pathinfo($fname, PATHINFO_EXTENSION);
            $max_id = $this->ci->getLastInsertID($content_id);

            $fname = Translit::str2url(pathinfo($fname, PATHINFO_FILENAME)) . '-' . $content_id . 'x' . $max_id . $ext;

            $position  = $this->ci->getMaxSort($content_id); $position ++;

            $image_tmp  = $image['tmp_name'][0];

            $sizes = [];

            // default thumb & source sizes
            $source_dir = $this->source_dir;
            $source_s = $this->source_size;
            if (!empty($source_s)){
                $sz = explode('x',$source_s);
                $sizes[] = [
                    'size' => rtrim($source_dir, '/'),
                    'width' => $sz[0],
                    'height' => $sz[1],
                    'quality' => $this->quality,
                    'watermark' => 0
                ];
            }

            $thumb_dir  = $this->thumbs_dir;
            $thumb_s  = $this->thumbs_size;
            if (!empty($thumb_s)){
                $tz = explode('x',$thumb_s);

                $sizes[] = [
                    'size'   => rtrim($thumb_dir, '/'),
                    'width'  => $tz[0],
                    'height' => $tz[1],
                    'quality' => $this->quality,
                    'watermark' => 0
                ];
            }

            foreach ($this->ci->getSizes($content_id) as $item) {
                $sizes[] = $item;
            }

            $source_im = DOCROOT . $path . $source_dir . $fname;
            $source = null;

            if (!empty($sizes)) {
                foreach ($sizes as $size) {
                    $size['width']   = (int)$size['width'];
                    $size['height']  = (int)$size['height'];
                    $size['quality'] = (int)$size['quality'];

                    if (empty($size['width']) && empty($size['height'])) {
                        $m .= 'Empty width && height for size ' . $size['size'];
                        continue;
                    }

                    $image_tmp = $source ? $source : $image_tmp;
                    $img = \AcImage::createImage($image_tmp);
                    \AcImage::setRewrite(true);
                    \AcImage::setQuality($size['quality']);

                    $size_path = DOCROOT . $path . $size['size'] .'/';
                    if (!is_dir($size_path)) mkdir($size_path, 0775, true);

                    if ($size['width'] != -1 && $size['height'] != -1) {
                        if ($size['width'] == 0) {
                            $img->resizeByHeight($size['height']);
                        } elseif ($size['height'] == 0) {
                            $img->resizeByWidth($size['width']);
                        } elseif ($size['width'] == $size['height']) {
                            Image::createSquare($source_im, $size_path . '/' . $fname, $size['width']);
                            continue;
                        } else {
                            $img->resize($size['width'], $size['height']);
                        }
                    }

                    if ($size['watermark'] == 1 && $this->watermark_dir) {
                        $w_img = DOCROOT . $this->watermark_dir;
                        if (file_exists($w_img)) {
                            \AcImage::setMaxProportionLogo(0.40);
                            $img->drawLogo($w_img, (int)$size['watermark_position']);
                        }
                    }

                    $img->save($size_path . $fname);

                    if ($size['size'] == 'source') {
                        $source = $size_path.$fname;
                        events()->call('tinify.compress', $source);
                    }
                }
            }

            $image_id = $this->ci->create(array(
                'content_id' => $content_id,
                'position'   => $position,
                'path'       => $path,
                'image'      => $fname,
            ));

            $s = $image_id > 0;
        }

        return [
            's' => $s,
            'm' => $m,
            'p' => $this->uploaddir,
            'im' => $fname,
            'id' => $image_id
        ];
    }
}