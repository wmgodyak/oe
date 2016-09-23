<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.09.16 : 14:27
 */

namespace modules\shop\controllers\admin\products\groupActions;

use system\Engine;
use system\models\Content;
use system\models\ContentRelationship;

defined("CPATH") or die();

/**
 * Class ChangeMainCategory
 * @package modules\shop\controllers\admin\products\groupActions
 */
class ChangeMainCategory extends Engine
{
    private $relations;
    private $content;
    public function __construct()
    {
        parent::__construct();
        $this->content = new Content();
        $this->relations = new ContentRelationship();
    }

    public function index()
    {
        $this->template->assign('products', $this->request->post('products'));
        $this->template->assign('is_main', $this->request->post('is_main'));
        echo $this->template->fetch('modules/shop/products/group_actions/categories_tree');
    }

    public function tree()
    {
        $items = array();
        $parent_id = $this->request->get('id', 'i');
        foreach ($this->content->tree($parent_id, 'products_categories') as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if ($parent_id > 0) {
                $item['parent'] = $parent_id;
            }
            $item['text'] = "#{$item['id']} {$item['text']} ";
            $item['li_attr'] = [
                'id' => 'li_' . $item['id'],
                'class' => 'status-' . $item['status'],
                'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')

            ];
            $item['type'] = $item['isfolder'] ? 'folder' : 'file';

            $items[] = $item;
        }

        $this->response->body($items)->asJSON();
    }

    public function update()
    {
        $s = false;
        $products      = $this->request->post('products');
        $categories_id = $this->request->post('selected', 'i');
        if(!empty($categories_id) && !empty($products)){
            foreach ($products as $k=>$products_id) {
                $s = $this->relations->saveMainCategory($products_id, $categories_id);
            }
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}