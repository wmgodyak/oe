<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 18:12
 */

namespace modules\banners\controllers\admin;

use system\Engine;

defined("CPATH") or die();

class Places extends Engine
{
    public function index()
    {
        // TODO: Implement index() method.
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('banners/places/form'));
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