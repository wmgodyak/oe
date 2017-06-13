<?php

namespace modules\catalog\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\models\ContentRelationship;
use system\components\content\controllers\Content;

/**
 * Class products
 * @package modules\catalog\models
 */
class Products extends Content
{
    private $content_relationship;
    private $products;
    private $config;

    public function __construct()
    {
        $this->config = module_config('catalog');

        parent::__construct($this->config->type->product);

        $this->form_action = "module/run/catalog/products/process/";

        $this->content_relationship = new ContentRelationship();
        $this->products = new \modules\catalog\models\backend\Products($this->config->type->product);

        // disable default features block
        $this->form_display_blocks['features'] = false;
        $this->form_display_params['position'] = false;
        $this->form_display_params['owner']    = false;
        $this->form_display_params['parent']   = false;
        $this->form_display_params['pub_date'] = false;

        events()->add('content.main', [$this, 'displayCategories']);
    }

    public function index($category_id=0)
    {
        if($category_id > 0){
            $parents = $this->mContent->getParents($category_id);

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/catalog/products/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/catalog/products/create' . ($category_id? "/$category_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $ths = [
            [t('common.id'), 'c.id', 1, 1, 'width: 60px'],
            [t('common.name'), 'ci.name', 1, 1],
            [t('common.created'), 'c.created', 0,1, 'width: 200px'],
            [t('common.updated'), 'c.updated', 0, 1, 'width: 200px'],
            [t('common.tbl_func'), null, 0, 0, 'width: 180px']
        ];

        $ths = filter_apply('catalog.admin.products.table.th', $ths);

        $t  -> ajax('module/run/catalog/products/index/' . $category_id);

        foreach ($ths as $th) {
            $t->th(... $th);
        }

        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);
        $t->get('c.isfolder',null,null,null);


        if($this->request->isXhr()){
            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->config->type->product}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages->id}")
                -> where(" c.parent_id='$category_id' and c.status in ('published', 'hidden')");

            $t-> execute();

            $res = array();

            foreach ($t->getResults(false) as $i=>$row) {

                $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
                $icon_link = Icon::create('fa-external-link');
                $status = t($this->config->type->product .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/catalog/products/edit/{$row['id']}'>{$icon}  {$row['name']}</a>"
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
                                'class' => 'btn-primary b-'.$this->config->type->product.'-hide',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary b-'.$this->config->type->product.'-pub',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/catalog/products/edit/" . $row['id'], 'title' => t('common.title_edit')]
                    ) .
                    ($row['isfolder'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-'.$this->config->type->product.'-delete btn-danger', 'data-id' => $row['id'], 'title' => t($this->config->type->product.'.delete_question')]
                    ) : "")

                ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->template->assign('sidebar', $this->template->fetch('modules/catalog/categories/tree'));
        $this->output($t->init());
    }


    /**
     * @param int $category_id
     * @return string
     */
    public function create($category_id = 0)
    {
       $id = parent::create();

        return $this->edit($id);
    }

    public function edit($id)
    {
        $category_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/catalog/products' . ($category_id > 0 ? '/index/' . $category_id : '')]
        )
        );

        $this->template->assign('sidebar', $this->template->fetch('modules/catalog/categories/tree'));

        parent::edit($id);
    }

    public function delete($id)
    {
        $s = $this->products->delete($id);

        return ['s' => $s, 'm' => $this->products->getErrorMessage()];
    }

    public function process($id=0)
    {
        if($this->request->post('modal')){

            $i=[]; $m = t('common.update_success'); $s = 0;
            switch($this->request->post('action')){
                case 'create':
                    $id = $this->products->create($id, $this->admin['id']);
                    if($id){
                        $s = $this->products->update($id);
                    }
                    break;
                case 'edit':
                    $s = $this->products->update($id);
                    break;
            }

            if(! $s){
                $i = $this->products->getError();
                $m = $this->products->getErrorMessage();
            }

            return ['s'=>$s, 'i' => $i, 'm' => $m];
        }

        return parent::process($id);
    }

    public function displayCategories($content)
    {
        if($content['type'] != $this->config->type->product) return ;

        // display categories;

        $pc = new ProductsCategories($content);
        return $pc->index();
    }


}