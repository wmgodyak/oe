<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.03.16 : 12:05
 */

namespace models\modules;

use models\app\Content;

defined("CPATH") or die();

/**
 * Class Blog
 * @name Blog
 * @icon fa-pencil
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Blog extends Content
{
    private $page_id       = 0;
    private $cat_types_id  = 0;
    private $post_types_id = 0;

    public function __construct($cat_types_id, $post_types_id, $page_id)
    {
        parent::__construct();

        $this->cat_types_id  = $cat_types_id;
        $this->post_types_id = $post_types_id;
        $this->page_id       = $page_id;
    }

    /**
     * @return mixed
     */
    public function getCategories()
    {
        return $this
            -> where("c.types_id={$this->cat_types_id}")
            -> orderBy("ci.name asc")
            -> getItems("c.id,ci.name,ci.title");
    }

    /**
     * @param $id
     * @param $start
     * @param $num
     * @return array
     */
    public function getPosts($id, $start, $num)
    {
        $res = [];
        $this->clearQuery();
        if($id <> $this->page_id){
            $this->join("content_relationship cr on cr.content_id=c.id and cr.categories_id={$id} ");
        }

        $items = $this
            -> where("c.types_id={$this->post_types_id}")
            -> join("users u on u.id=c.owner_id")
            -> orderBy("c.published desc")
            -> limit($start, $num)
//            -> debug()
            -> getItems("c.id, c.published, ci.name, ci.title, ci.description, CONCAT(u.name,' ', u.surname) as author_name, u.avatar as author_avatar ");

        foreach ($items as $item) {
            $item['image'] = $this->images->cover($item['id'], 'post');

            $date = new \DateTime($item['published']);
            $item['published'] = $date->format('F d, Y');

            $res[] = $item;
        }
        return $res;
    }

    public function getTotalPosts($id)
    {
         $this
            -> clearQuery()
            -> where("c.types_id={$this->post_types_id}");

        if($id <> $this->page_id){
            $this->join("content_relationship cr on cr.content_id=c.id and cr.categories_id={$id} ");
        }

        return $this-> getTotal();
    }

    public function getPrevPost($post_id)
    {
//        $pub = self::$db->select("select published from content where id = {$post_id} limit 1")->row('published');

        $r = $this
            -> clearQuery()
            -> where(" c.id < {$post_id} and c.types_id={$this->post_types_id}") //c.published <= '{$pub}' and
            -> orderBy("c.published desc")
            -> limit(0, 1)
//            -> debug()
            -> getItems("c.id, ci.name, ci.title");

        if(empty($r)) return null;

        return $r[0];
    }

    public function getNextPost($post_id)
    {
//        $pub = self::$db->select("select published from content where id = {$post_id} limit 1")->row('published');

        $r = $this
            -> clearQuery()
            -> where(" c.id > {$post_id} and c.types_id={$this->post_types_id}") //c.published >= '{$pub}' and
            -> orderBy("c.published desc")
            -> limit(0, 1)
//            -> debug()
            -> getItems("c.id, ci.name, ci.title");

        if(empty($r)) return null;

        return $r[0];
    }

    public function getTags($post_id){}
    public function getComments($post_id){}
}