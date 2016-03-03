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
 * Class ThreePlugin
 * @name ThreePlugin
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class SecondPlugin extends Plugin
{
    public function index()
    {
        return 'SecondPlugin::index';
    }
    public function create()
    {
        return 'SecondPlugin::create';
    }
    public function edit($id)
    {
        return 'SecondPlugin::edit';
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