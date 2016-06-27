<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\blog\controllers;

use modules\blog\models\Categories;
use modules\blog\models\Posts;
use modules\blog\models\Tags;
use system\Front;

/**
 * Class Blog
 * @package modules\blog\controllers
 */
class Blog extends Front
{
    private $posts;
    private $categories;
    private $tags;

    public function __construct()
    {
        parent::__construct();

        $this->posts = new Posts('post');
        $this->categories = new Categories('posts_categories');
        $this->tags = new Tags();
    }

    public function index()
    {
    }

    public function init()
    {
    }

    public function categories()
    {
        return $this->categories->get();
    }

    public function posts()
    {
        $posts = $this->posts->get();

        foreach ($posts as $k=>$post) {
            $posts[$k]['tags'] = $this->tags->get($post['id']);
        }

        return $posts;
    }

    public function tags($post_id)
    {
        return $this->tags->get($post_id);
    }
}