<?php

namespace modules\shopBlog\controllers;

use system\core\EventsHandler;
use system\Front;

/**
 * Class ShopBlog
 * @name Статі для товарів
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\shopBlog\controllers
 */
class ShopBlog extends Front
{
    private $sb;

    public function __construct()
    {
        parent::__construct();

        $this->sb = new \modules\shopBlog\models\ShopBlog();
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('shop.categories.sidebar', [$this, 'displayCategoriesPosts']);
        EventsHandler::getInstance()->add('shop.product.sidebar', [$this, 'displayPosts']);
    }

    /**
     * @param $cat
     * @return string
     */
    public function displayCategoriesPosts($cat)
    {
        $this->template->assign('posts', $this->sb->getCategoriesPosts($cat['id']));
        return $this->template->fetch('modules/shopBlog/posts');
    }

    /**
     * @param $product
     * @return string
     */
    public function displayProductPosts($product)
    {
        $this->template->assign('posts', $this->sb->getProductsPosts($product['id']));
        return $this->template->fetch('modules/shopBlog/posts');
    }

    public function displayPosts($page)
    {
        if($page['type'] == 'products_categories'){
            return $this->displayCategoriesPosts($page);
        }

        $this->template->assign('posts', $this->sb->getPosts($page['id']));
        return $this->template->fetch('modules/shopBlog/posts');
    }

    /**
     * @param $categories_id
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function categoriesPosts($categories_id, $start = 0, $num = 3)
    {
        return $this->sb->getCategoriesPosts($categories_id, $start, $num);
    }

    /**
     * @param $products_id
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function productsPosts($products_id, $start = 0, $num = 3)
    {
        return $this->sb->getProductsPosts($products_id, $start, $num);
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function getPosts($content_id)
    {
        return $this->sb->getPosts($content_id);
    }
}