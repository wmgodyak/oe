<?php

namespace modules\shopExport\controllers;

use helpers\Translit;
use system\models\App;
use system\models\Currency;
use system\models\Images;
use system\models\Languages;
use system\models\Settings;

class ShopExport
{
    const NS = '\modules\shopExport\models\adapters\\';
    private $se;

    private $search = array('<', '>', '&', "'", '"');
    private $replace = array('&lt;', '&gt;', '&amp;', '&apos;', '&quot;');

    public function __construct()
    {
        $this->se = new \modules\shopExport\models\ShopExport();
    }


    public function init(){}

    public function run($adapter = null)
    {
        if(! $adapter) die;

        $adapter = ucfirst($adapter);

        $s = Settings::getInstance()->get('modules.ShopExport.status');
        if($s != 'enabled') die;

        $data = [];
        $aSettings = Settings::getInstance()->get('modules.ShopExport.config.adapter');
        $settings = $aSettings[$adapter];
        if($settings['enabled'] == 0) die;
//        d($settings);//die;

        $currency = new Currency();
        $settings['currency'] = $currency->getMeta($settings['currency_id']);

        $images = new Images();
        $languages = new Languages();
        $s_language = $languages->getData($settings['languages_id']);
        $m_language = $languages->getDefault();

        $app = new App();

        $selected_categories = Settings::getInstance()->get("shop_export_{$adapter}_categories");

        $categories = $this->se->getCategories($selected_categories, $settings['languages_id']);

        if(!empty($categories)){

            $products = $this->se->getProducts($categories, $settings);
            foreach ($products as $k=>$product) {
                if($settings['markup'] > 0){
                    $products[$k]['price'] = $product['price'] + ($product['price'] * ($settings['markup'] / 100) );
                }

                $products[$k]['image'] =$images->cover($product['id'], 'product');

                if($s_language['id'] != $m_language['id']){
                    $products[$k]['url'] = $s_language['code'] . '/' . $product['url'];
                }

                if($settings['track'] == 1){
                    $utm_campaign = $adapter;
                    $utm_content  = $app->page->name($product['categories_id']);
                    $utm_content  = Translit::str2url($utm_content);
                    $utm_term     = Translit::str2url($product['name']);
                    $utm = "?utm_source=promua&utm_medium=cpc&utm_campaign={$utm_campaign}&utm_content={$utm_content}&utm_term={$utm_term}";
                    $utm = str_replace($this->search, $this->replace, $utm);
                    $products[$k]['url'] .= $utm;
                }
            }
            $data['categories'] = $categories;
            $data['products']   = $products;
        }

        $settings['company']  = Settings::getInstance()->get('company_name');

        $sm = self::create($adapter, $data, $settings);

        $sm->export();
    }

    private static function create($adapter, $data, $settings = null)
    {
        $adapter = ucfirst($adapter);
        if (!class_exists( self::NS . $adapter)) {
            throw new \Exception("Wrong adapter. {$adapter} ");
        }

        $c = self::NS . $adapter;

        return new $c($data, $settings);
    }

}