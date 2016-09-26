<?php

namespace modules\newsletter\controllers\admin;

defined("CPATH") or die();

/**
 * Class Newsletter
 * @package modules\newsletter\controllers\admin
 */
class Newsletter extends \system\Engine
{
    public function init()
    {
        parent::init();

        $this->assignToNav('Підписники', 'module/run/newsletter/subscribers', 'fa-list-alt');
        $this->template->assignScript('modules/newsletter/js/admin/Newsletter.js');
    }

    public function subscribers()
    {
        $action = 'index';
        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new newsletter\Subscribers();

        return call_user_func_array(array($controller, $action), $params);
    }



    public function index()
    {
        // TODO: Implement index() method.
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
}