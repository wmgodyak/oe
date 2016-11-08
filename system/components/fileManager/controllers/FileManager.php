<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 08.11.16 : 10:46
 */


namespace system\components\fileManager\controllers;

use system\Backend;

defined("CPATH") or die();

/**
 * Class FileManager
 * @package system\components\fileManager\controllers
 */
class FileManager extends Backend
{
    public function init()
    {
        parent::init();
        $this->assignToNav($this->t('fileManager.action_index'), './fileManager', 'fa fa-file', 'tools', 8);
    }

    public function index()
    {
        $this->output($this->template->fetch("system/filemanager/index"));
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