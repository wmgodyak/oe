<?php

namespace modules\shopBlog\controllers\admin;
use system\core\EventsHandler;
use system\Engine;
use system\models\Content;
use system\models\ContentRelationship;

/**
 * Class ShopBlog
 * @package modules\shopBlog\controllers\admin
 */
class ShopBlog extends Engine
{
    private $relations;
    private $content;
    private $shopBlog;

    public function __construct()
    {
        parent::__construct();
        $this->relations = new ContentRelationship();
        $this->content = new Content();
        $this->shopBlog  = new \modules\shopBlog\models\admin\ShopBlog();
    }

    public function init()
    {
        parent::init();

        $this->template->assignScript('modules/shopBlog/js/admin/shopBlog.js');
        EventsHandler::getInstance()->add('content.params.after', [$this, 'index']);
    }

    public function index($post = null)
    {
        if($post['type'] != 'post') return null;

        $this->template->assign('s_categories', $this->relations->getCategoriesFull($post['id']));

        return $this->template->fetch('modules/shopBlog/index');
    }

    public function selectCategories($post_id)
    {
        $this->template->assign('post_id', $post_id);
        echo $this->template->fetch('modules/shopBlog/form');
    }

    public function saveCategories()
    {
        $s = false;
        $selected = $this->request->post('selected');
        $post_id = $this->request->post('post_id', 'i');
        if(!empty($selected) && $post_id > 0){
            $a = explode(',', $selected);
            $s = $this->relations->saveContentCategories($post_id, $a, 'post_shop_cat');
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }

    public function getCategories()
    {
        $post_id = $this->request->post('post_id', 'i');
        if(empty($post_id)) die;

        $cat = $this->relations->getCategoriesFull($post_id, 0, 'post_shop_cat');
        $this->response->body(['items' => $cat])->asJSON();
    }

    public function catTree()
    {
        $items = array();
        $parent_id = $this->request->get('id', 'i');
        foreach ($this->content->tree($parent_id, 'products_categories') as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if ($parent_id > 0) {
                $item['parent'] = $parent_id;
            }
            $item['text'] = "#{$item['id']} {$item['text']} ";
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

    public function categoriesDelete()
    {
        $s = false; $cat = null;
        $categories_id = $this->request->post('categories_id');
        $post_id       = $this->request->post('post_id', 'i');

        if(!empty($categories_id) && $post_id > 0){
            $s = $this->relations->delete($post_id, $categories_id);
        }

        $this->response->body(['s'=> $s, 'cat' => $cat])->asJSON();
    }

    public function getProducts()
    {
        $post_id = $this->request->post('post_id', 'i');
        if(empty($post_id)) die;

        $cat = $this->relations->getCategoriesFull($post_id, 0, 'post_shop_product');
        $this->response->body(['items' => $cat])->asJSON();
    }

    public function addProduct()
    {
        $s = false;
        $products_id = $this->request->post('products_id', 'i');
        $post_id = $this->request->post('post_id', 'i');

        if($products_id > 0  && $post_id > 0){
            $s = $this->relations->create($post_id, $products_id, 0, 'post_shop_product');
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }

    public function searchProducts()
    {
        $q = $this->request->post('q', 's');

        $items = [];
        if(!empty($q)){
            $items = $this->shopBlog->searchProducts($q);
            foreach ($items as $k=>$item) {
                $items[$k]['text'] = "#{$item['id']} {$item['name']}";
            }
        }

        $res = array(
            'total_count'        => $this->shopBlog->searchTotal(),
            'incomplete_results' => false,
            'results'            => $items
        );

        echo json_encode($res);
    }

    public function productsDelete()
    {
        $s = false;
        $products_id = $this->request->post('products_id');
        $post_id       = $this->request->post('post_id', 'i');

        if(!empty($products_id) && $post_id > 0){
            $s = $this->relations->delete($post_id, $products_id);
        }

        $this->response->body(['s'=> $s])->asJSON();
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }

}