<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;
use models\engine\ContentRelationship;

defined("CPATH") or die();

/**
 * Class PostsCategoriesSelect
 * @name Вибір категорії в статті
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class PostsCategoriesSelect extends Plugin
{
    private $categories;
    private $rs;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index'];
        $this->categories = new \models\engine\plugins\PostsCategories();
        $this->rs = new ContentRelationship();
    }

    public function index(){}

    private function getItems($parent_id)
    {
        $items = $this->categories->getItems($parent_id);

        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->categories->getItems($item['id']);
            }
        }

        return $items;
    }

    public function create($categories_id=0)
    {
        $selected_categories = [$categories_id];
        $this->template->assign('selected_categories', $selected_categories);
        $this->template->assign('categories', $this->getItems(0));
        return $this->template->fetch('plugins/content/posts/categories_select');
    }

    public function edit($id)
    {
        $this->template->assign('selected_categories', $this->rs->getCategories($id));
        $this->template->assign('categories', $this->getItems(0));
        return $this->template->fetch('plugins/content/posts/categories_select');
    }

    public function delete($id){}

    public function process($id)
    {
        $s = $this->categories->save($id);

        if(! $s){
            echo $this->categories->getDBErrorMessage();
        }
    }
}