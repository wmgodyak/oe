<?php

namespace modules\fixes\controllers;

use helpers\Translit;
use system\components\contentImages\models\ContentImages;
use system\core\DB;
use system\core\exceptions\Exception;
use system\core\Logger;
use system\Front;

class Fixes extends Front
{
    private $db;

    public function __construct()
    {
        parent::__construct();

        $this->db = DB::getInstance();
        $this->images = new ContentImages();
    }

    public function generateUrl()
    {
        $p = isset($_GET['p']) ? $_GET['p'] : 0; $num = 100;
        $start = $p * $num;

        $r = $this->db
            ->select("
                select i.id, i.name, i.url
                from __content c
                join __content_info i on i.content_id=c.id
                where c.types_id = 23
                limit {$start}, {$num}
                ")
            ->all();

        if(empty($r)) return;

        foreach ($r as $item) {
            $url = Translit::str2url($item['name']);
            try {
                $this->db->update('__content_info', ['url' => $url], " id={$item['id']} limit 1");
            } catch(Exception $e){
                $this->db->update('__content_info', ['url' => $url . '-' . $item['id']], " id={$item['id']} limit 1");
            }

        }

        $p++;
        echo "<script>self.location.href='/route/Fixes/generateUrl?p={$p}';</script>";
    }

    /**
     * http://engine.loc/route/Fixes/parseMage
     * @throws Exception
     */
    public function parseMage()
    {
        Logger::init('mage');
        echo '<pre>';
        $conf = [
            'type'     => 'mysql',
            'host'     => '185.25.117.79',
            'db'       => 'cma',
            'prefix'   => '',
            'user'     => 'v',
            'pass'     => 'v',
            'port'     => 3306,
            'charset'  => 'utf8',
            'debug'    => true
        ];

        $dsn = new DB($conf);
//        var_dump($cdb);die;
        $num = 20;
        $p = isset($_GET['p']) ? (int)$_GET['p'] : 0;
        $start = $p * $num;

        $r = $this->db->select("select id, external_id from __content where types_id=23  order by abs(id) asc limit {$start}, {$num}",1)->all();
        foreach ($r as $item) {
            $entity_id = $dsn->select("select entity_id from catalog_product_entity where sku = '{$item['external_id']}' limit 1")->row('entity_id');
            if(empty($entity_id)) continue;
            // image
            $image = null;
            $path = "https://cma.lviv.ua/media/catalog/product/";
            $im   = $this->getEntityVarchar($entity_id, 85, 0, $dsn);
            if(!empty($im)){
                $image = $path . $im;
            }

            // description
            $description = $this->getEntityText($entity_id, 73, 0, $dsn);
            $content     = $this->getEntityText($entity_id, 72, 0, $dsn);

            $gallery = $this->getEntityMediaGallery($entity_id, $dsn);

            $s = $this->db->update('__content_info', ['description' => $description, 'content' => $content], "id={$item['id']} limit 1");

            if($s){
                Logger::log("Updated {$item['id']}    mage_id:    {$entity_id}");
            }

            if(!empty($image)){
              $s =  $this->saveImage($image, $item['id']);
              if($s){
                Logger::log("Save cover image {$item['id']}    mage_id:    {$entity_id}    {$image}");
              }
            }

            if(!empty($gallery)){
                foreach ($gallery as $k=>$img) {
                    $s =  $this->saveImage($path . $img['value'], $item['id']);
                    if($s){
                        Logger::log("Save gallery image {$item['id']}    mage_id:    {$entity_id}    {$path}{$img['value']}");
                    }
                }
            }
        }
//        die;
        $p ++;

        echo "<script>self.location.href='/route/Fixes/parseMage?p={$p}';</script>";
    }


    private function saveImage($url, $content_id)
    {
        $path = 'uploads/content/' . date('Y/m/d/H/i/');
        $source  = 'source/';
        if(!is_dir(DOCROOT . $path)){
            mkdir(DOCROOT .$path . $source, 0777, true);
        }

        $a = explode('/', $url);
        $name = end($a);
        $s = file_put_contents( DOCROOT . $path . $source . $name, file_get_contents($url));
        if($s){
            return $this->images->create
            (
                [
                    'content_id' => $content_id,
                    'path'       => $path,
                    'image'      => $name
                ]
            );
        }

        return false;
    }

    private function getEntityVarchar($entity_id, $attribute_id, $store_id, $dsn)
    {
        return $dsn
            ->select("
                  select value
                  from catalog_product_entity_varchar
                  where entity_id = {$entity_id} and attribute_id={$attribute_id} and store_id={$store_id}
                  ")
            ->row('value');
    }

    private function getEntityText($entity_id, $attribute_id, $store_id, $dsn)
    {
        return $dsn
            ->select("
                  select value
                  from catalog_product_entity_text
                  where entity_id = {$entity_id} and attribute_id={$attribute_id} and store_id={$store_id}
                  ")
            ->row('value');
    }

    private function getEntityMediaGallery($entity_id, $dsn)
    {
        return $dsn
            ->select("
                  select value
                  from catalog_product_entity_media_gallery
                  where entity_id = {$entity_id} and attribute_id=88
                  ")
            ->all();
    }
}