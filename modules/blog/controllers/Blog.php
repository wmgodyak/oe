<?php

namespace modules\blog\controllers;

use modules\blog\models\Categories;
use modules\blog\models\Posts;
use system\core\Route;
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
    public  $posts;
    private $categories;
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('blog');
        $this->posts = new Posts($this->config->post_type);
        $this->categories = new Categories($this->config->category_type);
    }

    public function index(){}

    public function init()
    {
        events()->add('boot', function(){

            Route::getInstance()->get('/blog/author/{id}', function($id){
                return $this->searchByAuthor($id);
            });

            Route::getInstance()->get('/blog/tag/{alpha}', function($tag){
                return $this->searchByTag($tag);
            });

            Route::getInstance()->get('/blog/post/collect/{id}', function($id = null){
                header('Content-Type: application/javascript');
                if(empty($id)) return null;
                $this->collect($id);
            });
        });

        events()->add('init', function($page){

            $this->template->assignScript('modules/blog/js/blog.js');

            $blog = [];
            $blog['id'] = $this->config->id;
            $this->template->assign('blog', $blog);

            if($page['type'] == $this->config->post_type){
                $this->displayPost($page);

            } elseif($page['type'] == $this->config->category_type){
                $this->displayCategory($page);
            }
        });

    }

    private function displayCategory($category)
    {
        $blog = [];
        $blog['id'] = $this->config->id;
        $errors = [];

        if($category['id'] != $this->config->id){
            $this->posts->categories_id = $category['id'];
        }

        if(isset($_GET['q'])){

            $blog['search'] = [];

            $this->posts->categories_id = 0;

            $q = $this->request->get('q', 's');
            $q = strip_tags(trim($q));
            $blog['search']['query'] = $q;

            if(strlen($q) < 3){
                $errors[] = t('blog.search.qs_min_len');
            } else {
                $a = explode(' ', $q);
                $sq = [];

                foreach ($a as $k=>$v) {
                    $v = trim($v);
                    if(empty($v) || strlen($v) < 3) continue;

                    $sq[] = " ( ci.name like '%$v%' or ci.keywords like '%$v%' ) ";
                }

                if(empty($sq)){
                    $errors[] = t('blog.search.qs_min_len');
                } else {
                    $this->posts->where[] = ' and ' . implode(' and ', $sq);
                }
            }
        }

        if(empty($errors)){
            $total = $this->posts->total();
        }

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp, $category['id'] . ';');
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total'] = $total;
            $category['posts'] = $this->posts->get();
            $blog['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $blog['category'] = $category;

        $this->template->assign('errors', $errors);
        $this->template->assign('blog', $blog);
    }

    private function displayPost($post)
    {
        $blog = [];
        $blog['id'] = $this->config->id;

        $post['categories'] = $this->posts->categories($post['id']);
        $post['tags'] = $this->posts->tags->get($post['id']);

        $post = filter_apply('blog.post', $post);

        $blog['post'] = $post;

//        dd($blog);

        $this->template->assign('blog', $blog);
    }


    public function searchByAuthor($author_id)
    {
        if(empty($author_id)){
            return $this->e404();
        }

        $blog = [];
        $blog['id'] = $this->config->id;
        $errors = [];

        // set page
        $page = $this->app->page->fullInfo($blog['id']);
        $category = $page;

        // search on all posts
        $this->posts->categories_id = 0;
        $this->posts->where[] = " and c.owner_id = {$author_id}";

        if(empty($errors)){
            $total = $this->posts->total();
        }

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp, $page['id'] . ';');
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total']  = $total;
            $category['posts']  = $this->posts->get();
            $blog['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $blog['category'] = $category;

        $this->template->assign('errors', $errors);
        $this->template->assign('blog', $blog);
        $this->display($page);
    }

    public function searchByTag($tag)
    {
        if(empty($tag)){
            return $this->e404();
        }

        $blog = []; $errors = [];

        $blog['id'] = $this->config->id;

        // set page
        $page = $this->app->page->fullInfo($blog['id']);
        $category = $page;

//        $this->posts->debug  =1;

        $this->posts->categories_id = 0;
        $category['tag'] = $tag;
        $this->posts->join[] = " join __tags t on t.tag like '$tag'";
        $this->posts->join[] = " join __posts_tags pt on pt.posts_id=c.id and pt.tags_id=t.id";

        if(empty($errors)){
            $total = $this->posts->total();
        }

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp, $page['id'] . ';');
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total']  = $total;
            $category['posts']  = $this->posts->get();
            $blog['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $blog['category'] = $category;

        $this->template->assign('errors', $errors);
        $this->template->assign('blog', $blog);
        $this->display($page);
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
     * @param int $parent_id
     * @return mixed
     */
    public function categories($parent_id = 0)
    {
        return $this->categories->get($parent_id);
    }

    /**
     * @param int $num
     * @return mixed
     */
    public function tags($num = 30)
    {
        return $this->posts->tags->popular($num);
    }

    /**
     * @param null $post_id
     */
    public function collect($post_id = null)
    {
        $this->posts->collect($post_id);
    }

    /**
     * @param $start - start from
     * @param $num - items quantity
     * @param $render - render posts
     * @return array
     */
    public function more()
    {
        $start = $this->request->post('start', 'i');
        $num   = $this->request->post('num', 'i');
        $render = $this->request->post('html', '1');
        $html = null;

        $this->posts->start = $start;
        $this->posts->num   = $num;

        $total = $this->posts->total();
        $posts = $this->posts->get();

        if($render == 1){
            $res = $posts;
            foreach ($res as $post) {
                $this->template->assign('post', $post);
                $html .= $this->template->fetch('modules/blog/post');
            }
        }

        return [
            'total' => $total,
            'posts' => $posts,
            'html'  => $html
        ];
    }
}