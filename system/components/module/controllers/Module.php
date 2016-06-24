<?php

namespace system\components\module\controllers;

use system\Engine;

defined("CPATH") or die();

class Module extends Engine
{
    public function run()
    {
        $params = func_get_args();

        if(empty($params)) {
            $this->redirect('dashboard', 404);
        }

        $module = array_shift($params);
        $ns     = "modules\\$module\\controllers\\admin\\";
        $action = 'index';

        if(!empty($params)){
            $action = array_shift($params);
        }

        $c = $ns . ucfirst($module);
        $controller = new $c;

        if(!is_callable(array($controller, $action))){
            $this->redirect('dashboard', 404);
        }

        $this->makeCrumbs($this->t($module . '.action_index'), "module/run/callbacks");

        $this->template->assign('title', $this->t($module . '.action_' . $action));
        $this->template->assign('name',  $this->t($module . '.action_' . $action));

        call_user_func_array(array($controller, $action), $params);
    }

    public function index()
    {

    }
    public function create()
    {

    }
    public function edit($id)
    {

    }
    public function delete($id)
    {

    }
    public function process($id)
    {
    }
}