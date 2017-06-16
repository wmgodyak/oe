<?php

namespace modules\catalog\controllers\admin;

use system\Backend;
use system\models\ContentRelationship;

class ProductsCategories extends Backend
{
    private $categories;
    private $config;
    private $relations;


    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $this->relations  = new ContentRelationship();
        $this->categories = new \modules\catalog\models\backend\Categories($this->config->type->category);
    }

    public function init()
    {
        events()->add('content.params', [$this, 'index']);
    }

    public function index($content = null)
    {
        if($content['type'] != $this->config->type->product) return null;

        $this->template->assign('selected_categories', $this->relations->getCategoriesFull($content['id']));
        $this->template->assign('main_category', $this->relations->getCategoriesFull($content['id'],1));

        return $this->template->fetch('modules/catalog/products/categories/index');
    }

    public function tree()
    {
        $this->template->assign('products_id', $this->request->post('products_id', 'i'));
        $this->template->assign('is_main', $this->request->post('is_main', 'i'));
        return $this->template->fetch('modules/catalog/products/categories/tree');
    }

    public function get()
    {
        $items = [];
        $parent_id = $this->request->get('id', 'i');

        foreach ($this->categories->tree($parent_id) as $item) {

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

        return $items;
    }

    public function save()
    {
        $s = false; $cat = null;
        $selected = $this->request->post('selected');
        $products_id = $this->request->post('products_id', 'i');
        $is_main = $this->request->post('is_main', 'i');
        if(!empty($selected) && $products_id > 0){
            $a = explode(',', $selected);

            if($is_main && $selected > 0){
                $s = $this->relations->saveMainCategory($products_id, $selected);
            } elseif(!$is_main && !empty($a)){
                $s = $this->relations->saveContentCategories($products_id, $a);
            }

            if($s){
                $cat = $this->relations->getCategoriesFull($products_id, $is_main);
            }
        }

        return ['s'=> $s, 'cat' => $cat];
    }

    public function remove()
    {
        $s = false; $cat = null;

        $categories_id = $this->request->post('categories_id');
        $products_id   = $this->request->post('products_id', 'i');

        if(!empty($categories_id) && $products_id > 0){
            $s = $this->relations->delete($products_id, $categories_id);
            if($s){
                $cat = $this->relations->getCategoriesFull($products_id);
            }
        }

        return ['s'=> $s, 'cat' => $cat];
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