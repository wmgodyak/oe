<?php

namespace system\components\translations\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\PHPDocReader;
use system\core\DataTables2;
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
        $t = new DataTables2('translations');

        $t
            -> ajax('translations/get')
            -> th(t('translations.code'), 'code', 0, 0, 'width: 300px')
            -> th(t('translations.text'), 'name', 0, 0 )
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 60px')
        ;

        $this->output($t->init());
    }

    public function get()
    {
        $t = new DataTables2('translations');
        $code = $this->languages->getDefault('code');
        $theme = $this->settings->get('app_theme_current');
        $fn = "themes/$theme/lang/$code.json";
        if(!file_exists(DOCROOT . $fn)){
            $fn = "themes/$theme/lang/en.json";
        }

        $res = [];

        $translations = array_merge($this->getModules($code), $this->getFileContent($fn));

        // assign buttons
        foreach ($translations as $row) {
            $res[] = [
                "<input value='{$row['id']}' onfocus='select()'>",
                $row['text'],
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    [
                        'class' => 'btn-primary b-translations-edit',
                        'title' => t('common.title_edit'),
                        'data-id' => $row['id'],
                        'data-path' => $row['path']
                    ]
                )
            ];
        }

        return $t->render($res, $t->getTotal());
    }

    /**
     * @param $lang_code
     * @return array
     */
    private function getModules($lang_code)
    {
        $modules_dir = 'modules';
        $modules = [];

        if ($handle = opendir(DOCROOT . $modules_dir)) {
            while (false !== ($module = readdir($handle))) {

                $fn = "$modules_dir/$module/lang/$lang_code.json";
                if(!file_exists(DOCROOT . $fn)){
                    $fn = "$modules_dir/$module/lang/en.json";
                }

                if(!file_exists(DOCROOT . $fn)) continue;

                $modules = array_merge($modules, $this->getFileContent($fn));
            }
            closedir($handle);
        }

        return $modules;
    }

    /**
     * @param $file
     * @return array
     */
    private function getFileContent($file)
    {
        $r = file_get_contents(DOCROOT . $file);
        $a = json_decode($r, true);

        $res = [];
        foreach ($a as $k=>$v) {
            if(is_array($v)){
                foreach ($v as $k1=>$v1) {
                    if(is_array($k1)){
                        foreach ($k1 as $k2=>$v2) {
                            $res[] = ['id'=> $k.'.'.$k1. $k2, 'text' => $v2, 'path' => $file];
                        }
                    } else {
                        $res[] = ['id'=> $k.'.'.$k1, 'text' => $v1, 'path' => $file];
                    }
                }
            } else {
                $res[] = ['id'=> $k, 'text' => $v, 'path' => $file];
            }
        }

        return $res;
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id = null)
    {
        $id   = $this->request->post('id');
        $path = $this->request->post('path');

        if(empty($id) || empty($path)) return 'Wrong id';

        $r = file_get_contents(DOCROOT . $path);
        $a = json_decode($r, true);

        d($a);

        return $this->template->fetch('system/translations/edit');
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