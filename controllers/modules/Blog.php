<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.03.16 : 15:32
 */
namespace controllers\modules;

use controllers\App;
use helpers\Pagination;

defined("CPATH") or die();
/**
 * Class Blog
 * @name Blog
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Blog extends App
{
    private $page_id   = 3;
    const CAT_TYPE_ID  = 3;
    const POST_TYPE_ID = 2;

    private $ipp = 5;

    private $blog;

    public function __construct()
    {
        parent::__construct();

        $this->blog = new \models\modules\Blog(self::CAT_TYPE_ID, self::POST_TYPE_ID, $this->page_id);

        $this->template->assign('blog_page_id', $this->page_id);
    }

    public function index()
    {
        $this->categories();
        $this->posts();
    }

    public function categories()
    {
        $blog = $this->template->getVars('blog');
        $blog['categories'] = $this->blog->getCategories();
        $this->template->assign('blog', $blog);
    }

    public function posts()
    {
        $id = $this->page['id'];
        $p  = $this->request->param('p');

        $total = $this->blog->getTotalPosts($id);

        Pagination::init($total, $this->ipp, $p, $id .';');

        $limit  = Pagination::getLimit();

        $posts = $this->blog->getPosts($id, $limit['start'], $limit['num']);

        $this->template->assign('pagination', Pagination::getPages());
        $this->template->assignToVar('blog', 'posts', $posts);
    }

    public function post()
    {
        $id = $this->page['id'];
        $post = $this->template->getVars('page');
        $date = new \DateTime($post['published']);
        $post['published'] = $date->format('F d, Y');

        $post['prev_post'] = $this->blog->getPrevPost($id);
        $post['next_post'] = $this->blog->getNextPost($id);
        $post['tags']      = $this->blog->getTags($id);

        $this->template->assign('post', $post);
    }

    public function comments($post_id){}
}