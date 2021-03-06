<?php

namespace system\components\settings\controllers;

use helpers\bootstrap\Button;
use system\core\EventsHandler;
use system\Backend;

defined("CPATH") or die();

class Settings extends Backend
{
    private $mSettings;

    public function __construct()
    {
        parent::__construct();
        $this->mSettings = new \system\components\settings\models\Settings();
    }

    public function init()
    {
        $this->assignToNav(t('tools.action_index'), 'tools', 'fa-cog', null, 400);
        $this->assignToNav(t('settings.action_index'), 'settings', 'fa-file-text', null, 500);
        $this->assignToNav(t('settings.general'), 'settings', 'fa-file-text', 'settings', 10);
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_save'),
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

//        $e = EventsHandler::getInstance()->getEventCallbacks('system.cron.run');
//        $e = EventsHandler::getInstance()->getEvents();
//        d($e);die;

        $this->template->assign('dir_perm', $dir_perm);
        $this->template->assign('sys_info', $sys_info);
        $this->template->assign('items', $this->mSettings->get());
        $this->template->assign('com_url', APPURL . "{$this->settings->get('backend_url')}/settings");

        $this->output($this->template->fetch('system/settings/index'));
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
        $m = $s ? t('common.update_success') : $this->mSettings->getErrorMessage();
        return ['s' => $s, 'm' => $m];
    }
}