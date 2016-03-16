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
 * Class Nav
 * @name Дерево сторінок
 * @icon fa-folder-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine\plugins
 */
class Nav extends Plugin
{
    private $tree;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['delete', 'process'];
        $this->tree = new \models\engine\plugins\Nav();
        $this->template->assign('tree_icon', $this->meta['icon']);
    }

    public function index()
    {

        return $this->template->fetch('plugins/content/pages/tree');
    }

    public function create()
    {

        return $this->template->fetch('plugins/content/pages/tree');
    }

    public function edit($id)
    {

        return $this->template->fetch('plugins/content/pages/tree');
    }

    public function delete($id)
    {

        return $this->template->fetch('plugins/content/pages/tree');
    }

    public function process($id)
    {

        return $this->template->fetch('plugins/content/pages/tree');
    }

    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id');
        foreach ($this->tree->getItems($parent_id) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['text'] .= " #{$item['id']}";
            $item['a_attr'] = ['id'=> $item['id'], 'href' => './content/pages/edit/' . $item['id']];
            $item['li_attr'] = [
                'id'=> 'li_'.$item['id'],
                'class' => 'status-' . $item['status'],
                'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')

            ];
            $item['type'] = $item['isfolder'] ? 'folder': 'file';
//            $item['icon'] = 'fa fa-file icon-state-info icon-md';

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

        $this->tree->move($id, $old_parent, $parent, $position);

        if($this->tree->hasDBError()){
            return 0;
        }

        return 1;
    }
}