<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\shop\controllers;

use helpers\Pagination;
use modules\shop\models\Categories;
use modules\shop\models\categories\Features;
use modules\shop\models\Products;
use modules\shop\models\products\Accessories;
use modules\shop\models\products\Comparison;
use modules\shop\models\products\Kits;
use modules\shop\models\products\Prices;
use modules\shop\models\products\variants\ProductsVariants;
use modules\shop\models\SearchHistory;
use system\core\DataFilter;
use system\core\Session;
use system\Front;
use system\models\ContentRelationship;
use system\models\Currency;
use system\models\Settings;

/**
 * Class shop
 * @name Магазин
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\shop\controllers
 */
class Shop extends Front
{
    private $products;
    private $categories;
    private $ipp;
    private $total;
    private $group_id;
    private $bonus_rate;
    private $prices;
    private $currency;

    public $search;
    public $variants;

    public $comparison;
    private $relations;

    public function __construct()
    {
        parent::__construct();

        $this->group_id   = Settings::getInstance()->get('modules.Shop.config.group_id');
        $this->ipp        = Settings::getInstance()->get('modules.Shop.config.ipp');
        $this->bonus_rate = Settings::getInstance()->get('modules.Shop.config.bonus_rate');

        $this->products   = new Products('product');
        $this->categories = new Categories('products_categories');
        $this->prices     = new Prices();
        $this->currency   = new Currency();

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : $this->group_id;

        $this->search = new Search($this->products , $this->group_id );

        $this->variants = new ProductsVariants();

        $this->comparison = new Comparison();

        $this->relations = new ContentRelationship();
    }

    public function index()
    {

    }

    public function init()
    {
        $this->template->assignScript("modules/shop/js/jquery.ajaxSearch.js");
        $this->template->assignScript("modules/shop/js/jquery.cookie-min.js");
        $this->template->assignScript("modules/shop/js/shop.js");
        if($this->page['type'] == 'product'){
            $this->product();
         }
    }

    private function product()
    {
        $product = $this->page;

        $product['categories_id']   = $this->relations->getMainCategoriesId($product['id']);
        $product['images']   = $this->images->get($product['id']);
        $product['price']    = $this->prices->get($product['id'], $this->group_id);
        $product['currency'] = $this->currency->getMeta($product['currency_id'], 'symbol');
        $product['bonus']    = round($product['price'] * $this->bonus_rate, 2);

        $features = new \modules\shop\models\products\Features();
        $product['features'] = $features->get($product['id']);

        if($product['has_variants']){
            $product['variants'] = $this->variants->get($product['id'], $this->group_id);
        }

        $this->template->assign('product', $product);
    }

    public function getProductsVariants($products_id)
    {
        return $this->variants->get($products_id, $this->group_id);
    }

    /**
     * @param string $tpl
     * @return string
     */
    public function filter($tpl = 'modules/shop/category/filter')
    {
        $categories_id = $this->page['id'];

        $features = new Features();

        $prices = [];

        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($maxp > 0){
            $prices['minp'] = $minp;
            $prices['maxp'] = $maxp;
        } else {
            $prices = $features->getMinMaxPrice($categories_id, $this->group_id);
            $prices['minp'] = str_replace(',','.', round($prices['minp'], 2));
            $prices['maxp'] = str_replace(',','.', round($prices['maxp'], 2));

        }

        $filter =
            [
                'features' => $features->get($categories_id),
                'prices'   => $prices,
                'enabled'  => ($minp > 0 || $maxp > 0 || $this->request->param('filter'))
            ];

        $this->template->assign('filter', $filter);

        return $this->template->fetch($tpl);
    }

    /**
     * @param int $parent_id
     * @param int $level
     * @return mixed
     */
    public function categories($parent_id = 0, $level = 0)
    {
        return $this->categories->get($parent_id, $level);
    }

    public function products($categories_id = 0)
    {
        $start = (int) $this->request->get('p', 'i');
        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * $this->ipp;
        }

        $this->products->categories_in = DataFilter::apply('module.shop.products.categories_in', $this->products->categories_in);

        $categories_id = DataFilter::apply('module.shop.products.categories_id', $categories_id);
        $this->products->categories_id = $categories_id;

        $this->products->start = $start;
        $this->products->num = $this->ipp;

        $products = $this->products->get();

        foreach ($products as $k=>$product) {
            $products[$k]['categories_id']   = $this->relations->getMainCategoriesId($product['id']);
            $products[$k]['bonus'] = round($products[$k]['price'] * $this->bonus_rate, 2);
        }

        // save total posts count
        $this->total = $this->products->getTotal();

