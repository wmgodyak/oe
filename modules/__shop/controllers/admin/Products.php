<?php

namespace modules\shop\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use modules\currency\models\Currency;
use modules\shop\controllers\admin\products\Features;
use modules\shop\controllers\admin\products\Kits;
use modules\shop\controllers\admin\products\Variants;
use modules\shop\models\admin\Prices;
use modules\shop\models\admin\Categories as Cat;
use system\components\content\controllers\Content;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentRelationship;
use system\models\UsersGroup;

/**
 * Class shop
 * @package modules\shop\controllers\admin
 */
class Products extends Content
{
    private $categories;
    private $relations;
    private $contentTypes;
    private $allowed_types = ['product'];
    private $prices;
    private $currency;
    private $customersGroups;
    private $group_id = 5;
    private $products;

    public function __construct()
    {
        parent::__construct('product');

        $this->products = new \modules\shop\models\admin\Products();
        $this->form_action = "module/run/shop/products/process/";
        // hide custom block
        $this->form_display_blocks['intro']    = true;
        $this->form_display_params['parent']   = false;
        $this->form_display_params['owner']    = false;
        $this->form_display_params['pub_date'] = false;
        $this->form_display_blocks['features'] = false;

        $this->relations = new ContentRelationship();
        $this->categories = new Cat('products_categories');
        $this->contentTypes = new \system\models\ContentTypes();
        $this->prices = new Prices();
        $this->customersGroups = new UsersGroup();

        $this->currency = new Currency();
//        $this->variants =

        EventsHandler::getInstance()->add('content.main', [$this, 'contentParams']);
        EventsHandler::getInstance()->add('content.process', [$this, 'contentProcess']);

        $prices = new \modules\shop\controllers\admin\Prices();
        EventsHandler::getInstance()->add('content.main.after', [$prices, 'index']);
        EventsHandler::getInstance()->add('content.process', [$prices, 'process']);
        EventsHandler::getInstance()->add('content.params', [$this, 'params']);
    }

    public function params($content)
    {
        $ct = $this->contentTypes->getData($content['types_id'], 'type');
        if(!in_array($ct, $this->allowed_types)) return '';

        return $this->template->fetch('modules/shop/products/params');
    }

    /**
     * @param $content
     * @return string
     */
    public function contentParams($content)
    {
        $ct = $this->contentTypes->getData($content['types_id'], 'type');
        if(!in_array($ct, $this->allowed_types)) return '';

        $this->template->assign('selected_categories', $this->relations->getCategoriesFull($content['id']));
        $this->template->assign('main_category', $this->relations->getCategoriesFull($content['id'],1));
//        $this->template->assign('categories', $this->categories->get(0, 30));

        return $this->template->fetch('modules/shop/select_categories');
    }

