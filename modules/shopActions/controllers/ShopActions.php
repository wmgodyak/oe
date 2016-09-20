<?php

namespace modules\shopActions\controllers;
use modules\shop\models\Products;
use system\Front;

/**
 * Class ShopActions
 * @package modules\shopActions\controllers
 */
class ShopActions extends Front
{
    private $actions;

    public function __construct()
    {
        parent::__construct();

        $this->actions = new \modules\shopActions\models\ShopActions();
    }

    public function init()
    {
        parent::init();

        $this->template->assignScript('modules/shopActions/js/jquery.countdown.min.js');
        $this->template->assignScript('modules/shopActions/js/shopActions.js');
    }

    public function getBanners($place)
    {
        return $this->actions->getBanners($place);
    }

    public function click($id = null)
    {
        if(! $id) die;

        $url = $this->getUrl($id);

        if(!empty($url)) {
            $v = $this->actions->meta->get($id, 'views', true);
            $this->actions->meta->update($id, 'views', ++ $v);
            $this->redirect($url);
        }
    }

    public function products($categories_id)
    {
        $products = new Products();
        $products->categories_id = $categories_id;

        return $products->get();
    }
}