        return $products;
    }

    /**
     * @return mixed
     */
    public function actionsProducts()
    {
        $this->products->start = 0;
        $this->products->num   = 30;
        $this->products->clearQuery();
        $this->products->join("join __content_relationship cra on cra.content_id=c.id and cra.is_main=1");
        $this->products->where(" c.in_stock=1");
        $products = $this->products->get();

        foreach ($products as $k=>$product) {
            $products[$k]['categories_id'] = $this->relations->getMainCategoriesId($product['id']);
            $products[$k]['bonus'] = round($products[$k]['price'] * $this->bonus_rate, 2);
        }

        return $products;
    }

    /**
     * @return mixed
     */
    public function lastProducts()
    {
        $this->products->start = 0;
        $this->products->num   = 30;
        $this->products->clearQuery();
        $this->products->where(" c.in_stock=1");
        $products = $this->products->get();

        foreach ($products as $k=>$product) {
            $products[$k]['categories_id']   = $this->relations->getMainCategoriesId($product['id']);
            $products[$k]['bonus'] = round($products[$k]['price'] * $this->bonus_rate, 2);
        }

        return $products;
    }

    /**
     * @return mixed
     */
    public function foundTotal()
    {
        return $this->total;
    }

    /**
     * display pagination
     * @param string $tpl
     * @return string
     */
    public function pagination($tpl = 'modules/pagination')
    {
        $p = $this->request->get('p', 'i');

        $url = $this->page['id'] . ';';

        $filter = $this->request->param('filter');

        if($filter){
            $url .= 'filter/' . $filter;
        }

        Pagination::init($this->total, $this->ipp, $p, $url);

        $this->template->assign('pagination', Pagination::getPages());
        return $this->template->fetch($tpl);
    }

    public function ajaxSearch()
    {
        $products = $this->search->results();

        if($products){
            foreach ($products as $k=>$product) {
                $products[$k]['url'] = $this->getUrl($product['id']);
                $products[$k]['img'] = $this->images->cover($product['id']);
            }
        }

        header('Content-Type: application/json');
        echo json_encode(['items' => $products]);die;
    }

    public function saveSearchQuery($q)
    {
        $sh = new SearchHistory();

        $q = strip_tags($q);
        $q = trim($q);
        if(empty($q)) return;
        $sh->add($q);
        header('Content-Type: application/javascript');
        die;
    }

    public function viewed()
    {
        if( ! isset($_COOKIE['viewed'])) return [];

//        $a = explode(',', $_COOKIE['viewed']);
        $in = $_COOKIE['viewed'];

        $this->products->start = 0;
        $this->products->num   = 30;
        $this->products->clearQuery();
        $this->products->debug(0);
        $this->products->where(" c.id in ($in)");
        $products = $this->products->get();

        foreach ($products as $k=>$product) {
            $products[$k]['bonus'] = round($products[$k]['price'] * $this->bonus_rate, 2);
        }

        return $products;
    }

    public function accessories($products_id)
    {
        $acc = new Accessories();
        $r = $acc->get($products_id);

        if(empty($r)) return [];

//        $this->products->debug();
        $this->products->clearQuery();
        $this->products->start = 0;
        $this->products->num   = 60;
        $this->products->where(" c.in_stock = 1");

        $cat_in = [];

        foreach ($r as $cat) {
            $cat_in[] = $cat['id'];

            if($cat['isfolder']){
                $cat_in = array_merge($cat_in, $acc->getSubcategoriesId($cat['id']));
            }

            if(empty($cat['features'])) continue;

            foreach ($cat['features'] as $feature) {
                $in = $feature['values'] != '' ? "and acccf{$cat['id']}.values_id in ({$feature['values']}) " : '';
                $this->products->join("join __content_features acccf{$cat['id']} on acccf{$cat['id']}.content_id=c.id and acccf{$cat['id']}.features_id = {$feature['id']} {$in}");
            }
        }

        $in = implode(',', $cat_in);
        $this->products->join("join  __content_relationship accpc on accpc.categories_id in ({$in}) and accpc.content_id=c.id");

        $products = $this->products->get();

        foreach ($products as $k=>$product) {
            $products[$k]['bonus'] = round($products[$k]['price'] * $this->bonus_rate, 2);
        }

        return $products;
    }

    public function kits($products_id)
    {
        $kits = new Kits();

        $items = $kits->get($products_id);

        foreach ($items as $i=>$row) {

            $items[$i]['amount']      = 0;
            $items[$i]['original_amount'] = 0;
            $items[$i]['save_amount'] = 0;

            foreach ($row['products'] as $k=>$product) {
                $items[$i]['products'][$k]['img'] = $this->images->cover($product['products_id']);

                $items[$i]['products'][$k]['original_price'] = $this->prices->get($product['products_id'], $this->group_id);
                $items[$i]['products'][$k]['price']          = $items[$i]['products'][$k]['original_price'] - ($items[$i]['products'][$k]['original_price'] / 100 * $product['discount']);
                $items[$i]['products'][$k]['save_price']     = $items[$i]['products'][$k]['original_price'] - $items[$i]['products'][$k]['price'];

                $items[$i]['amount']          += round($items[$i]['products'][$k]['price'], 2);
                $items[$i]['original_amount'] += round($items[$i]['products'][$k]['original_price'], 2);
                $items[$i]['save_amount']     += round($items[$i]['products'][$k]['save_price'], 2);
            }
        }

        return $items;
    }

    public function comparison()
    {
        $params = func_get_args();
        $action = 'index';

        if(!empty($params)){
            $action = array_shift($params);
        }

        return call_user_func_array(array($this->comparison, $action), $params);
    }
}