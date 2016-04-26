<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.02.16 : 15:24
 */
namespace controllers\engine\plugins;

use controllers\engine\Plugin;

defined("CPATH") or die();
/**
 * Class Dashboard
 * @name Dashboard
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Dashboard extends Plugin
{
    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['create','edit','delete', 'process'];
    }

    public function index()
    {
        return 'Dashboard::index';
    }
    public function create()
    {
        return 'Dashboard::create';
    }
    public function edit($id)
    {
        return 'Dashboard::edit';
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