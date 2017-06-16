<?php

namespace modules\catalog\controllers\admin;

use system\Backend;
use system\core\DataFilter;

/**
 * Class Catalog
 * @package modules\currency\controllers\admin
 */
class Catalog extends Backend
{
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');
    }

    public function init()
    {
        $this->assignToNav(t('catalog.action_index'), 'module/run/catalog', 'fa-shopping-cart', null, 30);

        $this->assignToNav(t('catalog.categories.action_index'), 'module/run/catalog/categories', 'fa-shopping-cart', 'module/run/catalog');
        $this->assignToNav(t('catalog.products.action_index'), 'module/run/catalog/products', 'fa-shopping-cart', 'module/run/catalog');
        $this->assignToNav(t('catalog.manufacturers.action_index'), 'module/run/catalog/manufacturers', 'fa-car', 'module/run/catalog');

        DataFilter::add('nav.items.content_types', function($types){
            $types[] = 'products_categories';

            return $types;
        });

        $this->template->assignScript("modules/catalog/js/admin/catalog.js");
    }

    public function index()
    {
        // TODO: Implement index() method.
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