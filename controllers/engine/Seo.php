<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.03.16 : 16:47
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;

defined("CPATH") or die();

/**
 * Class Settings
 * @name Seo налаштування
 * @icon fa-cogs
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Seo extends Engine
{
    private $mSettings;

    public function __construct()
    {
        parent::__construct();
        $this->mSettings = new \models\engine\Seo();
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
        $this->output($this->template->fetch('seo/index'));
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
        $s = ! $this->mSettings->hasDBError();
        $m = $s ? $this->t('common.update_success') : $this->mSettings->getDBErrorMessage();
        $this->response->body(['s' => $s, 'm' => $m])->asJSON();
    }
}