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
 * Class FirstPlugin
 * @name FirstPlugin
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class FirstPlugin extends Plugin
{
    public function index()
    {
        return 'FirstPlugin::index';
    }
    public function create()
    {
        return 'FirstPlugin::create';
    }
    public function edit($id)
    {
        return 'FirstPlugin::edit';
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