<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;

defined("CPATH") or die();

/**
 * Class Modules
 * @name Modules
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Modules extends Plugin
{
    private $modules;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index','delete','process'];
        $this->modules = new \models\engine\plugins\Modules();
    }

    public function index(){}

    public function create($id=0)
    {
        $this->getModules();
        $this->template->assign('ps', $this->modules->getPageSettings($id));
        return $this->template->fetch('plugins/content/pages/modules');
    }

    public function edit($id)
    {
        $this->getModules();
        $this->template->assign('ps', $this->modules->getPageSettings($id));
        return $this->template->fetch('plugins/content/pages/modules');
    }

    private function getModules()
    {
        $hide_actions = ['__construct', 'e_404', 'before', 'e404', '__set', '__get', 'dump', 'dDump', 'redirect','process','delete'];
        $path = 'controllers\modules\\';
        $modules = [];
        $r = $this->modules->get();
        foreach ($r as $k=>$module) {
            $controller = ucfirst($module['controller']);
            $class = new \ReflectionClass($path . $controller);
            $methods = $class->getMethods(\ReflectionMethod::IS_PUBLIC);

            foreach ($methods as $method) {
                if(in_array($method->name, $hide_actions)) continue;

                $modules[$controller][] = $controller .'::'. $method->name;

            }
        }
        $this->template->assign('modules', $modules);
    }

    public function delete($id){}

    public function process($id){}
}