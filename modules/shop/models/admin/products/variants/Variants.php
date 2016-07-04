<?php

namespace modules\shop\models\admin\products\variants;

use modules\shop\models\admin\products\Features;

class Variants extends \modules\shop\models\products\variants\Variants
{
    private $pv;
    private $pvf;
    private $features;

    public function __construct()
    {
        parent::__construct();

        $this->pv = new ProductsVariants();
        $this->pvf = new ProductsVariantsFeatures();
        $this->features = new Features();
    }

    public function create($content_id)
    {
        $features = $this->request->post('features');
        if(empty($features)) return false;

        $this->beginTransaction();

        $_features = []; $values = [];

        foreach ($features as $k=>$features_id) {
            $v = $this->features->getValues($features_id);
            foreach ($v as $item) {
                $values[$features_id][] = $item['id'];
                $_features[$features_id][] = $item['id'];
            }
        }

        $variants = [];
        $variant = [];
//        foreach ($features as $k=>$features_id) {

//            foreach ($values[$features_id] as $i=>$values_id) {
//
//            }
//        }

        foreach ($values[$features[0]] as $i=>$values_id) {
            $variant[] = [
                'features_id' => $features[0],
                'values_id'   => $values_id
            ];
        }

//        d($_features);
        /*
Array
(
    [160] => Array
        (
            [0] => 172
            [1] => 173
            [2] => 180
        )

    [151] => Array
        (
            [0] => 165
            [1] => 181
        )

)
        */


//        for($i=0;$i<count($_features); $i++){
//            $a = [];
//            $a[$_features[$i]]
//        }

        die;
        $variants_id = $this->pv->create($content_id);

        foreach ($data['features_id'] as $k=>$features_id) {
            $values_id = $data['values_id'][$k];
            $this->pvf->create($variants_id, $features_id, $values_id);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }


    public function get($content_id)
    {
        $r= self::$db->select("select id, in_stock, img from __products_variants where content_id = '{$content_id}' ")->all();
        $res = [];
        foreach ($r as $row) {
            $row['features'] = $this->variantsFeatures->get($row['id']);
            $row['prices']   = $this->variantsPrices->get($content_id, $row['id']);
            $res[] = $row;
        }
        return $res;
    }


    public function update($content_id)
    {
        $variants = $this->request->post('variants');
        if(empty($variants)){
            $this->updateRow('__content', $content_id, ['has_variants' => 0]);
            return;
        }


        foreach ($variants as $variant_id=>$a) {
            $this->updateRow('__products_variants', $variant_id, ['in_stock' => $a['in_stock']]);
            foreach($a['prices'] as $group_id=>$price){
                $this->variantsPrices->set($content_id, $variant_id, $group_id, $price);
            }
        }

        $this->updateRow('__content', $content_id, ['has_variants' => 1]);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('__products_variants', $id);
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

            $s= $this->updateRow('__products_variants', $variant_id, ['img' =>$fname]);
        }

        return ['s' => $s, 'm' => $m, 'img' => $fname . '?_=' . time(), 'variant_id' => $variant_id];
    }
}