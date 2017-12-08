<?php

namespace modules\blog\controllers;

use modules\blog\models\Categories;
use modules\blog\models\Posts;
use modules\blog\models\Tags;
use system\core\Route;
use system\Frontend;
use system\models\Users;

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

    protected $config;

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

            Route::getInstance()->get('blog/author/{id}', function($id){
               return $this->authorPosts($id);
            });

            Route::getInstance()->get('blog/tag/{alpha}', function($tag){
                return $this->searchByTag($tag);
            });

            Route::getInstance()->get('blog/search', function(){
                $q = $this->request->get('q', 's');
                return $this->search($q);
            });

            Route::getInstance()->get('blog/post/collect/{id}', function($id = null){

                header('Content-Type: application/javascript');

                if(empty($id)) return null;

                $this->posts->collect($id);
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
        if($category['id'] != $this->config->id){
            $this->posts->categories_id = $category['id'];
        }

        $total = $this->posts->total();

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp, $category['id'] . ';');
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total'] = $total;
            $category['posts'] = $this->posts->get();
            $category['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $this->template->assign('category', $category);
    }

    private function displayPost($post)
    {
        $blog = [];
        $blog['id'] = $this->config->id;


        $u = new Users();
        $post['author']     = $u->getData($post['owner_id']);
        $post['categories'] = $this->posts->categories($post['id']);
        $post['tags']       = $this->posts->tags->get($post['id']);
        $post['views']      = (int)$this->posts->meta->get($post['id'], 'views', true);
        $post['related']    = $this->posts->related($post['id'], $this->config->related);

        $post['prev'] = $this->posts->prev($post['id']);
        $post['next'] = $this->posts->next($post['id']);


        $post = filter_apply('blog.post', $post);

        $this->template->assign('blog', $blog);
        $this->template->assign('post', $post);
    }

    public function search($q)
    {
        $category= []; $errors = []; $search = [];

        $q = strip_tags(trim($q));

        $blog = [];
        $blog['id'] = $this->config->id;

        $search['q'] = $q;

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
                $this->posts->where[] = "(". implode(' and ', $sq) .")";
            }
        }

        if(!empty($errors)){
            $this->template->assign('errors', $errors);
            return $this->template->fetch('modules/blog/author_posts');
        }

        $this->posts->categories_id = 0;

        $total = $this->posts->total();

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp, $this->config->route->search);
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total']  = $total;
            $category['posts']  = $this->posts->get();
            $category['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $this->template->assign('search', $search);
        $this->template->assign('category', $category);
        $this->template->assign('blog', $blog);

        return $this->template->fetch('modules/blog/search_posts');

    }
    
    public function authorPosts($author_id)
    {
        $author_id = (int)$author_id;

        if(empty($author_id)){
            return $this->e404();
        }

        $u = new Users();
        $author = $u->getData($author_id);

        if(empty($author)){
            return $this->e404();
        }

        $url = str_replace('{author}', $author_id, $this->config->route->author);
        $blog = [];
        $blog['id'] = $this->config->id;
        $category = [];

        $this->posts->categories_id = 0;
        $this->posts->where[] = " c.owner_id = {$author_id}";

        $total = $this->posts->total();

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp,  $url);
            $limit = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total']  = $total;
            $category['posts']  = $this->posts->get();
            $category['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $this->template->assign('author', $author);
        $this->template->assign('category', $category);
        $this->template->assign('blog', $blog);

        return $this->template->fetch('modules/blog/author_posts');
    }

    public function searchByTag($tag)
    {
        if(empty($tag)){
            return $this->e404();
        }

        $tags = new Tags();

        $myTag = $tags->data($tag);

        if(empty($myTag)){
            return $this->e404();
        }

        $url  = str_replace('{tag}', $tag, $this->config->route->author);

        $blog = [];
        $blog['id'] = $this->config->id;

        $category = [];

        $this->posts->categories_id = 0;
        $category['tag']     = $myTag;
        $this->posts->join[] = " join __posts_tags pt on pt.posts_id=c.id and pt.tags_id={$myTag['id']}";

        $total = $this->posts->total();

        if(!empty($total)){
            $pagination = $this->app->pagination->init($total, $this->config->ipp,  $url);
            $limit      = $pagination->getLimit();

            $this->posts->start = $limit[0];
            $this->posts->num = $limit[1];

            $category['total']  = $total;
            $category['posts']  = $this->posts->get();
            $category['pagination'] = $pagination;
        }

        $category = filter_apply('blog.category', $category);

        $this->template->assign('category', $category);
        $this->template->assign('blog', $blog);

        return $this->template->fetch('modules/blog/tags_posts');
    }

    /**
     * @param int $num
     * @param int $start
     * @return array
     */
    public function posts($num, $start = 0)
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

    public function ajax()
    {
        dd($_SERVER);
    }
}