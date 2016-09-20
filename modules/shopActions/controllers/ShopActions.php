<?php

namespace modules\shopActions\controllers;
use helpers\Pagination;
use modules\shop\models\Products;
use system\core\EventsHandler;
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

        EventsHandler::getInstance()->add('shop.categories.sidebar', [$this, 'categoriesActions']);
        EventsHandler::getInstance()->add('shop.product.buy.after', [$this, 'productsActions']);
    }

    public function categoriesActions($category)
    {
        $items = $this->actions->onCategory($category['id'], 3);
        $this->template->assign('items', $items);
        return $this->template->fetch('modules/shopActions/category_sidebar');
    }

    public function productsActions($product)
    {
        $items = $this->actions->onProduct($product['id'], 5);
        $this->template->assign('items', $items);
        return $this->template->fetch('modules/shopActions/product_actions');
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

    public function products($actions_id)
    {
        return $this->actions->getProductsByAction($actions_id);
    }

    public function getProducts($start = 0, $num = 30)
    {
        return $this->actions->getProducts($start, $num);
    }

    /**
     * display pagination
     * @param string $tpl
     * @return string
     */
    public function productsPagination($tpl = 'modules/pagination')
    {
        $p = $this->request->get('p', 'i');

        $url = $this->page['id'] . ';';

        $filter = $this->request->param('filter');

        if($filter){
            $url .= 'filter/' . $filter;
        }

        Pagination::init($this->actions->products->getTotal(), 15, $p, $url);

        $this->template->assign('pagination', Pagination::getPages());
        return $this->template->fetch($tpl);
    }

    public function old($action_id, $limit = 5)
    {
        return $this->actions->old($action_id, $limit);
    }
}