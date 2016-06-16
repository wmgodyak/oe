<?php

namespace system\components\settings\controllers;

use helpers\bootstrap\Button;
use system\Engine;

defined("CPATH") or die();

class Settings extends Engine
{
    private $mSettings;

    public function __construct()
    {
        parent::__construct();
        $this->mSettings = new \system\components\settings\models\Settings();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $sys_info = [];
        $sys_info['server'] = $_SERVER['SERVER_SOFTWARE'];
        $sys_info['php']    = phpversion();
        $sys_info['db']  = $this->mSettings->getVersion();

        $dirs = ['tmp', 'uploads', 'logs'];
        $dir_perm = [];

        foreach ($dirs as $k=>$v) {
            $dir_perm[$v] = is_writable(DOCROOT . $v);
        }

        $this->template->assign('dir_perm', $dir_perm);
        $this->template->assign('sys_info', $sys_info);
        $this->template->assign('items', $this->mSettings->get());
        $this->template->assign('com_url', APPURL . 'engine/settings');

        $this->output($this->template->fetch('settings/index'));
    }

    public function create()
    {

    }

    public function edit($id)
    {

    }

    public function delete($id)
    {

    }

    public function process($id=0)
    {
        $this->mSettings->update();
        $s = ! $this->mSettings->hasError();
        $m = $s ? $this->t('common.update_success') : $this->mSettings->getErrorMessage();
        $this->response->body(['s' => $s, 'm' => $m])->asJSON();
    }
}