<?php

namespace modules\blog\controllers;

use modules\blog\models\Categories;
use modules\blog\models\Posts;
use system\core\EventsHandler;
use system\Frontend;

/**
 * Class Blog
 * @name Блог
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\blog\controllers
 */
class Blog extends Frontend
{
    private $posts;
    private $categories;
    private $config =
        [
            'ipp'     => 5,
            'blog_id' => 4
        ];

    public function __construct()
    {
        parent::__construct();

        $this->posts = new Posts();
        $this->categories = new Categories('posts_categories');

        $user_conf = $this->settings->get('modules.Blog.config');
        if(!empty($user_conf)){
            $this->config = array_merge($this->config, $user_conf);
        }
    }

    public function index(){}

    public function init()
    {
        $this->template->assign('blog_id', $this->config['blog_id']);

        if($this->page['type'] == 'post'){

            $post = $this->page;
            $post['categories'] = $this->posts->categories($post['id']);
            $post['tags'] = $this->posts->tags->get($post['id']);
            $this->template->assign('post', $post);

        } elseif($this->page['type'] == 'posts_categories'){

            $category = $this->page;

            if($this->page['id'] != $this->config['blog_id']){
                $this->posts->categories_id = $this->page['id'];
            }

            $tag = $this->request->param('tag');
            if($tag){
                $this->posts->categories_id = 0;
                $category['tag'] = $tag;
                $this->posts->join[] = " join __tags t on t.tag like '$tag'";
                $this->posts->join[] = " join __posts_tags pt on pt.posts_id=c.id and pt.tags_id=t.id";
            }

            $owner_id = (int)$this->request->param('author');
            if($owner_id > 0){
                $this->posts->categories_id = 0;
                $this->posts->where[] = " and c.owner_id = {$owner_id}";
            }

            if(isset($_GET['q'])){

                $this->posts->categories_id = 0;

                $q = $this->request->get('q', 's');
                $q = strip_tags(trim($q));

                if(strlen($q) < 3){
                    $category['error'] = $this->t('blog.search.qs_min_len');
                } else {
                    $a = explode(' ', $q);
                    $sq = [];

                    foreach ($a as $k=>$v) {
                        $v = trim($v);
                        if(empty($v) || strlen($v) < 3) continue;

                        $sq[] = " ( ci.name like '%$v%' or ci.keywords like '%$v%' ) ";
                    }

                    if(empty($sq)){
                        $category['error'] = $this->t('blog.search.qs_min_len');
                    } else {
                        $this->posts->where[] = ' and ' . implode(' and ', $sq);
                    }
                }
            }

            $total = $this->posts->total();

            if(!empty($total)){
                $pagination = $this->app->pagination->init($total, $this->config['ipp'], $this->page['id'] . ';');
                $limit = $pagination->getLimit();

                $this->posts->start = $limit[0];
                $this->posts->num = $limit[1];

                $category['posts_total'] = $total;
                $category['posts'] = $this->posts->get();

                $this->template->assign('pagination', $pagination->render());
            }

            $this->template->assign('category', $category);

        }
    }

    /**
     * @param $start
     * @param $num
     * @return array
     */
    public function posts($start, $num)
    {
        $this->posts->start = $start;
        $this->posts->num   = $num;

        return $this->posts->get();
    }

    /**
     * @param $parent_id
     * @param bool $recursive
     * @return mixed
     */
    public function categories($parent_id = 0, $recursive = false)
    {
        return $this->categories->get($parent_id, $recursive);
    }

    /**
     * @param $post_id
     * @param int $start
     * @param int $num
     * @return array
     */
    public function relatedPosts($post_id, $start = 0, $num = 10)
    {
        return $this->posts->related($post_id, $start, $num );
    }

    /**
     * @param int $num
     * @return mixed
     */
    public function popularTags($num = 1000)
    {
        return $this->posts->tags->popular($num);
    }

    /**
     * @param null $post_id
     */
    public function collect($post_id = null)
    {
        header('Content-Type: application/javascript');
        if($post_id > 0) $this->posts->collect($post_id);
        die;
    }
}