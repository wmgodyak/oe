<?php

namespace modules\newsletter\controllers\admin\newsletter\subscribers;

use system\Engine;

class Groups extends Engine
{
    private $groups;

    public function __construct()
    {
        parent::__construct();

        $this->groups = new \modules\newsletter\models\subscribers\Groups();
    }

    public function index(){}

    public function create($parent_id=0)
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('modules/newsletter/subscribers/groups/form'));
    }

    public function edit($id)
    {
        $this->template->assign('action', 'edit');
        $this->template->assign('data', $this->groups->getData($id));
        $this->response->body($this->template->fetch('modules/newsletter/subscribers/groups/form'));
    }

    public function delete($id)
    {
        echo $this->groups->delete($id);
    }

    /**
     * @param int $id
     * @throws \Exception
     * @return null
     */
    public function process($id = 0)
    {
        if(! $this->request->isPost()) die;

        $name = $this->request->post('name');
        $s=0; $i=[];

        switch($this->request->post('action')){
            case 'create':
                $s = $this->groups->create($name);
                if(! $s){
                    $i[] = ["name" => $this->groups->getErrorCode() .' '. $this->groups->getErrorMessage()];
                }
                break;
            case 'edit':
                if( $id > 0 ){
                    $s = $this->groups->update($id, $name);
                    if(! $s){
                        $i[] = ["name" => $this->groups->getErrorCode() .' '. $this->groups->getErrorMessage()];
                    }
                }
                break;
            default:
                break;
        }

        if(!$s && $this->groups->hasError()){
            echo $this->groups->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }


    public function tree()
    {
        if(! $this->request->isXhr()) die;

        $items = array();

        foreach ($this->groups->get() as $item) {

            $item['a_attr'] = array('id'=> $item['id'], 'href' => 'module/run/newsletter/subscribers/index/' . $item['id']);
            $item['li_attr'] = array('id'=> 'li_'.$item['id']);
            $item['type'] = 'file';

            $items[] = $item;
        }

        $this->response->body($items)->asJSON();
    }
}