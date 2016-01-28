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
use helpers\FormValidation;
use models\engine\UsersGroup;

defined("CPATH") or die();

/**
 * Class UsersGroup
 * @package controllers\engine\plugins
 */
class AdminsGroup extends Plugin
{
    private $adminsGroup;
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->adminsGroup = new \models\engine\plugins\AdminsGroup();
        $this->usersGroup  = new UsersGroup();
    }

    public function index()
    {
        $this->template->assign('admins_groups_icon', $this->meta['icon']);
        return $this->template->fetch('plugins/admins/groups/tree');
    }

    public function create($parent_id=0)
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['parent_id' => $parent_id]);
        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('languages', $this->languages->get());
        $this->response->body($this->template->fetch('plugins/admins/groups/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('action', 'edit');
        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('languages', $this->languages->get());
        $this->template->assign('data', $this->adminsGroup->getData($id));
        $this->template->assign('info', $this->adminsGroup->getInfo($id));
        $this->response->body($this->template->fetch('plugins/admins/groups/form'))->asHtml();
    }

    public function delete($id)
    {
        return $this->adminsGroup->delete($id);
    }

    /**
     * @param $id
     * @throws \Exception
     */
    public function process($id = 0)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $s=0; $i=[];

        FormValidation::setRule(['rang'], FormValidation::REQUIRED);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->adminsGroup->create($data, $info);
                    if(! $s){
                        $i[] = ["data[rang]" => $this->adminsGroup->getDBErrorCode() .' '. $this->adminsGroup->getDBErrorMessage()];
                    }
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->adminsGroup->update($id, $data, $info);
                        if(! $s){
                            $i[] = ["data[rang]" => $this->adminsGroup->getDBErrorCode() .' '. $this->adminsGroup->getDBErrorMessage()];
                        }
                    }
                    break;
                default:
                    break;
            }
        }


        if(!$s && $this->adminsGroup->hasDBError()){
            echo $this->adminsGroup->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }

    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id  =$this->request->get('id');
        foreach ($this->adminsGroup->getItems($parent_id) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['a_attr'] = array('id'=> $item['id'], 'href' => './admins/index/' . $item['id']);
            $item['li_attr'] = array('id'=> 'li_'.$item['id']);
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
//        $old_position  = $this->request->post('old_position', 'i');
        $parent        = $this->request->post('parent', 'i');
        $position      = $this->request->post('position', 'i');

        if(empty($id)) return ;

        $this->adminsGroup->move($id, $old_parent, $parent, $position);
        // todo не знімає галочку isfolder з old_parent
        if($this->adminsGroup->hasDBError()){
            echo $this->adminsGroup->getDBErrorMessage();
        }

        echo 'OK';
    }
}