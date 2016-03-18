<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:33
 */

namespace controllers\engine;


use controllers\Engine;

defined("CPATH") or die();
/**
 * Class Dashboard
 * @name SmartEngine 7
 * @icon fa-home
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Dashboard extends Engine
{
    public function index()
    {
        $this->response->body($this->template->fetch('dashboard/index'));
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