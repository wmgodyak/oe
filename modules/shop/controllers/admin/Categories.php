<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 21:03
 */

namespace modules\shop\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\components\content\controllers\Content;
use system\core\EventsHandler;
use system\models\ContentRelationship;

/**
 * Class Categories
 * @package modules\shop\controllers\admin
 */
class Categories extends Content
{
    private $content_relationship;
    private $categories;

    public function __construct()
    {
        parent::__construct('products_categories');

        $this->form_action = "module/run/shop/categories/process/";

        $this->content_relationship = new ContentRelationship();
        $this->categories = new \modules\shop\models\Categories('products_categories');

        // disable default features block
        $this->form_display_blocks['features'] = false;

        $this->languages_id = 1;
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/shop/categories/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/shop/categories/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('module/run/shop/categories/index/' . $parent_id)
//            ->orderDef(0, 'desc')
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 0,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);
        $t->get('c.isfolder',null,null,null);
        $t->get('CONCAT(u.name, \' \' , u.surname) as owner',null,null,null);


        if($this->request->isXhr()){
            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
                -> join('__users u on u.id=c.owner_id')
                -> where("c.status in ('published', 'hidden')");

            if($parent_id > 0){
                $t->where("c.parent_id={$parent_id}");
            }

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
                $icon_link = Icon::create('fa-external-link');
                $status = $this->t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/shop/categories/index/{$row['id']}'>{$icon}  {$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                    . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
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
                        ['class' => 'btn-primary', 'href' => "module/run/shop/categories/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    ($row['isfolder'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t($this->type.'.delete_question')]
                    ) : "")

                ;
            }

            echo $t->render($res, $t->getTotal());//$this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }


        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));
        $this->output($t->init());
    }


    /**
     * @param int $parent_id
     */
    public function create($parent_id = 0)
    {
        /**
         * modal create from tree context menu
         */
        if($this->request->isXhr()){
            $this->template->assign('content', ['parent_id' => $parent_id]);
            $this->template->assign('action', 'create');

            $this->response->body($this->template->fetch('shop/categories/form'));
            return '';
        }

        $id = parent::create(0);

        return $this->edit($id);
    }

    public function edit($id)
    {
        if($this->request->isXhr()){
            $this->template->assign('content', $this->categories->getData($id));
            $this->template->assign('action', 'edit');
            $this->response->body($this->template->fetch('shop/categories/form'));
            return '';
        }

        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/shop/categories' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));

        $cf = new categories\Features();
        EventsHandler::getInstance()->add('content.params.after', [$cf, 'index']);

        parent::edit($id);
    }

    public function delete($id)
    {
        $s = $this->categories->delete($id);

        $this->response->body(['s' => $s, 'm' => $this->categories->getErrorMessage()])->asJSON();
    }


    public function process($id=0)
    {
        if($this->request->post('modal')){

            $i=[]; $m = $this->t('common.update_success'); $s = 0;
            switch($this->request->post('action')){
                case 'create':
                    $id = $this->categories->create($id, $this->admin['id']);
                    if($id){
                        $s = $this->categories->update($id);
                    }
                    break;
                case 'edit':
                    $s = $this->categories->update($id);
                    break;
            }

            if(! $s){
                $i = $this->categories->getError();
                $m = $this->categories->getErrorMessage();
            }

            $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
            return null;
        }

        return parent::process($id);
    }


    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id', 'i');
        foreach ($this->categories->tree($parent_id) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['text'] .= " #{$item['id']}";
            $item['a_attr'] = ['id'=> $item['id'], 'href' => './module/run/shop/categories/index/' . $item['id']];
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

        if($this->categories->hasError()){
            return 0;
        }

        return 1;
    }

    public function features()
    {
        include "categories/Features.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new categories\Features();

        return call_user_func_array(array($controller, $action), $params);
    }
}