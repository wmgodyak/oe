<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 18.06.16
 * Time: 14:52
 */

namespace system\components\admins\controllers;

use system\components\admins\models\AdminsGroup;
use system\Backend;

class AdminsGroups extends Backend
{
    private $adminsGroup;

    public function __construct()
    {
        parent::__construct();

        $this->adminsGroup = new AdminsGroup();
    }

    public function index(){}

    public function create($parent_id=0)
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['parent_id' => $parent_id]);
        $this->template->assign('groups', $this->adminsGroup->getItems(0, 1));
        $this->template->assign('languages', $this->languages->get());
//        $items = $this->getComponents();
//        $items += $this->getPlugins();
//        $this->template->assign('components', $items);
        $this->template->display('system/admins/groups/form');
    }

    public function edit($id)
    {
        $this->template->assign('action', 'edit');
        $this->template->assign('groups', $this->adminsGroup->getItems(0, 1));
        $this->template->assign('languages', $this->languages->get());
        $this->template->assign('data', $this->adminsGroup->getData($id));
        $this->template->assign('info', $this->adminsGroup->getInfo($id));

        $this->template->assign('modules', $this->getModules());
        $this->template->assign('components', $this->getSystemComponents());

        $this->template->display('system/admins/groups/form');
    }

    private function getSystemComponents()
    {
        $res = [];
        $dir = 'system/components/';
        $blc = ['module', 'admin', 'install'];
        $bla = ['init', '__construct', '__set', 'before', 'redirect'];

        if ($handle = opendir($dir)) {
            while (false !== ($c = readdir($handle))) {
                if($c != '.' && $c != '..' && ! in_array($c, $blc)){

                    $cl = ucfirst($c);
                    $cc = str_replace('/','\\', "{$dir}{$c}/controllers/{$cl}");

//                    echo "{$dir}{$c}/controllers/{$cl}<br>";

                    $class = new \ReflectionClass($cc);
                    foreach ($class->getMethods(\ReflectionMethod::IS_PUBLIC) as $method) {

                        if(in_array($method->name, $bla)) continue;

                        $res[$c][] = $method->name;
                    }
                }
            }
            closedir($handle);
        }
        return $res;
    }

    private function getModules()
    {
        $res = [];
        $dir = 'modules/';
        $blc = ['module', 'admin', 'install'];
        $bla = ['init', '__construct', '__set', 'before', 'redirect'];

        if ($handle = opendir($dir)) {
            while (false !== ($c = readdir($handle))) {
                if($c != '.' && $c != '..' && ! in_array($c, $blc)){

                    $cl = ucfirst($c);

                    if(!file_exists("{$dir}{$c}/controllers/admin/{$cl}.php")) continue;

                    $cc = str_replace('/','\\', "{$dir}{$c}/controllers/admin/{$cl}");

                    $class = new \ReflectionClass($cc);
                    foreach ($class->getMethods(\ReflectionMethod::IS_PUBLIC) as $method) {

                        if(in_array($method->name, $bla)) continue;

                        $res[$c][] = $method->name;
                    }
                }
            }
            closedir($handle);
        }
        return $res;
    }

    public function delete($id)
    {
        return $this->adminsGroup->delete($id);
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
        $s=0; $i=[];

        $data['backend'] = 1;

        switch($this->request->post('action')){
            case 'create':
                $s = $this->adminsGroup->create($data, $info);
                if(! $s){
                    $i[] = ["permissions[full_access]" => $this->adminsGroup->getErrorCode() .' '. $this->adminsGroup->getErrorMessage()];
                }
                break;
            case 'edit':
                if( $id > 0 ){
                    $s = $this->adminsGroup->update($id, $data, $info);
                    if(! $s){
                        $i[] = ["permissions[full_access]" => $this->adminsGroup->getErrorCode() .' '. $this->adminsGroup->getErrorMessage()];
                    }
                }
                break;
            default:
                break;
        }

        if(!$s && $this->adminsGroup->hasError()){
            echo $this->adminsGroup->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null];
    }


    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();
        $parent_id = $this->request->get('id', 'i');

        foreach ($this->adminsGroup->getItems($parent_id, 1) as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if( $parent_id > 0 ){
                $item['parent'] = $parent_id;
            }
            $item['a_attr'] = array('id'=> $item['id'], 'href' => './admins/index/' . $item['id']);
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

        $this->adminsGroup->move($id, $old_parent, $parent, $position);
        if($this->adminsGroup->hasError()){
            echo $this->adminsGroup->getErrorMessage();
        }

        echo 'OK';
    }
}