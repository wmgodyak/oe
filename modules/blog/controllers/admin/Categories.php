<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 21:03
 */

namespace modules\blog\controllers\admin;

use system\Engine;
use system\models\ContentRelationship;

/**
 * Class Categories
 * @package modules\blog\controllers\admin
 */
class Categories extends Engine
{
    private $content_relationship;
    private $categories;

    public function __construct()
    {
        parent::__construct();

        $this->content_relationship = new ContentRelationship();
        $this->categories = new \modules\blog\models\Categories('posts_categories');
    }

    public function index()
    {
        return $this->template->fetch('blog/categories/form');
    }

    /**
     * @param int $parent_id
     */
    public function create($parent_id = 0)
    {
        $this->template->assign('content', ['parent_id' => $parent_id]);
        $this->template->assign('action', 'create');

        $this->response->body($this->template->fetch('blog/categories/form'));
    }

    public function edit($id)
    {
        $this->template->assign('content', $this->categories->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('blog/categories/form'));
    }

    public function delete($id)
    {
        $s = $this->categories->delete($id);

        $this->response->body(['s' => $s, 'm' => $this->categories->getErrorMessage()])->asJSON();
    }


    public function process($id=0)
    {
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
            $item['a_attr'] = ['id'=> $item['id'], 'href' => './module/run/blog/index/' . $item['id']];
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
}