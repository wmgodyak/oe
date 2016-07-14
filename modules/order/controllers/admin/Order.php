<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 14.07.16 : 17:22
 */

namespace modules\order\controllers\admin;

use system\Engine;

defined("CPATH") or die();

class Order extends Engine
{
    public function init()
    {
        $this->assignToNav('Замовлення', 'module/run/order', 'fa-money', null, 100);
        $this->assignToNav('Статуси', 'module/run/order/status', 'fa-money', 'module/run/order', 1);
        $this->template->assignScript('modules/order/js/admin/order.js');
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



    public function status()
    {
        include "Status.php";

        $params = func_get_args();

        $action = 'index';
        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new Status();

        call_user_func_array(array($controller, $action), $params);
    }

}