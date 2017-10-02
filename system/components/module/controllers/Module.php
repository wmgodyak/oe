<?php

namespace system\components\module\controllers;

use system\Backend;
use system\models\Permissions;

defined("CPATH") or die();

/**
 * Class Module
 * @package system\components\module\controllers
 */
class Module extends Backend
{
    /**
     * @return mixed
     */
    public function run()
    {
        $params = func_get_args();

        if(empty($params)) {
            if($this->request->isGet()) {
                redirect('dashboard', 404);
            } else{
                die;
            }
        }


        $params = isset($params[0]) ? $params[0]  : $params;

        $action = 'index';
        if(is_string($params)){
            $params = explode('/', $params);
        }

        $module = array_shift($params);

        if ($this->request->isGet()){

            $this->request->param('module', $module);
            $this->request->param('controller', $module);
            $this->request->param('action', $action);
        }

        if (!Permissions::canModule($module, $action)) {
            Permissions::denied();
        }

        if(isset($params[1])){
            $_params = $params;

            $sub_module = array_shift($_params);
            $sub_sub_module = array_shift($_params);

            $ns = "\\modules\\$module\\controllers\\admin\\$sub_module\\" . ucfirst($sub_sub_module);

            $path = str_replace('\\', DIRECTORY_SEPARATOR, $ns . ".php");

            if(file_exists( DOCROOT . $path)){

                if(!empty($_params)){
                    $action = array_shift($_params);
                }

                return $this->call($ns, $action, $_params);
            }
        }

        if(isset($params[0])){
            $_params = $params;
            $sub_module = array_shift($_params);
            $ns = "\\modules\\$module\\controllers\\admin\\" . ucfirst($sub_module);
            $path = str_replace('\\', DIRECTORY_SEPARATOR, $ns . ".php");
            if(file_exists( DOCROOT . $path)){
                if(!empty($_params)){
                    $action = array_shift($_params);
                }

                return $this->call($ns, $action, $_params);
            }
        }

        $ns = "\\modules\\$module\\controllers\\admin\\" . ucfirst($module);
        if(!empty($params)){
            $action = array_shift($params);
        }
        return $this->call($ns, $action, $params);
    }

    /**
     * @param $ns
     * @param $action
     * @param array $params
     * @return mixed
     */
    private function call($ns, $action, $params = [])
    {
        $module = new $ns;
        if(!is_callable(array($module, $action))){
            if($this->request->isGet()) {
                redirect('dashboard', 404);
            } else{
                die;
            }
        }

        return call_user_func_array(array($module, $action), $params);
    }

    public function index(){}
    public function create(){}
    public function edit($id){}
    public function delete($id){}
    public function process($id){}
}