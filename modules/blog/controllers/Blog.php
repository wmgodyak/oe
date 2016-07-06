<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\blog\controllers;

use helpers\Pagination;
use modules\blog\models\Categories;
use modules\blog\models\Posts;
use modules\blog\models\PostsViews;
use modules\blog\models\Tags;
use modules\comments\models\Comments;
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
    private $postViews;

    private $ipp = 5;
    private $total = 0;
    public $commentsEnabled = true; // todo check if module comments is installed
    private $comments;

    public function __construct()
    {
        parent::__construct();

        $this->posts = new Posts('post');
        $this->categories = new Categories('posts_categories');
        $this->tags = new Tags();
        $this->postViews = new PostsViews();

        if($this->commentsEnabled){
            $this->comments = new Comments();
        }
    }

    public function index(){}

    public function init()
    {
        $post = $this->page;
        $post['views'] = $this->postViews->getTotal($post['id']);
        if($this->commentsEnabled){
            $post['comments'] = [
                'total' => $this->comments->getTotal($post['id']),
//                'items' => $this->comments->get($post['id'])
            ];
        }

        $this->template->assign('post', $post);
    }

    /**
     * Posts categories
     * @return mixed
     */
    public function categories()
    {
        return $this->categories->get();
    }

    /**
     * Posts list vs pagination
     * @param int $categories_id
     * @param int $start
     * @param int $num
     * @return mixed|null
     */
    public function posts($categories_id = 0)
    {
        $start = (int) $this->request->param('p');
        $start --;
        if($start < 0) $start = 0;
        if($start > 0){
            $start = $start * $this->ipp;
        }

        $posts = $this->posts->get($categories_id, $start, $this->ipp);

        if(!$posts) return null;

        // save total posts count
        $this->total = $this->posts->getTotal();

        foreach ($posts as $k=>$post) {
            $posts[$k]['tags']  = $this->tags->get($post['id']);
            $posts[$k]['views'] = $this->postViews->getTotal($post['id']);
            if($this->commentsEnabled){
                $posts[$k]['comments'] = ['total' => $this->comments->getTotal($post['id'])];
            }
        }

        return $posts;
    }

    /**
     * display pagination
     * @param string $tpl
     * @return string
     */
    public function pagination($tpl = 'modules/pagination')
    {
        $p = $this->request->get('p', 'i');

        Pagination::init($this->total, $this->ipp, $p, $this->page['id'] . ';');

        $this->template->assign('pagination', Pagination::getPages());

        return $this->template->fetch($tpl);
    }

    public function tags($post_id)
    {
        return $this->tags->get($post_id);
    }

    /**
     * @param int $categories_id
     * @param int $start
     * @param int $num
     * @return mixed
     */
    public function latestPosts($categories_id = 0, $start = 0, $num = 10)
    {
        return $this->posts->get($categories_id, $start, $num );
    }

    public function setViewed($post_id)
    {
        header('Content-Type: application/javascript');
        $this->postViews->set($post_id);
        die;
    }

    public function hasError()
    {
        return $this->posts->hasError();
    }

    public function getError()
    {
        return $this->posts->getError();
    }
}