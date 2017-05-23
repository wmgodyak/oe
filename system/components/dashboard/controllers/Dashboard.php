<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:33
 */

namespace system\components\dashboard\controllers;

use system\Backend;

defined("CPATH") or die();
/**
 * Class Dashboard
 * @name SmartEngine 7
 * @icon fa-home
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Dashboard extends Backend
{
    public function index()
    {
        $this->output($this->template->fetch('system/dashboard/index'));
    }

    public function init()
    {
        $this->assignToNav(t('dashboard.action_index'), 'dashboard', 'fa-home', null, 1);
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}