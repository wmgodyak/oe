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
 * Class AdminsGroup
 * @name Групи користувачів
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class AdminsGroup extends Plugin
{
    private $adminsGroup;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['create', 'edit', 'delete', 'process'];

        $this->adminsGroup = new \models\engine\plugins\AdminsGroup();
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
        $this->template->assign('groups', $this->adminsGroup->getItems(0));
        $this->template->assign('languages', $this->languages->get());
        $items = $this->getComponents();
        $items += $this->getPlugins();
        $this->template->assign('components', $items);
        $this->response->body($this->template->fetch('plugins/admins/groups/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('action', 'edit');
        $this->template->assign('groups', $this->adminsGroup->getItems(0));
        $this->template->assign('languages', $this->languages->get());
        $this->template->assign('data', $this->adminsGroup->getData($id));
        $this->template->assign('info', $this->adminsGroup->getInfo($id));

        $items = $this->getComponents();
        $items += $this->getPlugins();
        $this->template->assign('components', $items);

        $this->response->body($this->template->fetch('plugins/admins/groups/form'))->asHtml();
    }

    public function delete($id)
    {
        return $this->adminsGroup->delete($id);
    }

    private function getComponents()
    {
        $hide_components = ['DataTables', 'Lang', 'Plugin', 'Content', 'Permissions'];
        $hide_actions = ['__construct', 'e_404', 'before', 'e404', '__set', '__get', 'dump', 'dDump', 'redirect','process','delete'];
        $ns = '\controllers\engine\\';

        $items = [];
        $co = $this->adminsGroup->getComponents();
        foreach ($co as $k=>$controller) {
            if(strpos($controller, '/') === FALSE){
                $controller = ucfirst($controller);
            } else {
                $a = explode('/', $controller);
                $controller = ''; $c = count($a); $c --;
                foreach ($a as $i=>$v) {
                    if($i == $c) $v = ucfirst($v);
                    $controller .=  ($i>0 ? '\\' : '') . "$v";
                }
            }

            if(in_array($controller, $hide_components)) continue;

            $class = new \ReflectionClass($ns . $controller);
            $methods = $class->getMethods(\ReflectionMethod::IS_PUBLIC);

            foreach ($methods as $method) {
                if(in_array($method->name, $hide_actions)) continue;

                $items[$controller][] = $method->name;
            }
        }

        return $items;
    }

    private function getPlugins()
    {
        $hide_components = [];
        $hide_actions = ['__construct', 'e_404', 'before', 'e404', '__set', '__get', 'dump', 'dDump', 'redirect','process','delete'];
        $ns = '\controllers\engine\plugins\\';

        $items = [];
        $co = $this->adminsGroup->getPlugins();
        foreach ($co as $k=>$controller) {

            $controller = ucfirst($controller);

            if(in_array($controller, $hide_components)) continue;

            $class = new \ReflectionClass($ns . $controller);
            $methods = $class->getMethods(\ReflectionMethod::IS_PUBLIC);

            foreach ($methods as $method) {
                if(in_array($method->name, $hide_actions)) continue;

                $items['plugins\\'.$controller][] = $method->name;
            }
        }

        return $items;
    }

    /**
     * @param $ns
     * @param string $parent
     * @return array
     */
//    private function scanComponents($ns, $parent = '')
//    {
//        $dir = str_replace('\\', '/', $ns);
//        $hide_components = ['DataTables', 'Lang', 'Plugin', 'Content', 'Permissions'];
//        $hide_actions = ['__construct', 'e_404', 'before', 'e404', '__set', '__get', 'dump', 'dDump', 'redirect','process','delete'];
//        $items = [];
//        foreach (scandir(DOCROOT . $dir) as $item) {
//            if($item == '.' || $item == '..') continue;
//
//            $ext = substr($item, -3, 3);
//
//            if($ext != 'php' && is_dir(DOCROOT . $dir . $item)) {
//                $items += $this->scanComponents($ns . $item . '\\', $item . '\\');
//
//                continue;
//            }
//
//            $com = substr($item, 0, -4);
//
//            $controller = ucfirst($com);
//
//            if(in_array($controller, $hide_components)) continue;
//
//            $class = new \ReflectionClass($ns . $controller);
//            $methods = $class->getMethods(\ReflectionMethod::IS_PUBLIC);
//
//            foreach ($methods as $method) {
//                if(in_array($method->name, $hide_actions)) continue;
//
//                if(empty($parent)) {
//                    $controller = lcfirst($controller);
//                }
//                $items[$parent . $controller][] = $method->name;
//            }
//        }
//        return $items;
//    }

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
        $s=0; $i=[];

        $data['backend'] = 1;

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



        if(!$s && $this->adminsGroup->hasDBError()){
            echo $this->adminsGroup->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }

    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id  =$this->request->param('id');
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