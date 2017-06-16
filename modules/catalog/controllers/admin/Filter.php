<?php

namespace modules\catalog\controllers\admin;

use modules\currency\models\Currency;
use system\Backend;
use system\models\Content;
use system\models\UsersGroup;

/**
 * Class Filter
 * @package modules\catalog\models
 */
class Filter extends Backend
{
    private $config;
    private $features;
    private $currency;
    private $customersGroup;
    private $categories;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $this->features = new \modules\catalog\models\CategoriesFeatures();
        $this->currency = new Currency();
        $this->customersGroup = new UsersGroup();

        $this->categories = new \modules\catalog\models\backend\Categories();
    }

    public function init()
    {
        events()->add('catalog.category.products.top', [$this, 'index']);

        filter_add('catalog.products.datatable.xhr', function($t){
            $filter = $this->request->post('filter');

            $currency_id = isset($filter['currency_id']) ? $filter['currency_id'] : null;
            $category_id = isset($filter['category_id']) ? $filter['category_id'] : null;

            $cu_main = $this->currency->getMainMeta();
            if(! $currency_id){
                $cu_on_site = $this->currency->getOnSiteMeta();
            } else {
                $cu_on_site = $this->currency->getMeta($currency_id);
            }

            if(isset($filter['group_id']) && $filter['group_id'] > 0){
                $this->group_id = $filter['group_id'];
            }

            $t->join("__products p on p.content_id=c.id");

            $where = [];

            $price = "(CASE
            WHEN p.currency_id = {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price
            WHEN p.currency_id = {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN 1
            END )";

            if($category_id > 0){
                if($this->categories->isFolder($category_id)){
                    $in = $this->categories->getChildrensId($category_id);
                    if(! empty($in)){
                        $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id in (". implode(',', $in) .")");
                    } else {
                        $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id = {$category_id}");
                    }
                } else {
                    $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$category_id}");
                }
            }

            $filter['minp'] = isset($filter['minp']) ? $filter['minp'] : 0;
            $filter['maxp'] = isset($filter['maxp']) ? $filter['maxp'] : 0;

            if($filter['minp'] > 0 && $filter['maxp'] > 0){
                $where[] = " $price between '{$filter['minp']}' and '{$filter['maxp']}' ";
            } elseif($filter['minp'] > 0 && empty($filter['maxp'])){
                $where[] = " $price >= '{$filter['minp']}'";
            } elseif(empty($filter['minp']) && $filter['maxp'] > 0){
                $where[] = " $price <= '{$filter['maxp']}'";
            }

            if(isset($filter['sku']) && strlen($filter['sku']) > 2){
                $where[] = " p.sku like '{$filter['sku']}%'";
            }

            if(isset($filter['in_stock']) && $filter['in_stock'] != ''){
                $filter['in_stock'] = (int)$filter['in_stock'];
                $where[] = " p.in_stock = {$filter['in_stock']}";
            }

            if(isset($filter['extra']) && !empty($filter['extra'])){
                foreach ($filter['extra'] as $k=>$item) {
                    switch($item){
                        case 'published':
                            $where[] = " c.status = 'published'";
                            break;
                        case 'hidden':
                            $where[] = " c.status = 'hidden'";
                            break;
                        case 'noimage':
                            $where[] = " c.id not in (select content_id from __content_images) ";
                            break;
                        case 'vsimage':
                            $where[] = " c.id in (select content_id from __content_images) ";
                            break;
                        case 'nocat':
                            $where[] = " c.id not in (select content_id from __content_relationship) ";
                            break;
                        case 'hit':
                            $t->join("__content_meta ecm on ecm.content_id=c.id and ecm.meta_k = 'hit' and ecm.meta_v = 1 ");
                            break;
                        case 'bestseller':
                            $t->join("__content_meta ecm1 on ecm1.content_id=c.id and ecm1.meta_k = 'bestseller' and ecm1.meta_v = 1 ");
                            break;
                        default:
//                        $where[] = " c.status in ('published', 'hidden')";
                            break;
                    }
                }

            } else {
                $where[] = " c.status in ('published', 'hidden')";
            }
            // filter features

            if(isset($filter['f'])){
                foreach ($filter['f'] as $features_id => $a) {
                    $in = implode(',', $a);

                    $t->join("__content_features cf{$features_id} on
                        cf{$features_id}.content_id=c.id
                    and cf{$features_id}.features_id = {$features_id}
                    and cf{$features_id}.values_id in (". $in .")
                    ");
                }
            }

            $where = !empty($where) ? implode(' and ', $where)  : null;

            $t->where($where);

            return $t;
        });
    }

    public function index($category_id = null)
    {
        if($category_id > 0){
            $this->template->assign('features', $this->features->get($category_id));
        }

        $this->template->assign('category_id', $category_id);
        $this->template->assign('currency', $this->currency->get());
        $this->template->assign('groups', $this->customersGroup->getItems(0, 0));

        return $this->template->fetch('modules/catalog/products/filter');
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}