<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */

namespace models\engine\plugins;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class ProductsVariants
 * @package models\engine\plugins
 */
class ProductsVariants extends Model
{
    private $variantsFeatures;
    private $variantsPrices;

    public function __construct()
    {
        parent::__construct();

        $this->variantsFeatures = new ProductsVariantsFeatures();
        $this->variantsPrices   = new ProductsVariantsPrices();
    }

    public function getMainCategory($content_id)
    {
        return self::$db
            ->select("select categories_id from content_relationship where content_id={$content_id} limit 1")
            ->row('categories_id');
    }

    public function get($content_id)
    {
        $r= self::$db->select("select id, in_stock, img from products_variants where content_id = '{$content_id}'")->all();
        $res = [];
        foreach ($r as $row) {
            $row['features'] = $this->variantsFeatures->get($row['id']);
            $row['prices']   = $this->variantsPrices->get($content_id, $row['id']);
            $res[] = $row;
        }
        return $res;
    }

    public function create($content_id)
    {
        $data = $this->request->post('data');
        if(empty($data)) return false;

        $this->beginTransaction();
        $variants_id = $this->createRow('products_variants', ['content_id' => $content_id, 'in_stock' => 1]);

        foreach ($data['features_id'] as $k=>$features_id) {
            $values_id = $data['values_id'][$k];
            $this->variantsFeatures->create($variants_id, $features_id, $values_id);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function update($content_id)
    {
        $variants = $this->request->post('variants');
        if(empty($variants)){
            $this->updateRow('content', $content_id, ['has_variants' => 0]);
            return;
        }


        foreach ($variants as $variant_id=>$a) {
            $this->updateRow('products_variants', $variant_id, ['in_stock' => $a['in_stock']]);
            foreach($a['prices'] as $group_id=>$price){
                $this->variantsPrices->set($content_id, $variant_id, $group_id, $price);
            }
        }

        $this->updateRow('content', $content_id, ['has_variants' => 1]);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('products_variants', $id);
    }

    public function uploadImage()
    {
        $variant_id = $this->request->post('variant_id', 'i');

        $allowed = ['image/png', 'image/jpeg']; $size = 500000; $s=0; $m=[]; $fname = null;

        $img = $_FILES['image'];

        if(!in_array($img['type'], $allowed)){
            $m = 'not_allowed';
        } elseif($variant_id == 0){
            $m = 'empty variant id';
        } elseif($img['size'] > $size){
            $m = 'max_size';
        } else {

            $path = "/uploads/content/" . date('Y/m/d/') . 'variants/';

            if(!is_dir(DOCROOT . $path)){
                @mkdir(DOCROOT . $path , 0777 , true);
            }

            $fname =  $path . md5($variant_id) . '.png';

            if(file_exists(DOCROOT . $fname)) unlink(DOCROOT. $fname);

            include_once DOCROOT . '/vendor/acimage/AcImage.php';

            $img = \AcImage::createImage($img['tmp_name']);
            $img->thumbnail(160, 120);
            $img->saveAsPNG(DOCROOT . $fname);

            $s= $this->updateRow('products_variants', $variant_id, ['img' =>$fname]);
        }

        return ['s' => $s, 'm' => $m, 'img' => $fname . '?_=' . time(), 'variant_id' => $variant_id];
    }
}