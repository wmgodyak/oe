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

defined("CPATH") or die();

/**
 * Class CustomersGroup
 * @name Customers Group
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class CustomersGroup extends Plugin
{
    private $customersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['create', 'edit', 'delete', 'process'];

        $this->customersGroup = new \models\engine\plugins\CustomersGroup();
    }

    /**
     * Customers Group list
     */
    public function index()
    {
        $this->template->assign('customers_groups_icon', $this->meta['icon']);
        return $this->template->fetch('customers/groups/tree');
    }

    /**
     * Create Customers Group
     * @param int $parent_id
     * @return null
     */
    public function create($parent_id=0)
    {
        $this->template->assign('action',    'create');
        $this->template->assign('data',      ['parent_id' => $parent_id]);
        $this->template->assign('groups',    $this->customersGroup->getGroups());
        $this->template->assign('languages', $this->languages->get());

        $this->response->body($this->template->fetch('customers/groups/form'))->asHtml();
    }

    /**
     * Edit Customers Group
     * @param $id
     * @return null
     */
    public function edit($id)
    {
        $this->template->assign('action',    'edit');
        $this->template->assign('groups',    $this->customersGroup->getGroups());
        $this->template->assign('languages', $this->languages->get());
        $this->template->assign('data',      $this->customersGroup->getData($id));
        $this->template->assign('info',      $this->customersGroup->getInfo($id));

        $this->response->body($this->template->fetch('customers/groups/form'))->asHtml();
    }

    /**
     * Delete Customers Group
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->customersGroup->delete($id);
    }

    /**
     * process form data
     * @param int $id
     * @throws \Exception
     * @return null
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
                    $s = $this->customersGroup->create($data, $info);
                    if(! $s){
                        $i[] = ["data[rang]" => $this->customersGroup->getDBErrorCode() .' '. $this->customersGroup->getDBErrorMessage()];
                    }
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->customersGroup->update($id, $data, $info);
                        if(! $s){
                            $i[] = ["data[rang]" => $this->customersGroup->getDBErrorCode() .' '. $this->customersGroup->getDBErrorMessage()];
                        }
                    }
                    break;
                default:
                    break;
            }
        }


        if(!$s && $this->customersGroup->hasDBError()){
            echo $this->customersGroup->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }

    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id','i');
        foreach ($this->customersGroup->getItems($parent_id, 100) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['a_attr'] = array('id'=> $item['id'], 'href' => './customers/index/' . $item['id']);
            $item['li_attr'] = array('id'=> 'li_'.$item['id']);
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
//        $old_position  = $this->request->post('old_position', 'i');
        $parent        = $this->request->post('parent', 'i');
        $position      = $this->request->post('position', 'i');

        if(empty($id)) return ;

        $this->customersGroup->move($id, $old_parent, $parent, $position);
        // todo не знімає галочку isfolder з old_parent
        if($this->customersGroup->hasDBError()){
            echo $this->customersGroup->getDBErrorMessage();
        }

        echo 'OK';
    }
}