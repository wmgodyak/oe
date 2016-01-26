<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:16
 */

namespace controllers\engine\plugins;

use controllers\Engine;

defined("CPATH") or die();

/**
 * Class UsersGroup
 * @package controllers\engine\plugins
 */
class UsersGroup extends Engine
{
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->usersGroup = new \models\engine\plugins\UsersGroup();
    }


    public function index()
    {
//        die('oki');
        // TODO: Implement index() method.
        return $this->template->fetch('plugins/admins/groups/tree');
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

    public function tree($parent_id = 0)
    {
        if(! $this->request->isXhr()) die;

        $items = array();

        foreach ($this->usersGroup->getItems($parent_id) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['a_attr'] = array('id'=> $item['id']);
            $item['li_attr'] = array('id'=> $item['id']);
            $items[] = $item;
        }

        $this->response->body($items)->asJSON();
    }
}