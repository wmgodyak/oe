<?php

namespace modules\catalog\controllers\admin;

use system\Backend;
use system\models\ContentFeatures;
use system\models\ContentRelationship;
use system\models\UsersGroup;

class ProductsVariants extends Backend
{
    private $config;

    private $contentFeatures;
    private $customersGroup;
    private $contentRelations;

    private $variants;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');


        $this->variants = new \modules\catalog\models\backend\ProductsVariants();
        $this->contentFeatures = new ContentFeatures();
        $this->customersGroup = new UsersGroup();
        $this->contentRelations = new ContentRelationship();
    }

    public function init()
    {
        events()->add('content.main.after', [$this, 'index']);
    }

    public function index($content = null)
    {
        if($content['type'] != $this->config->type->product) return null;

        $this->template->assign('customers_group', $this->customersGroup->getItems(0));

        return $this->template->fetch('modules/catalog/products/variants/index');
    }

    public function get($products_id)
    {
        if(empty($products_id)) return '';

        $this->template->assign('customers_group', $this->customersGroup->getItems(0));
        $this->template->assign('variants', $this->variants->get($products_id));
        $this->response->body($this->template->fetch('modules/shop/products/variants/items'));
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