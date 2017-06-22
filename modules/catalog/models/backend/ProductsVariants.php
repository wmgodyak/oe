<?php

namespace modules\catalog\models\backend;

use system\models\Backend;

class ProductsVariants extends Backend
{
    private $pv;
    private $pvf;
    private $features;
    private $pp;
    private $ug;
    private $pvp;

    public function __construct()
    {
        parent::__construct();

        $this->pv = new ProductsVariants();
        $this->pvf = new ProductsVariantsFeatures();
        $this->features = new Features();
        $this->pp = new Prices();
        $this->ug = new UsersGroup();
        $this->pvp = new ProductsVariantsPrices();
    }

    public function create($content_id)
    {
        $features = $this->request->post('features');
        if(empty($features)) return false;

        $this->beginTransaction();

        $values = [];

        foreach ($features as $k=>$features_id) {
            $v = $this->features->getValues($features_id);
            foreach ($v as $item) {
                $values[$features_id][] = $item['id'];
            }
        }

        $variants = $this->generateVariants($values);

        foreach ($variants as $k=>$a) {
            $variants_id = $this->pv->create($content_id);

            foreach ($a as $features_id => $values_id) {
                $this->pvf->create($variants_id, $features_id, $values_id);
            }

            $prices = $this->pp->get($content_id);
            foreach ($this->ug->getItems(0) as $item) {
                $price = isset($prices[$item['id']]) ? $prices[$item['id']] : 0;
                $this->pvp->create($variants_id, $content_id, $item['id'], $price);
            }
        }

        self::$db->update('__products',['has_variants' => 1], "content_id = {$content_id} limit 1");
//        $this->updateRow('__content', $content_id, ['has_variants' => 1]);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    /**
     * Generate products variants based on selected features
     * @param $a
     * @param null $m
     * @param null $e
     * @return array
     * @author Vitaliy Stupak at Otakoyi.com
     */
    private function generateVariants($a, $m = null, $e = null)
    {
        $res = [];
        if (!$e) {
            $e = 1;
            foreach ($a as $k => $v) {
                $e *= count($v);
            }
        }

        $e--;

        if ($e < 0) return $res;

        if (!$m) {
            foreach ($a as $k => $v) {
                $m[$k] = 0;
            }
        }

        $r = [];

        foreach ($a as $k => $v) {
            $r[$k] = $v[$m[$k]];
        }
        $res[] = $r;

        $s = false;
        foreach (array_reverse($m, true) as $k => $v) {
            if (($v < (count($a[$k]) - 1)) && $s == false) {
                $m[$k]++;
                $s = true;
            } else {
                if ($s == false) {
                    $m[$k] = 0;
                }
            }
        }

        if ($s) $res = array_merge($res, $this->generateVariants($a, $m, $e));

        return $res;
    }

    public function get($content_id)
    {
        $r= self::$db->select("select id, in_stock, img from __products_variants where content_id = '{$content_id}' ")->all();
        $res = [];
        foreach ($r as $row) {
            $row['features'] = $this->pvf->get($row['id']);
            $row['prices']   = $this->pvp->get($content_id, $row['id']);
            $res[] = $row;
        }
        return $res;
    }


    public function update($content_id)
    {
        $variants = $this->request->post('variants');
        if(empty($variants)){
            self::$db->update('__products',['has_variants' => 0], "content_id = {$content_id} limit 1");
//            $this->updateRow('__products', $content_id, ['has_variants' => 0]);
            return;
        }

        foreach ($variants as $variant_id=>$a) {
            $this->updateRow('__products_variants', $variant_id, ['in_stock' => $a['in_stock']]);
            foreach($a['prices'] as $group_id=>$price){
                $this->pvp->set($content_id, $variant_id, $group_id, $price);
            }
        }
        self::$db->update('__products',['has_variants' => 1], "content_id = {$content_id} limit 1");
//        $this->updateRow('__content', $content_id, ['has_variants' => 1]);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        $content_id = self::$db->select("select content_id from __products_variants where id={$id} limit 1")->row('content_id');
        if(empty($content_id)) return false;

        $t = self::$db->select("select count(id) as t from __products_variants where content_id={$content_id}")->row('t');

        $this->deleteRow('__products_variants', $id);

        if($t == 1){
            self::$db->update('__products',['has_variants' => 0], "content_id = {$content_id} limit 1");
//            $this->updateRow('__content', $content_id, ['has_variants' => 0]);
        }

        return true;
    }

    public function deleteAll($content_id)
    {
        return self::$db->delete('__products_variants', " content_id = {$content_id}");
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