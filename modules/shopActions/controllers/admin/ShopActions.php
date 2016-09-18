<?php
namespace modules\shopActions\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\components\content\controllers\Content;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentRelationship;

/**
 * Class ShopActions
 * @package modules\shopActions\controllers\admin
 */
class ShopActions extends Content
{
    private $relations;
    private $shopActions;

    public function __construct()
    {
        parent::__construct('actions');

        $this->form_action = "module/run/shopActions/process/";

        $this->form_display_blocks['features'] = false;
        $this->form_display_blocks['intro']    = false;
        $this->form_display_blocks['images']   = false;

        $this->form_display_params['parent']   = false;
        $this->form_display_params['owner']    = false;
        $this->form_display_params['pub_date'] = false;

        $this->relations = new ContentRelationship();
        $this->shopActions = new \modules\shopActions\models\admin\ShopActions();
    }

    public function init()
    {
        parent::init();

        $this->assignToNav('Акції', 'module/run/shopActions', null, 'module/run/shop');
        $this->template->assignScript('modules/shopActions/js/admin/shopActions.js');
        EventsHandler::getInstance()->add('content.params',[$this, 'params']);
    }

    /**
     * @param $content
     * @return string
     */
    public function params($content)
    {
        if(isset($content['type']) && $content['type'] == 'actions') {
            return $this->template->fetch('modules/shopActions/params');
        }
    }

    public function index($parent_id=0)
    {
        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/shopActions/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('module/run/shopActions/index/' . $parent_id)
            -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 0,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;

        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);


        if($this->request->isXhr()){
            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
                -> where("c.status in ('published', 'hidden')");

            if($parent_id > 0){
                $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$parent_id}");
            }

            $t-> execute();

            $res = array();

            foreach ($t->getResults(false) as $i=>$row) {
                $icon_link = Icon::create('fa-external-link');
                $status = $this->t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/shopActions/edit/{$row['id']}'>{$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                ;
                $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));
                $res[$i][] = $row['updated'] ? date('d.m.Y H:i:s', strtotime($row['updated'])) : '';
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Link::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-hide',
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/shopActions/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t($this->type.'.delete_question')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());
            return;
        }

        $this->output($t->init());
    }

    public function create()
    {
        $id = parent::create(0);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/shopActions' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        $this->template->assign('s_categories', $this->relations->getCategoriesFull($id));
        
        parent::edit($id);
    }

    public function process($id)
    {
        $a = parent::process($id, false);

        if($a['s']){
            $a['m'] = sprintf($this->t('shopActions.update_success'), "module/run/shopActions", "module/run/shopActions/create");
        }

        $this->response->body($a)->asJSON();
    }

    public function selectCategories($content_id)
    {
        $this->template->assign('old_categories', $this->relations->getCategories($content_id));
        $this->template->assign('content_id', $content_id);
        echo $this->template->fetch('modules/shopActions/categories_tree');
    }

    public function saveCategories()
    {
        $s = false;
        $selected   = $this->request->post('selected');
        $old        = $this->request->post('old');
        $content_id = $this->request->post('content_id', 'i');
        
        if(!empty($selected) && $content_id > 0){
            $a = explode(',', $selected);
            if(!empty($old)){
                $b = explode(',', $old);
                $a= array_merge($a, $b);
                $a = array_unique($a);
            }
            $s = $this->relations->saveContentCategories($content_id, $a, 'sa_categories');
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }

    public function getCategories()
    {
        $content_id = $this->request->post('content_id', 'i');
        if(empty($content_id)) die;

        $cat = $this->relations->getCategoriesFull($content_id, 0, 'sa_categories');
        $this->response->body(['items' => $cat])->asJSON();
    }

    public function catTree()
    {
        $items = array();
        $parent_id = $this->request->get('id', 'i');

        foreach ($this->mContent->tree($parent_id, 'products_categories') as $item) {
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

    public function categoriesDelete()
    {
        $s = false; $cat = null;
        $categories_id = $this->request->post('categories_id');
        $content_id       = $this->request->post('content_id', 'i');

        if(!empty($categories_id) && $content_id > 0){
            $s = $this->relations->delete($content_id, $categories_id);
        }

        $this->response->body(['s'=> $s, 'cat' => $cat])->asJSON();
    }

    public function getProducts()
    {
        $content_id = $this->request->post('content_id', 'i');
        if(empty($content_id)) die;

        $cat = $this->relations->getCategoriesFull($content_id, 0, 'sa_products');
        $this->response->body(['items' => $cat])->asJSON();
    }

    public function addProduct()
    {
        $s = false;
        $products_id = $this->request->post('products_id', 'i');
        $content_id = $this->request->post('content_id', 'i');

        if($products_id > 0  && $content_id > 0){
            $s = $this->relations->create($content_id, $products_id, 0, 'sa_products');
        }

        $this->response->body(['s'=> $s, 'e' => $this->relations->getErrorMessage()])->asJSON();
    }

    public function searchProducts()
    {
        $q = $this->request->post('q', 's');

        $items = [];
        if(!empty($q)){
            $items = $this->shopActions->searchProducts($q);
            foreach ($items as $k=>$item) {
                $items[$k]['text'] = "#{$item['id']} {$item['name']}";
            }
        }

        $res = array(
            'total_count'        => $this->shopActions->searchTotal(),
            'incomplete_results' => false,
            'results'            => $items
        );

        echo json_encode($res);
    }

    public function productsDelete()
    {
        $s = false;
        $products_id = $this->request->post('products_id');
        $content_id       = $this->request->post('content_id', 'i');

        if(!empty($products_id) && $content_id > 0){
            $s = $this->relations->delete($content_id, $products_id);
        }

        $this->response->body(['s'=> $s])->asJSON();
    }
}