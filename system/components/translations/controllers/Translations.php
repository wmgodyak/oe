<?php

namespace system\components\translations\controllers;

use helpers\bootstrap\Button;
use helpers\PHPDocReader;
use system\core\Lang;
use system\core\Request;
use system\Backend;
use system\models\Settings;

defined("CPATH") or die();

class Translations extends Backend
{
    public function init()
    {
        $this->assignToNav($this->t('translations.action_index'), 'translations', 'fa-flag' , 'tools');
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
        $this->template->assign('com_url', APPURL . "{$this->settings['backend_url']}/translations");

        $this->output($this->template->fetch('system/translations/index'));
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
        $theme_path = Settings::getInstance()->get('themes_path');
        $current = Settings::getInstance()->get('app_theme_current');

        $common = $this->request->post('common');

        if($common){
            foreach ($common as $code => $a) {
                $fn = DOCROOT . $theme_path . $current . "/lang/{$code}.ini";
                $data = $this->buildOutputString($a);
                file_put_contents($fn, $data);
            }
        }

        $modules = $this->request->post('modules');

        if($modules){
            foreach ($modules as $module => $a) {
                foreach ($a as $lang => $data) {
                    $fn = DOCROOT . "modules/{$module}/lang/{$lang}.ini";
                    $data = $this->buildOutputString($data);
                    file_put_contents($fn, $data);
                }
            }
        }

        $this->response->body(['s' => 1, 'm' => 'Переклади оновлено'])->asJSON();
    }


    /**
     * line-break chars, default *x: "\n", windows: "\r\n"
     *
     * @var string
     */
    private $linebreak = "\n";

    /**
     * quote Strings - if true,
     * writes ini files with doublequoted strings
     *
     * @var bool
     */
    private $quoteStrings = true;

    /**
     * string delimiter
     *
     * @var string
     */
    private $delim = '"';

    private function buildOutputString($sectionsarray)
    {
        $content = '';
        $sections = '';
        $globals  = '';
        if (!empty($sectionsarray)) {
            // 2 loops to write `globals' on top, alternative: buffer
            foreach ($sectionsarray as $section => $item) {
                if (!is_array($item)) {
                    $value    = $this->normalizeValue($item);
                    $globals .= $section . ' = ' . $value . $this->linebreak;
                }
            }
            $content .= $globals;
            foreach ($sectionsarray as $section => $item) {
                if (is_array($item)) {
                    $sections .= $this->linebreak
                        . "[" . $section . "]" . $this->linebreak;
                    foreach ($item as $key => $value) {
                        if (is_array($value)) {
                            foreach ($value as $arrkey => $arrvalue) {
                                $arrvalue  = $this->normalizeValue($arrvalue);
                                $arrkey    = $key . '[' . $arrkey . ']';
                                $sections .= $arrkey . ' = ' . $arrvalue
                                    . $this->linebreak;
                            }
                        } else {
                            $value     = $this->normalizeValue($value);
                            $sections .= $key . ' = ' . $value . $this->linebreak;
                        }
                    }
                }
            }
            $content .= $sections;
        }
        return $content;
    }

    /**
     * normalize a Value by determining the Type
     *
     * @param string $value value
     *
     * @return string
     */
    protected function normalizeValue($value)
    {
        if (is_bool($value)) {
            $value = $this->toBool($value);
            return $value;
        } elseif (is_numeric($value)) {
            return $value;
        }
        if ($this->quoteStrings) {
            $value = $this->delim . $value . $this->delim;
        }
        return $value;
    }

    public function toBool($value)
    {
        if ($value === true) {
            return 'yes';
        }
        return 'no';
    }

}