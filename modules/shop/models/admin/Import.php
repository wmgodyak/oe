<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 07.07.16 : 16:29
 */

namespace modules\shop\models\admin;

use helpers\Translit;
use system\components\contentImages\models\ContentImages;
use system\models\ContentRelationship;
use system\models\Currency;
use system\models\Languages;
use system\models\Model;
use system\models\UsersGroup;

defined("CPATH") or die();

/**
 * Class Import
 * @package modules\shop\models\admin
 */
class Import extends Model
{
    private $cat_type_id;
    private $cat_sub_type_id;

    private $product_type_id;
    private $product_sub_type_id;


    private $owner;
    private $languages;
    private $domain;
    private $currency;
    private $currency_id;

    private $contentRelations;
    private $productsPrices;
    private $usersGroup;
    private $images;

    public $log = [];

    public function __construct($languages_id, $owner, $domain, $currency)
    {
        parent::__construct();

        $this->languages_id = $languages_id;
        $this->owner  = $owner;
        $this->domain = $domain;
        $this->currency = $currency;

        $_currency = new Currency();

        $this->currency_id = $_currency->getIdByCode($currency);

        $this->languages = new Languages();

        $this->cat_type_id = $this->getContentTypeIDByType('products_categories');
        $this->cat_sub_type_id = $this->cat_type_id;

        $this->product_type_id = $this->getContentTypeIDByType('product');
        $this->product_sub_type_id = $this->product_type_id;

        $this->contentRelations = new ContentRelationship();
        $this->productsPrices   = new \modules\shop\models\admin\Prices();
        $this->usersGroup = new UsersGroup();
        $this->images = new ContentImages();

    }

    public function checkCurrency()
    {
        if(empty($this->currency_id)){
            $this->log[] = "Помилка, створіть валюту {$this->currency}";
            return false;
        }

        return true;
    }

    public function category($ex_id, $name, $ex_parentId = 0)
    {
        $id = $this->getContentIdByExID($ex_id);

        if($id){
            return true;
        }

        $parent_id = 0;

        if($ex_parentId > 0){
            $parent_id = $this->getContentIdByExID($ex_parentId);
        }

        $this->beginTransaction();

        $content_id = parent::createRow
        (
            '__content',
            [
                'parent_id'    => $parent_id,
                'types_id'     => $this->cat_type_id,
                'subtypes_id'  => $this->cat_sub_type_id,
                'owner_id'     => $this->owner['id'],
                'external_id'  => $ex_id,
                'status'       => 'published'
            ]
        );

        foreach ($this->languages->get() as $lang) {
            $a =
                [
                    'content_id'   => $content_id,
                    'languages_id' => $lang['id'],
                    'name'         => $name,
                    'url'          => Translit::str2url($name)
                ];
            parent::createRow('__content_info', $a);
        }

        if($this->hasError()){
            $this->log[] = 'Помилка при створенні категорії. ' . $this->getError();
            $this->rollback();
            return false;
        }

        $this->log[] = "Створено #$content_id $name. ";
        $this->commit();

        return true;
    }

    public function product
    (
        $ex_id,
        $name,
        $url,
        $category_ex_id,
        $price,
        $in_stock,
        $image,
        $description,
        $vendor,
        $warranty
    )
    {
        $id = $this->getContentIdByExID($ex_id);

        if($id){
            return true;
        }

        $category_id = 0;

        if($category_ex_id > 0){
            $category_id = $this->getContentIdByExID($category_ex_id);
        }

        $this->beginTransaction();

        $content_id = parent::createRow
        (
            '__content',
            [
                'types_id'     => $this->product_type_id,
                'subtypes_id'  => $this->product_sub_type_id,
                'owner_id'     => $this->owner['id'],
                'sku'          => $ex_id,
                'external_id'  => $ex_id,
                'in_stock'     => $in_stock,
                'currency_id'  => $this->currency_id,
                'status'       => 'published'
            ]
        );

        $url = preg_replace("@((www|.html|{$this->domain}|http://|https://)[^ ]+)@", '\1', $url);

        foreach ($this->languages->get() as $lang) {
            $a =
                [
                    'content_id'   => $content_id,
                    'languages_id' => $lang['id'],
                    'name'         => $name,
                    'description'  => $description,
                    'content'      => $description,
                    'url'          => $url
                ];
            parent::createRow('__content_info', $a);
        }

        if($this->hasError()){
            $this->log[] = 'Помилка при створенні товару. ' . $this->getError();
            $this->rollback();

            return false;
        }

        // створю категорію
        if($category_id > 0){
            $this->contentRelations->create($content_id, $category_id, 1);
        }

        if($this->hasError()){
            $this->log[] = 'Помилка при створенні товару. ' . $this->getError();
            $this->rollback();

            return false;
        }

        // ціни
        foreach ($this->usersGroup->getItems(0, 0) as $group) {
            $this->productsPrices->create($content_id, $group['id'], $price);
        }

        if($this->hasError()){
            $this->log[] = 'Помилка при створенні товару. ' . $this->getError();
            $this->rollback();

            return false;
        }

        // зображення
        if(! empty($image)){
            if(! $this->saveImage($image, $content_id)){
                $this->rollback();
                $this->log[] = "Помилка при збереженні зображення";
                return false;
            };
        }

        if($this->hasError()){
            $this->log[] = 'Помилка при створенні товару. ' . $this->getError();
            $this->rollback();

            return false;
        }

        $this->log[] = "Створено #$content_id $name. ";
        $this->commit();

        return true;
    }

    private function saveImage($url, $content_id)
    {
        $path = 'uploads/content/' . date('Y/m/d/H/i/');
        $source  = 'source/';
        $thumbs = 'thumbs/';
        if(!is_dir(DOCROOT . $path)){
            mkdir(DOCROOT .$path . $source, 0777, true);
            mkdir(DOCROOT .$path . $thumbs, 0777, true);
        }

        $a = explode('/', $url);
        $name = end($a);
             file_put_contents( DOCROOT . $path . $source . $name, file_get_contents($url));
        $s = file_put_contents( DOCROOT . $path . $thumbs . $name, file_get_contents($url));
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

    private function getContentIdByExID($external_id)
    {
        return self::$db->select("select id from __content where external_id='{$external_id}' limit 1")->row('id');
    }


    private function getContentTypeIDByType($type)
    {
        return self::$db
            -> select("select id from __content_types where type = '{$type}' and parent_id = 0  limit 1")
            -> row('id');
    }
}