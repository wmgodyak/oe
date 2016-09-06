<?php

namespace modules\categorySynonym\controllers\admin;

use system\core\EventsHandler;
use system\Engine;
use system\models\Content;
use system\models\ContentRelationship;

/**
 * Class CategorySynonym
 * @package modules\categorySynonym\controllers\admin
 */
class CategorySynonym extends Engine
{
    private $relations;
    private $content;

    public function __construct()
    {
        parent::__construct();

        $this->relations = new ContentRelationship();
        $this->content = new Content();
    }

    public function init()
    {
        parent::init();

        $this->template->assignScript('modules/categorySynonym/js/admin/categorySynonym.js');

        EventsHandler::getInstance()->add('content.params.after', [$this, 'index']);
    }

    public function index($content=null)
    {
        if($content['type'] != 'products_categories') return null;

        $this->template->assign('synonyms', $this->relations->getCategoriesFull($content['id']));

        return $this->template->fetch('modules/categorySynonym/index');
    }

    public function get()
    {
        $content_id = $this->request->post('content_id', 'i');
        $cat = $this->relations->getCategoriesFull($content_id);
        $this->response->body(['items' => $cat])->asJSON();
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

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        $this->template->assign('content_id', $id);
        echo $this->template->fetch('modules/categorySynonym/form');
    }

    public function delete($id)
    {
        $s = false; $cat = null;
        $categories_id = $this->request->post('categories_id');
        $content_id    = $this->request->post('content_id', 'i');
        if(!empty($categories_id) && $content_id > 0){
            $s = $this->relations->delete($content_id, $categories_id);
        }

        $this->response->body(['s'=> $s, 'cat' => $cat])->asJSON();
    }

    public function process($id)
    {
        $s = false;
        $selected = $this->request->post('selected');
        $content_id = $this->request->post('content_id', 'i');
        if(!empty($selected) && $content_id > 0){
            $a = explode(',', $selected);
            $s = $this->relations->saveContentCategories($content_id, $a);
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }
}