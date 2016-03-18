<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:16
 */

namespace controllers\engine\plugins;

use controllers\Engine;
use controllers\engine\Plugin;

defined("CPATH") or die();

/**
 * Class PostsCategories
 * @name Категорії статтей
 * @icon fa-folder-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine\plugins
 */
class PostsCategories extends Plugin
{
    private $categories;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['delete', 'process'];
        $this->categories = new \models\engine\plugins\PostsCategories();
        $this->template->assign('tree_icon', $this->meta['icon']);
    }

    public function index()
    {
        return $this->template->fetch('plugins/content/posts/categories');
    }

    public function create()
    {
        return $this->template->fetch('plugins/content/posts/categories');
    }

    public function edit($id)
    {
        return $this->template->fetch('plugins/content/posts/categories');
    }

    public function delete($id)
    {

    }
    public function categories()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id');
        foreach ($this->categories->getItems($parent_id) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['text'] .= " #{$item['id']}";
            $item['a_attr'] = ['id'=> $item['id'], 'href' => './content/posts/index/' . $item['id']];
            $item['li_attr'] = [
                'id'=> 'li_'.$item['id'],
                'class' => 'status-' . $item['status'],
                'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')

            ];
            $item['type'] = $item['isfolder'] ? 'folder': 'file';

            $items[] = $item;
        }

        $this->response->body($items)->asJSON();
    }

    public function move()
    {
        if(! $this->request->isPost()) die(403);

        $id            = $this->request->post('id', 'i');
        $old_parent    = $this->request->post('old_parent', 'i');
        $parent        = $this->request->post('parent', 'i');
        $position      = $this->request->post('position', 'i');

        if(empty($id)) return 0;

        $this->categories->move($id, $old_parent, $parent, $position);

        if($this->categories->hasDBError()){
            return 0;
        }

        return 1;
    }

    public function createCategories($parent_id=0)
    {
        $this->template->assign('content', ['parent_id' => $parent_id]);
        $this->template->assign('action', 'create');
        return $this->template->fetch('plugins/content/posts/createCategories');
    }


    public function editCategories($id)
    {
        $this->template->assign('content', $this->categories->getData($id));
        $this->template->assign('action', 'edit');
        return $this->template->fetch('plugins/content/posts/createCategories');
    }

    public function process($id=0)
    {
        $i=[]; $m = $this->t('common.update_success'); $s = 0;
        switch($this->request->post('action')){
            case 'create':
                $id = $this->categories->create($id);
                if($id){
                    $s = $this->categories->update($id);
                }
                break;
            case 'edit':
                $s = $this->categories->update($id);
                break;
        }

        if(! $s){
            $i = $this->categories->getDBError();
            $m = $this->categories->getDBErrorMessage();
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

}