    public function categoriesTree($action = null)
    {
//        if( ! $this->request->isPost()) die;

        if($action == 'remove'){

            $s = false; $cat = null;
            $categories_id = $this->request->post('categories_id');
            $products_id = $this->request->post('products_id', 'i');
            if(!empty($categories_id) && $products_id > 0){
                $s = $this->relations->delete($products_id, $categories_id);
                if($s){
                    $cat = $this->relations->getCategoriesFull($products_id);
                }
            }

            $this->response->body(['s'=> $s, 'cat' => $cat])->asJSON();

        } elseif($action == 'save'){
            $s = false; $cat = null;
            $selected = $this->request->post('selected');
            $products_id = $this->request->post('products_id', 'i');
            $is_main = $this->request->post('is_main', 'i');
            if(!empty($selected) && $products_id > 0){
                $a = explode(',', $selected);
//                $is_main = count($a) == 1 ? 1 : 0;

                if($is_main && $selected > 0){
                  $s = $this->relations->saveMainCategory($products_id, $selected);
                } elseif(!$is_main && !empty($a)){
                    $s = $this->relations->saveContentCategories($products_id, $a);
                }

                if($s){
                    $cat = $this->relations->getCategoriesFull($products_id, $is_main);
                }
            }

            $this->response->body(['s'=> $s, 'cat' => $cat])->asJSON();

        } elseif($action == 'html'){
            $this->template->assign('products_id', $this->request->post('products_id', 'i'));
            $this->template->assign('is_main', $this->request->post('is_main', 'i'));
            echo $this->template->fetch('modules/shop/categories_tree');
        } elseif($action == 'json') {
            $items = array();
            $parent_id = $this->request->get('id', 'i');
            foreach ($this->categories->tree($parent_id) as $item) {
                $item['children'] = $item['isfolder'] == 1;
                if ($parent_id > 0) {
                    $item['parent'] = $parent_id;
                }
                $item['text'] = "#{$item['id']} {$item['text']} ";
//                $item['a_attr'] = ['id' => $item['id'], 'href' => './module/run/shop/products/index/' . $item['id']];
                $item['li_attr'] = [
                    'id' => 'li_' . $item['id'],
                    'class' => 'status-' . $item['status'],
                    'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')

                ];
                $item['type'] = $item['isfolder'] ? 'folder' : 'file';

                $items[] = $item;
            }

            $this->response->body($items)->asJSON();
        }
    }

    public function index($categories_id=0)
    {
        if($categories_id > 0){
            $parents = $this->mContent->getParents($categories_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/shop/products/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/shop/products/create' . ($categories_id? "/$categories_id" : '')]
            )
        );

        $currency_id = $this->request->get('currency_id', 'i');
        if(! $currency_id){
            $cu_on_site = $this->currency->getOnSiteMeta();
        } else {
            $cu_on_site = $this->currency->getMeta($currency_id);
        }

        $cu_main    = $this->currency->getMainMeta();

        $t = new DataTables2('content');

        $t  -> ajax('module/run/shop/products/index/' . $categories_id, ['filter' => $_GET])
            ->orderDef(1, 'desc')
            -> th("<input style='z-index: 1' type='checkbox' class='dt-check-all'>", null, 0, 0, 'width: 60px')
            -> th($this->t('shop.products.sku'), 'p.sku', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('shop.products.stock'), 'p.in_stock', 0, 1);

            foreach ($this->customersGroups->getItems(0, 0) as $group) {
                $t -> th($group['name'], 'c.created', 0, 0, 'width: 160px');
            }

//        $t  -> th($this->t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
          $t  -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 200px')
        ;
        $t->get('c.id',     null, null, null);
        $t->get('ci.url',   null, null, null);
        $t->get('c.status', null, null, null);
        $t->get("p.has_variants ", null, null, null);
        $t->get("cu.symbol ", null, null, null);

        $t->get('pp.price as pprice', null, null, null);

        $t->addGroupAction('Change main category', 'engine.shop.products.gaChangeCategory');


//        $t->debug();

        if($this->request->isXhr()){
            $kits     = new \modules\shop\models\admin\products\Kits();
            $variants = new \modules\shop\models\products\variants\ProductsVariants();

            // filter
            $filter = $this->request->post('filter');

            if(isset($filter['group_id']) && $filter['group_id'] > 0){
                $this->group_id = $filter['group_id'];
            }

            $where = [];

            $price = "(CASE
            WHEN p.currency_id = {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price
            WHEN p.currency_id = {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN p.currency_id <> {$cu_on_site['id']} and p.currency_id <> {$cu_main['id']} THEN 1
            END )";

            if($categories_id > 0){
                if($this->products->isfolder($categories_id)){
                    $in = $this->products->categoriesChildrenID($categories_id);
                    if(! empty($in)){
                        $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id in (". implode(',', $in) .")");
                    } else {
                        $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id = {$categories_id}");
                    }
                } else {
                    $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$categories_id}");
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


            $t  -> from('__content c')
                -> join("__products p on p.content_id=c.id")
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}", 'left')
                -> join("__currency cu on cu.id = p.currency_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
                -> where($where);

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $img = $this->images->cover($row['id'], 'thumbs');

                $img = $img ? "<img style='max-width:30px; max-height: 30px; float:left; margin-right: 1em;' src='{$img}'>" : "<i class='fa fa-file-image-o'></i>";
                $icon_link = Icon::create('fa-external-link');
                $status = $this->t($this->type .'.status_' . $row['status']);

                $variantsCount = 0;
                if($row['has_variants']){
                    $variantsCount = $variants->total($row['id']);
                }

//                $prices = $this->prices->get($row['id'], $cu_on_site, $cu_main);

                $in_stock = [
                  0 => "Немає",
                  1 => "В наявн.",
                  2 => "Під зам.",
                ];


                $res[$i][] = '<input class=\'dt-chb\' value=\''. $row['id'] .'\' type=\'checkbox\' style=\'height: auto;\'>';
                $res[$i][] = $row['sku'];

                $tk = $kits->count($row['id']);

                $res[$i][] =
                    $img .
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/shop/products/edit/{$row['id']}'>{$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                    . ($row['has_variants'] ?  '<br><label class="label label-success">'. $variantsCount .' варіанти</label>' : '')
                    . ($tk > 0 ?  '<br><label class="label-success label">'. $tk .' комплекти</label>' : '')
                ;
//                $cu = $this->prices->getProductCurrency($row['id']);
                $res[$i][] = $in_stock[$row['in_stock']];
                foreach ($this->customersGroups->getItems(0, 0) as $group) {
//                    $res[$i][] =
//                        '<abbr>'.(isset($prices[$group['id']]) ? $prices[$group['id']] : 0) .' '. $cu_on_site['symbol'] . "</abbr>"
//                    ;
                    $price = $this->prices->getByGroupId($row['id'], $group['id']);
                    $res[$i][] = "<abbr>{$price} {$row['symbol']}</abbr>"
                    ;
                }
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Link::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'b-'.$this->type.'-hide',
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'b-'.$this->type.'-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/shop/products/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'btn-danger b-products-delete', 'data-id' => $row['id'], 'title' => $this->t('shop.delete_question')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());//$this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }

        $this->template->assign('sidebar', $this->template->fetch('modules/shop/categories/tree'));
//        $this->output( $this->filter($categories_id) . $t->init() . $this->filterActions($categories_id)); 
        $this->output($this->filter($categories_id) . $t->init() . $this->filterActions($categories_id));
    }


    private function filterActions($categories_id)
    {
        $extra = $this->request->get('extra');
        if(! $extra) return null;

        $this->template->assign('categories_id', $categories_id);

        return $this->template->fetch('modules/shop/products/filter_actions');
    }

    public function export($format, $categories_id)
    {
        $products = $this->products->export($categories_id);

        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=products.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        echo "id;sku;name;price;code;status;created;updated\n";
        foreach ($products as $fields) {
            echo implode(';', $fields), "\n";
        }
        die;
    }

    private function filter($categories_id)
    {
        if($categories_id > 0){
            $features = new \modules\shop\models\categories\Features();
            $this->template->assign('features', $features->get($categories_id));
        }


        $this->template->assign('categories_id', $categories_id);
        $this->template->assign('currency', $this->currency->get());
        $this->template->assign('groups', $this->customersGroups->getItems(0, 0));
        return $this->template->fetch('modules/shop/products/filter');
    }

    public function create($categories_id = 0)
    {
        $id = parent::create(0);
        if($id > 0 && $categories_id > 0){
            $this->products->relations->create($id, $categories_id, 1);
        }

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/shop/products' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        EventsHandler::getInstance()->add('content.main.after', [new Features(), 'index']);
        EventsHandler::getInstance()->add('content.main.after', [new Variants(), 'index']);
        EventsHandler::getInstance()->add('content.main.after', [new Kits(), 'index']);


        $this->template->assign('sidebar', $this->template->fetch('modules/shop/categories/tree'));

        parent::edit($id);
    }

    public function process($id, $response = true)
    {
        EventsHandler::getInstance()->add('content.process', [new Variants(), 'process']);

        $this->products->update($id, $this->request->post('product'));
        parent::process($id, $response);
    }

    /**
     * @param $id
     * @return mixed
     */
    public function contentProcess($id)
    {
//        $this->relations->saveContentCategories($id);
//        $this->relations->saveMainCategory($id);

        $meta = $this->request->post('content_meta');
        if($meta){
            foreach ($meta as $meta_k=>$meta_v) {
                if(is_array($meta_v )) continue;

                if(empty($meta_v)){
                    $this->mContent->meta->delete($id, $meta_k);
                }
            }
        }
        return $this->features('contentProcess', $id);
    }


    public function features($action = 'index')
    {
        include "products/Features.php";

        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new products\Features();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function variants($action = 'index')
    {
        include "products/Variants.php";

        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new products\Variants();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function kits($action = 'index')
    {
        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new products\Kits();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function groupActions()
    {
        $controller = null; $action = 'index';

        $ns = '\modules\shop\controllers\admin\products\groupActions\\';
        $params = func_get_args();

        if(!empty($params)){
            $controller = array_shift($params);
        }
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller = ucfirst($controller);

        if (!class_exists( $ns . $controller)) {
            throw new \Exception("Wrong action. {$controller} ");
        }

        $c = $ns . $controller;

        $cc = new $c();

        return call_user_func_array(array($cc, $action), $params);
    }
}