<?php

namespace modules\shop\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use modules\shop\controllers\admin\products\Features;
use modules\shop\controllers\admin\products\Kits;
use modules\shop\controllers\admin\products\Variants;
use modules\shop\models\admin\Prices;
use modules\shop\models\admin\Categories;
use system\components\content\controllers\Content;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentRelationship;
use system\models\Currency;
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
//    private $variants;

    public function __construct()
    {
        parent::__construct('product');

        $this->form_action = "module/run/shop/products/process/";
        // hide custom block
        $this->form_display_blocks['intro']    = false;
        $this->form_display_params['parent']   = false;
        $this->form_display_params['owner']    = false;
        $this->form_display_params['pub_date'] = false;
        $this->form_display_blocks['features'] = false;

        $this->relations = new ContentRelationship();
        $this->categories = new Categories('products_categories');
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

        $video = new Video();
        EventsHandler::getInstance()->add('content.params.after', [$video, 'index']);
        EventsHandler::getInstance()->add('content.process', [$video, 'process']);

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

        return $this->template->fetch('shop/select_categories');
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
            if(!empty($selected) && $products_id > 0){
                $a = explode(',', $selected);
                $is_main = count($a) == 1 ? 1 : 0;

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
            echo $this->template->fetch('shop/categories_tree');
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
//            ->orderDef(0, 'desc')
//            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('shop.sky'), 'c.sku', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1);

            foreach ($this->customersGroups->getItems(0, 0) as $group) {
                $t -> th($group['name'], 'c.created', 0, 0, 'width: 160px');
            }

//        $t  -> th($this->t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
          $t  -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 200px')
        ;
        $t->get('c.id',     null, null, null);
        $t->get('ci.url',   null, null, null);
        $t->get('c.status', null, null, null);
        $t->get("c.has_variants ", null, null, null);
        $t->get("cu.symbol ", null, null, null);

        $t->get('pp.price as pprice', null, null, null);
//        $t->debug();

        if($this->request->isXhr()){

            $variants = new \modules\shop\models\products\variants\ProductsVariants();

            // filter
            $filter = $this->request->post('filter');

            if(isset($filter['group_id']) && $filter['group_id'] > 0){
                $this->group_id = $filter['group_id'];
            }

            $where = [];

            $price = "(CASE
            WHEN c.currency_id = {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price
            WHEN c.currency_id = {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}

            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN 1
            END )";

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
                $where[]= " c.sku like '{$filter['sku']}%'";
            }
            if(isset($filter['status'])){

                switch($filter['status']){
                    case 'publsihed':
                        $where[] = " c.status = 'publsihed'";
                        break;
                    case 'hidden':
                        $where[] = " c.status = 'hidden'";
                        break;
                    default:
                        $where[] = " c.status in ('published', 'hidden')";
                        break;
                }
            } else{
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
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__products_prices pp on pp.content_id=c.id and pp.group_id={$this->group_id}", 'left')
                -> join("__currency cu on cu.id = c.currency_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
                -> where($where);

            if($categories_id > 0){
                $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$categories_id}");
            }

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $img = $this->images->cover($row['id'], 'thumbs');

                $img = $img ? "<img style='max-width:30px; max-height: 30px; float:left; margin-right: 1em;' src='/{$img}'>" : "<i class='fa fa-file-image-o'></i>";
                $icon_link = Icon::create('fa-external-link');
                $status = $this->t($this->type .'.status_' . $row['status']);

                $variantsCount = 0;
                if($row['has_variants']){
                    $variantsCount = $variants->total($row['id']);
                }

                $prices = $this->prices->get($row['id'], $cu_on_site, $cu_main);

//                $res[$i][] = $row['id'];
                $res[$i][] = $row['sku'];
                $res[$i][] =
                    $img .
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/shop/products/edit/{$row['id']}'>{$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                    . ($row['has_variants'] ?  '<br><abbr>'. $variantsCount .' варіанти</abbr>' : '')
                ;
//                $cu = $this->prices->getProductCurrency($row['id']);
                foreach ($this->customersGroups->getItems(0, 0) as $group) {
                    $res[$i][] =
//                    "<span style='margin-right: 1em;'><input class='form-control' value='". (isset($prices[$group['id']]) ? $prices[$group['id']] : 0) ."'></span>"
//                    . "<span style='position:relative;margin-top:-10px;'>". (isset($cu['symbol']) ? $cu['symbol'] .' ' : '') ."</span>"
                        '<abbr title="'. $row['pprice'] .' '.$row['symbol'].'">'.(isset($prices[$group['id']]) ? $prices[$group['id']] : 0) .' '. $cu_on_site['symbol'] . "</abbr>"
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

        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));
        $this->output( $this->filter($categories_id) . $t->init());
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
        return $this->template->fetch('shop/products/filter');
    }

    public function create()
    {
        $id = parent::create(0);

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

        EventsHandler::getInstance()->add('content.main.after', [new Variants(), 'index']);
        EventsHandler::getInstance()->add('content.main.after', [new Features(), 'index']);
        EventsHandler::getInstance()->add('content.main.after', [new Kits(), 'index']);


        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));

        parent::edit($id);
    }

    public function process($id, $response = true)
    {
        EventsHandler::getInstance()->add('content.process', [new Variants(), 'process']);
        return parent::process($id, $response);
    }

    /**
     * @param $id
     */
    public function contentProcess($id)
    {
        $this->relations->saveContentCategories($id);
        $this->relations->saveMainCategory($id);

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
}