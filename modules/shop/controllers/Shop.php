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
use modules\shop\models\products\Prices;
use modules\shop\models\products\variants\ProductsVariants;
use system\core\Session;
use system\Front;
use system\models\Currency;

/**
 * Class shop
 * @package modules\shop\controllers
 */
class Shop extends Front
{
    private $products;
    private $categories;
    private $ipp = 15;
    private $total;
    private $group_id = 20;
    private $prices;
    private $currency;

    public $search;

    public function __construct()
    {
        parent::__construct();

        $this->products   = new Products('product');
        $this->categories = new Categories('products_categories');
        $this->prices     = new Prices();
        $this->currency   = new Currency();

        $user = Session::get('user');
        $this->group_id = isset($user['group_id']) ? $user['group_id'] : $this->group_id;

        $this->search = new Search($this->products , $this->group_id    );
    }

    public function index()
    {

    }

    public function init()
    {
        $this->template->assignScript("modules/shop/js/shop.js");
        if($this->page['type'] == 'product'){
            $this->product();
         }
    }

    private function product()
    {
        $product = $this->page;

        $product['images']   = $this->images->get($product['id']);
        $product['price']    = $this->prices->get($product['id'], $this->group_id);
        $product['currency'] = $this->currency->getMeta($product['currency_id'], 'symbol');

        $features = new \modules\shop\models\products\Features();
        $product['features'] = $features->get($product['id']);

        if($product['has_variants']){
            $variants = new ProductsVariants();
            $product['variants'] = $variants->get($product['id'], $this->group_id);
        }

        $this->template->assign('product', $product);
    }

    /**
     * @param string $tpl
     * @return string
     */
    public function filter($tpl = 'modules/shop/category/filter')
    {
        $categories_id = $this->page['id'];

        $features = new Features();

        $prices = $features->getMinMaxPrice($categories_id, $this->group_id, $this->currency->getMainMeta('id'));
        $minp = $this->request->get('minp', 'i');
        $maxp = $this->request->get('maxp', 'i');

        if($minp > 0) $prices['minp'] = $minp;
        if($maxp > 0) $prices['maxp'] = $maxp;

        $filter =
            [
                'features' => $features->get($categories_id),
                'prices'   => $prices,
                'enabled'  => ($minp > 0 || $maxp > 0 || $this->request->param('filter'))
            ];

        $this->template->assign('filter', $filter);

        return $this->template->fetch($tpl);
    }

    public function categories($parent_id = 0, $recursive = false)
    {
        return $this->categories->get($parent_id, $recursive);
    }

    public function products($categories_id = 0)
    {
        $start = (int) $this->request->get('p', 'i');
        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * $this->ipp;
        }

        $products = $this->products->get($categories_id, $start, $this->ipp);

        // save total posts count
        $this->total = $this->products->getTotal();

        return $products;
    }

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
}