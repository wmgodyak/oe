<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 24.03.16 : 9:04
 */

namespace controllers\modules;

use controllers\App;

defined("CPATH") or die();
/**
 * Class Nav
 * @name Nav
 * @icon fa-nav
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Nav extends App
{
    private $nav;
    public function __construct()
    {
        parent::__construct();
        $this->nav = new \models\app\Nav();
    }

    public function index()
    {
        $this->top();
        $this->bottom();
    }

    public function top()
    {
        $this->template->assign('nav_top', $this->nav->get('top'));
    }

    public function bottom()
    {
        $this->template->assign('nav_bottom', $this->nav->get('bottom'));
    }
}