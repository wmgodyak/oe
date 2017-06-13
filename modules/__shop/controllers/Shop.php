<?php

namespace modules\shop\controllers;

use helpers\Pagination;
use modules\shop\models\Categories;
use modules\shop\models\categories\Features;
use modules\shop\models\Products;
use modules\shop\models\products\Accessories;
use modules\shop\models\products\Comparison;
use modules\shop\models\SearchHistory;
use system\core\DataFilter;
use system\core\Session;
use system\Frontend;
use system\models\Settings;

/**
 * Class shop
 * @name Магазин
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\shop\controllers
 */
class Shop extends Frontend
{
    public $products;
    private $categories;
    private $ipp;
    private $total;
    private $group_id;
    private $currency;

    public $search;

    public $comparison;

    public function __construct()
    {
        parent::__construct();

        $this->ipp        = Settings::getInstance()->get('modules.Shop.config.ipp');

        $this->products   = new Products('product');
        $this->categories = new Categories('products_categories');

        $this->currency   = Session::get('currency');

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : Settings::getInstance()->get('modules.Shop.config.group_id');

        $this->search = new Search($this->products , $this->group_id );

        $this->comparison = new Comparison();
    }

    public function index(){}

    public function init()
    {
        $this->template->assignScript("modules/shop/js/jquery.ajaxSearch.js");
        $this->template->assignScript("modules/shop/js/jquery.cookie-min.js");
        $this->template->assignScript("modules/shop/js/shop.js");

        if($this->page['type'] == 'product'){
            $this->product();
        }

        if($this->page['type'] == 'products_categories'){
            $features = new Features();
            $meta = $features->makeMeta();
            if($meta){
                $page = $this->template->getVars('page');
                foreach ($meta as $feature) {
                    $v = implode(', ', $feature['values']);
                    $page['title']       .= " {$feature['name']} - {$v} ";
                    $page['keywords']    .= " {$feature['name']} - {$v}, ";
                    $page['description'] .= " {$feature['name']} - {$v}. ";
                }
                $this->template->assign('page', $page);
            }
         }
    }

    /**
     * @param int $parent_id
     * @param int $level
     * @return mixed
     */
    public function categories($parent_id = 0, $level = 0)
    {
        $parent_id = DataFilter::apply('module.shop.products.categories_id', $parent_id);
        return $this->categories->get($parent_id, $level);
    }

    /**
     * @return array
     */
    public function filter()
    {
        $categories_id = $this->page['id'];
        $categories_id = DataFilter::apply('module.shop.products.categories_id', $categories_id);

        $features = new Features();

        $prices = [];

        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($maxp > 0){
            $prices['minp'] = $minp;
            $prices['maxp'] = $maxp;
        } else {
            $prices = $features->getMinMaxPrice($categories_id, $this->group_id);
            if($prices){
                $prices['minp'] = str_replace(',','.', round($prices['minp'], 2));
                $prices['maxp'] = str_replace(',','.', round($prices['maxp'], 2));
            }
        }

        $filter =
            [
                'features' => $features->get($categories_id),
                'selected' => $features->getSelected($categories_id),
                'prices'   => $prices,
                'enabled'  => ($minp > 0 || $maxp > 0 || $this->request->param('filter'))
            ];
        return $filter;
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
        $this->products->num   = $this->ipp;

//        $this->products->debug();

        $this->products->sort();
        $this->products->filter();
        $products = $this->products->get();
        $this->total = $this->products->getTotal();

        return $products;
    }

    private function product()
    {
        $product = $this->page;
        $product = array_merge($product, $this->products->data($product['id']));
        unset($product['parent_id'], $product['owner_id'], $product['isfolder'], $product['position']);
        $this->template->assign('product', $product);
    }

    /**
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function lastProducts($start= 0, $num = 30)
    {
        $this->products->categories_id = 0;
        $this->products->start = $start;
        $this->products->num   = $num;

//        $this->products->debug();

        return $this->products->get();
    }

    /**
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function hits($start= 0, $num = 30)
    {
        $this->products->join("join __content_meta cmh on cmh.content_id=c.id and cmh.meta_k='hit'");
        $this->products->categories_id = 0;
        $this->products->start = $start;
        $this->products->num   = $num;

        return $this->products->get();
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
        $pages = Pagination::getPages();

        if($this->total > 0){
            $cat = $this->page;
            // assign canonical rel prev next
            $total = $this->total;
            $ipp = $this->ipp;
            DataFilter::add('documentSource', function($ds) use ($pages, $p, $cat, $total, $ipp) {
//                d($pages);die;
                $link = '';

                $last = ceil($total / $ipp);
                $start = $p;
                $start --;

                if($start > 0) {
                    $link .= "<link rel=\"prev\" href=\"{$cat['url']}?p={$start}\">";
                }

                $start = $p;
                $start++;
                if($start < $last) {
                    if($start == 1) $start = 2;
                    $link .= "<link rel=\"next\" href=\"{$cat['url']}?p={$start}\">";
                }

                if(!empty($link)){
                    $ds = str_replace('</head>', $link . '</head>', $ds);
                }

                return $ds;
            });
        }

        $this->template->assign('pagination', $pages);
        return $this->template->fetch($tpl);
    }

    public function ajaxSearch()
    {

        $products = $this->search->results();
//
//        if($products){
//            foreach ($products as $k=>$product) {
//                $products[$k]['url'] = $this->getUrl($product['id']);
//                $products[$k]['img'] = $this->images->cover($product['id']);
//            }
//        }
//
//        header('Content-Type: application/json');
//        echo json_encode(['items' => $products]);die;
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

        $in = $_COOKIE['viewed'];

        $a = explode(',', $in);
        $a = array_unique($a);
        foreach ($a as $k=>$v) {
            $a[$k] = (int)$v;
        }

        $in = implode(',', $a);

        $this->products->start = 0;
        $this->products->num   = 30;
        $this->products->clearQuery();
        $this->products->debug(0);
        $this->products->where(" c.id in ($in)");

        return $this->products->get();
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
        $this->products->where(" p.in_stock = 1");

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
        return $products;
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

    public function setDisplayMode()
    {
        $mode = $this->request->post('mode', 's');
        Session::set('display_mode', $mode);
    }
}