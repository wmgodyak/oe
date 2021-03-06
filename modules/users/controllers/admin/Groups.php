<?php
namespace modules\users\controllers\admin;

use system\Backend;

/**
 * Class usersGroup
 * @package modules\users\controllers\admin
 */
class Groups extends Backend
{
    private $groups;

    public function __construct()
    {
        parent::__construct();

        $this->groups = new \modules\users\models\UsersGroup();
    }

    public function index(){}

    public function create($parent_id=0)
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['parent_id' => $parent_id]);
        $this->template->assign('groups', $this->groups->get(0));
        $this->template->assign('languages', $this->languages->get());
        $this->template->display('modules/users/groups/form');
    }

    public function edit($id)
    {
        $this->template->assign('action', 'edit');
        $this->template->assign('groups',    $this->groups->get(0));
        $this->template->assign('languages', $this->languages->get());
        $this->template->assign('data', $this->groups->getData($id));
        $this->template->assign('info', $this->groups->getInfo($id));

        $this->template->display('modules/users/groups/form');
    }

    public function delete($id)
    {
        return $this->groups->delete($id);
    }

    /**
     * @param int $id
     * @throws \Exception
     * @return null
     */
    public function process($id = 0)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $s=0; $i=[]; $m = null;

        $data['backend'] = 0;

        switch($this->request->post('action')){
            case 'create':
                $s = $this->groups->create($data, $info);
                break;
            case 'edit':
                if( $id > 0 ){
                    $s = $this->groups->update($id, $data, $info);
                }
                break;
            default:
                break;
        }

        if(!$s && $this->groups->hasError()){
            $m = $this->groups->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null, 'm' => $m];
    }

    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id', 'i');

        foreach ($this->groups->getItems($parent_id, 0) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['a_attr'] = array('id'=> $item['id'], 'href' => 'module/run/users/index/' . $item['id']);
            $item['li_attr'] = array('id'=> 'li_'.$item['id']);
            $item['type'] = $item['isfolder'] ? 'folder': 'file';

            $items[] = $item;
        }

        return $items;
    }

    public function move()
    {
        if(! $this->request->isPost()) die(403);

        $id            = $this->request->post('id', 'i');
        $old_parent    = $this->request->post('old_parent', 'i');
//        $old_position  = $this->request->post('old_position', 'i');
        $parent        = $this->request->post('parent', 'i');
        $position      = $this->request->post('position', 'i');

        if(empty($id)) return ;

        $this->groups->move($id, $old_parent, $parent, $position);

        if($this->groups->hasError()){
            echo $this->groups->getErrorMessage();
        }

        echo 'OK';
    }
}