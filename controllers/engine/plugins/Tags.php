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
 * Class Tags
 * @name Tags
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Tags extends Plugin
{
    private $tags;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index','delete'];
        $this->tags = new \models\engine\plugins\Tags();
    }

    public function index(){}

    public function create($id=0)
    {
        $this->template->assign('content_tags', $this->tags->getContentSimple($id));
        return $this->template->fetch('plugins/content/tags');
    }

    public function edit($id)
    {
        $this->template->assign('content_tags', $this->tags->getContentSimple($id));
        return $this->template->fetch('plugins/content/tags');
    }

    public function delete($id){}

    public function process($id)
    {
        $this->tags->set($id);
    }
}