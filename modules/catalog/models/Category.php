<?php

namespace modules\catalog\models;

use system\models\Frontend;

/**
 * Class Category
 * @package modules\catalog\models
 */
class Category extends Frontend
{
    private $config;
    public $products;

    public function __construct($config, $currency, $user)
    {
        parent::__construct();

        $this->config = $config;

        $group_id = isset($user['group_id']) ? $user['group_id'] : $this->config->group_id;

        $this->products = new Products($config, $currency, $group_id);
    }
}