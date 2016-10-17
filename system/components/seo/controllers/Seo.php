<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 10:35
 */

namespace system\components\seo\controllers;
use helpers\bootstrap\Button;
use system\Backend;

if ( !defined("CPATH") ) die();

class Seo extends Backend
{
    private $mSettings;

    public function __construct()
    {
        parent::__construct();
        $this->mSettings = new \system\components\seo\models\Seo();
    }

    public function init()
    {
        $this->assignToNav('Seo', 'seo', 'fa-file-text', 'tools', 100);
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
        $data  = $this->mSettings->get();
        $types = $this->mSettings->getContentTypes();
        $this->template->assign('data', $data);
        $this->template->assign('types', $types);
        $this->template->assign('com_url', APPURL . 'engine/seo');
        $this->output($this->template->fetch('system/seo/index'));
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