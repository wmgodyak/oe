<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.02.16 : 15:24
 */
namespace controllers\engine\plugins;

use controllers\core\Event;
use controllers\core\Settings;
use controllers\engine\Plugin;
use helpers\Image;
use helpers\Translit;

defined("CPATH") or die();
/**
 * Class ContentImages
 * @name ContentImages
 * @icon fa-picture-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class ContentImages extends Plugin
{
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
    private $quality     = 0;
    private $mContentImages;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index', 'delete', 'process'];

        $this->uploaddir = Settings::getInstance()->get('content_images_dir') . date('Y/m/d/');

        $this->mContentImages = new \models\engine\plugins\ContentImages();

        $this->thumnbs_dir = Settings::getInstance()->get('content_images_thumb_dir');
        $this->source_dir  = Settings::getInstance()->get('content_images_source_dir');
        $this->quality     = (int) Settings::getInstance()->get('content_images_quality');
        if($this->quality == 0) $this->quality = 60;

        Event::listen
        (
            'controllers\engine\Content::beforeDrop',
            'controllers\engine\plugins\ContentImages::onDropContent'
        );
    }

    public function index()
    {

    }

    public function create()
    {
        $this->template->assign('images', json_encode([]));
        return $this->template->fetch('plugins/content/images/upload');
    }

    public function edit($id)
    {
        $this->template->assign('id', $id);
        $this->template->assign('images', json_encode($this->mContentImages->get($id)));
        return $this->template->fetch('plugins/content/images/upload');
    }

    public function delete($id)
    {
        return $this->mContentImages->delete($id);
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }

    public function onDropContent($content_id)
    {
        $this->mContentImages->deleteContentImages($content_id);
    }

    public function upload($content_id)
    {
        include_once DOCROOT . "vendor/acimage/AcImage.php";

        $s = false; $m = null; $fname = null; $image_id = 0;

        if(empty($content_id)){
            $m = "Empty ContentID";
        }

        if(!isset($_FILES['image'])) {
            $this->dump($_FILES);
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
            $max_id = $this->mContentImages->getLastInsertID($content_id);

            $fname = Translit::str2url(pathinfo($fname, PATHINFO_FILENAME)) . '-' . $content_id . 'x' . $max_id . $ext;

            $position  = $this->mContentImages->getMaxSort($content_id); $position ++;

            $image_tmp  = $image['tmp_name'][0];

                $sizes = $this->mContentImages->getSizes($content_id);

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
                        ];
                }

                $source_im = DOCROOT . $path . $source_dir . $fname;

                if(!empty($sizes)){
                    foreach($sizes as $size){
                        $size['width']  = (int)$size['width'];
                        $size['height'] = (int)$size['height'];

                        if(empty($size['width']) && empty($size['height'])) continue;

                        $img = \AcImage::createImage($image_tmp);
                        \AcImage::setRewrite(true);
                        \AcImage::setQuality($this->quality);

                        $size_path = DOCROOT . $path . $size['size'] .'/';

                        if(!is_dir($size_path)) mkdir($size_path, 0775, true);

                        if($size['width'] == 0) {
                            $img->resizeByHeight($size['height']);
                            $img->save($size_path . $fname);
                        } elseif($size['height'] == 0 ) {
                            $img->resizeByWidth($size['width']);
                            $img->save($size_path . $fname);
                        } elseif($size['width'] == $size['height']){
                            Image::createSquare($source_im, $size_path .'/'. $fname, $size['width'] );
                        } else {
                            $img->resize($size['width'], $size['height']);
                            $img->save($size_path . $fname);
                        }
                    }
                }

                $image_id = $this->mContentImages->create(array(
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
        $s = $this->mContentImages->sort();
        $this->response->body(['s' =>$s])->asJSON();
    }
}