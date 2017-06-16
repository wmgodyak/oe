<?php

namespace modules\catalog\controllers;

use system\Frontend;

/**
 * Class Catalog
 * @package modules\catalog\controllers
 */
class Category extends Frontend
{
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');
    }

    public function init()
    {
        parent::init();
    }
}