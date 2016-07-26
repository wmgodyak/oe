<?php

namespace system\components\translations\controllers;

use helpers\bootstrap\Button;
use helpers\PHPDocReader;
use system\core\Lang;
use system\core\Request;
use system\Engine;
use system\models\Settings;

defined("CPATH") or die();

class Translations extends Engine
{
    public function init()
    {
        $this->assignToNav('Переклади', 'translations', 'fa-flag' , 'tools');
        $this->template->assignScript('system/components/translations/js/translations.js');
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
        $error = null;

        $theme_path = Settings::getInstance()->get('themes_path');

        $current = Settings::getInstance()->get('app_theme_current');
        $langs   = Lang::getInstance()->getLangs($current);
//        d($langs);
        $common = [];
        foreach ($langs as $code=>$name) {
            $fn = DOCROOT . $theme_path . $current . "/lang/{$code}.ini";
            if( !file_exists($fn)) continue;
            $common[$code] = parse_ini_file($fn, true);
        }

        $modules = [];
        foreach ($this->modules as $module => $instance) {
            $translations = [];
            foreach ($langs as $code=>$name) {
                $fn = DOCROOT . "modules/{$module}/lang/{$code}.ini";

                if( !file_exists($fn)) continue;

                $translations[$code] = parse_ini_file($fn, true);
            }

            $cls = 'modules\\'.$module.'\controllers\\'.ucfirst($module);
            $doc = PHPDocReader::getMeta(new $cls);
//            d($doc);
            $modules[$module] = ['name' => $doc['name'], 'translations' => $translations];

        }
        Request::getInstance()->setMode('backend');

        $this->template->assign('error', $error);
        $this->template->assign('langs', $this->languages->get());
        $this->template->assign('common', $common);
        $this->template->assign('modules', $modules);
        $this->template->assign('front', $this->languages->getDefault('code'));
        $this->template->assign('com_url', APPURL . 'engine/translations');

        $this->output($this->template->fetch('translations/index'));
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id = null)
    {
        d($_POST);
    }
}