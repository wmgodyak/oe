<?php

namespace modules\catalog\controllers\admin;

use system\Backend;

/**
 * Class ProductsManufacturers
 * @package modules\catalog\controllers\admin
 */
class ProductsManufacturers extends Backend
{
    private $manufacturers;
    private $config;


    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $this->manufacturers = new \modules\catalog\models\backend\Categories($this->config->type->manufacturer);
    }

    public function init()
    {
        events()->add('content.params', [$this, 'index']);
    }

    public function index($content = null)
    {
        if($content['type'] != $this->config->type->product) return null;


        $this->template->assign('manufacturers', $this->manufacturers->tree(0));
        return $this->template->fetch('modules/catalog/products/manufacturers/params');
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