<?php

namespace system\components\contentImages\controllers;

use helpers\Image;
use helpers\Translit;
use system\core\EventsHandler;
use system\Backend;
use system\models\Settings;

defined("CPATH") or die();

class ContentImages extends Backend
{
    private $ci;
    /**
     * Upload dir
     * @var string
     */
    private $uploaddir;
    /**
     * thumbnails dir
     * @var string
     */
    private $thumnbs_dir = 'thumbs/';
    /**
     * source directory
     * @var string
     */
    private $source_dir  = 'source/';
    private $quality     = 80;

    public function __construct()
    {
        parent::__construct();

        $this->ci = new \system\components\contentImages\models\ContentImages();

        $this->uploaddir = Settings::getInstance()->get('content_images_dir') . date('Y/m/d/');

        $this->thumnbs_dir = Settings::getInstance()->get('content_images_thumb_dir');
        $this->source_dir  = Settings::getInstance()->get('content_images_source_dir');
        $this->quality     = (int) Settings::getInstance()->get('content_images_quality');

    }

    public function init()
    {
        EventsHandler::getInstance()->add('content.images',[$this, 'index']);
        EventsHandler::getInstance()->add('trash.remove',[$this, 'remove']);
    }

    public function index($content=null)
    {
        $this->template->assign('id', $content['id']);
        $this->template->assign('images', json_encode($this->ci->get($content['id'])));
        return $this->template->fetch('system/content/images/upload');
    }
    public function create()
    {

    }
    public function edit($id)
    {
    }
    public function delete($id)
    {
        echo $this->ci->delete($id);
    }

    public function process($id)
    {
    }

    public function remove($content_id)
    {
        $this->ci->deleteContentImages($content_id);
    }

    public function upload($content_id)
    {
        include_once DOCROOT . "vendor/acimage/AcImage.php";

        $s = false; $m = null; $fname = null; $image_id = 0;

        if(empty($content_id)){
            $m = "Empty ContentID";
        }

        if(!isset($_FILES['image'])) {
            die('empty files img');
        }

        $image = $_FILES['image'];
        if(!empty($image['error'][0]))
        {
            switch($image['error'][0])
            {
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
        } elseif(empty($image['tmp_name'][0]) || $image['tmp_name'][0] == 'none'){
            $m = 'No file was uploaded..';
        }

        if(empty($m)) {
            $path  = $this->uploaddir;
            $fname = $image['name'][0];
            $ext = '.' . pathinfo($fname, PATHINFO_EXTENSION);
            $max_id = $this->ci->getLastInsertID($content_id);

            $fname = Translit::str2url(pathinfo($fname, PATHINFO_FILENAME)) . '-' . $content_id . 'x' . $max_id . $ext;

            $position  = $this->ci->getMaxSort($content_id); $position ++;

            $image_tmp  = $image['tmp_name'][0];

            $sizes = [];

            // source size
            $source_dir = Settings::getInstance()->get('content_images_source_dir');
            $source_s = Settings::getInstance()->get('content_images_source_size');
            if(!empty($source_s)){
                $sz = explode('x',$source_s);
                $sizes[] =
                    [
                        'size' => rtrim($source_dir, '/'),
                        'width' => $sz[0],
                        'height' => $sz[1],
                        'quality' => $this->quality,
                        'watermark' => 0
                    ];
            }

            $thumb_dir  = Settings::getInstance()->get('content_images_thumb_dir');
            $thumb_s  = Settings::getInstance()->get('content_images_thumbs_size');
            if(!empty($thumb_s)){
                $tz = explode('x',$thumb_s);

                $sizes[] =
                    [
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

            if(!empty($sizes)){
                foreach($sizes as $size){

                    $size['width']   = (int)$size['width'];
                    $size['height']  = (int)$size['height'];
                    $size['quality'] = (int)$size['quality'];

                    if(empty($size['width']) && empty($size['height'])) {
                        $m .= 'Empty width && height for size ' . $size['size'];
                        continue;
                    }

                    $img = \AcImage::createImage($image_tmp);
                    \AcImage::setRewrite(true);
                    \AcImage::setQuality($size['quality']);

                    $size_path = DOCROOT . $path . $size['size'] .'/';

                    if(!is_dir($size_path)) mkdir($size_path, 0775, true);

                    if($size['width'] == 0) {
                        $img->resizeByHeight($size['height']);
                    } elseif($size['height'] == 0 ) {
                        $img->resizeByWidth($size['width']);
                    } elseif($size['width'] == $size['height']){
                        Image::createSquare($source_im, $size_path .'/'. $fname, $size['width'] );
                        continue;
                    } else {
                        $img->resize($size['width'], $size['height']);
                    }

                    if($size['watermark'] == 1 && $this->settings->get('watermark_src') != ''){
                        $w_img = DOCROOT . $this->settings->get('watermark_src');
                        if(file_exists($w_img)){
                            $img->drawLogo($w_img, (int)$size['watermark_position']);
                        }
                    }

                    $img->save($size_path . $fname);
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

        $this->response
            ->body
            (
                [
                    's' => $s,
                    'm' => $m,
                    'p' =>$this->uploaddir,
                    'im' => $fname,
                    'id' => $image_id
                ]
            )
            ->asJSON();
    }

    public function sort()
    {
        $s = $this->ci->sort();
        $this->response->body(['s' =>$s])->asJSON();
    }
}