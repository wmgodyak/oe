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
        $this->assignToNav(t('translations.action_index'), 'translations', 'fa-flag' , 'tools');
        $this->template->assignScript('system/components/translations/js/translations.js');
    }

    public function index()
    {
        $t = new DataTables2('translations');

        $t
            -> ajax('translations/get')
            -> th(t('translations.code'), 'code', 1, 1, 'width: 480px')
            -> th(t('translations.text'), 'name', 1, 1)
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 60px')
        ;

        $this->output($t->init());
    }

    public function get()
    {
        $start = !empty($_POST['start']) ? intval($_POST['start']) : 0;
        $length = !empty($_POST['length']) ? intval($_POST['length']) : 0;
        $search = !empty($_POST['search']['value']) ? trim(strip_tags($_POST['search']['value'])) : '';
        $order = !empty($_POST['order'][0]['column']) ? intval($_POST['order'][0]['column']) : 0;
        $direction = !empty($_POST['order'][0]['dir']) ? trim(strip_tags($_POST['order'][0]['dir'])) : 'asc';
        $t = new DataTables2('translations');
        $code = $this->languages->code;
        $theme = $this->settings->get('app_theme_current');
        $fn = "themes/$theme/lang/$code.json";
        if(!file_exists(DOCROOT . $fn)){
            $fn = "themes/$theme/lang/en.json";
        }

        $res = [];
        $translations = array_merge($this->getModules($code), $this->getFileContent($fn));

        if (mb_strlen($search) > 2) {
            $translations = array_filter($translations, function($v) use ($search){
                return (!empty($v['text']) && mb_stripos($v['text'], $search) !== false) || (!empty($v['id']) && mb_strpos($v['id'], $search) !== false);
            });
        }

        $total = count($translations);

        switch ($order) {
            case 0:
                if ($direction == 'desc') {
                    usort($translations, function($a, $b){
                        return strcasecmp($b['id'], $a['id']);
                    });
                } else {
                    usort($translations, function($a, $b){
                        return strcasecmp($a['id'], $b['id']);
                    });
                }
                break;
            case 1:
                if ($direction == 'desc') {
                    usort($translations, function($a, $b){
                        return mb_strcasecmp($b['text'], $a['text']);
                    });
                } else {
                    usort($translations, function($a, $b){
                        return mb_strcasecmp($a['text'], $b['text']);
                    });
                }
                break;
        }

        $translations = array_slice($translations, $start, $length);

        // assign buttons
        foreach ($translations as $row) {
            $res[] = [
                $row['mod'] . "<br><input readonly value='{$row['id']}' onfocus='select()'>",
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

        return $t->render($res, $total);
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
                if ($module == "." || $module == ".." || $module == '.htaccess' || $module == 'index.html')  continue;
                $fn = "$modules_dir/$module/lang/$lang_code.json";

                if(!file_exists(DOCROOT . $fn)){
                    $fn = "$modules_dir/$module/lang/en.json";
                }

                if(!file_exists(DOCROOT . $fn)) continue;

                $modules = array_merge($modules, $this->getFileContent($fn, $module));
            }
            closedir($handle);
        }

        return $modules;
    }

    private function tRow(&$res, $mod, $file, $a, $p_id = '')
    {
        foreach ($a as $k => $v) {
            if (empty($p_id)) {
                $id = $k;
            } else {
                $id = $p_id . '.' . $k;
            }
            if (is_array($v)) {
                $this->tRow($res, $mod, $file, $v, $id);
            } else {
                $res[] = ['id' => $id, 'text' => $v, 'path' => $file, 'mod' => $mod];
            }
        }
    }

    /**
     * @param $file
     * @param string $mod
     * @return array
     */
    private function getFileContent($file, $mod = '')
    {
        $r = file_get_contents(DOCROOT . $file);
        $a = json_decode($r, true);

        $res = [];

        if (empty($mod)) {
            $mod = 'theme';
        }
        $this->tRow($res, $mod, $file, $a);

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

        $dir_path = preg_replace('/[a-z]{2}\.json/', '', $path);

        $languages = $this->languages->languages->get();

        $data = array();

        foreach ($languages as $lang) {
            $file = DOCROOT . $dir_path . $lang['code'] . '.json';

            if (!file_exists($file)) {
                $file_content = file_get_contents(DOCROOT . $path);
                file_put_contents($file, $file_content);
            }
            $t = json_decode(file_get_contents($file), true);
            $data[$lang['code']] = dots_get($t, $id);
        }

        $this->template->assign('languages', $languages);
        $this->template->assign('data', $data);
        $this->template->assign('id', $id);
        $this->template->assign('path', $path);

        return $this->template->fetch('system/translations/edit');
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id = null)
    {
        $id   = $this->request->post('id');
        $path = $this->request->post('path');
        $data = $this->request->post('data');

        if(empty($id) || empty($path)) return 'Wrong id';

        $dir_path = preg_replace('/[a-z]{2}\.json/', '', $path);

        $languages = $this->languages->languages->get();

        foreach ($languages as $lang) {
            $file = DOCROOT . $dir_path . $lang['code'] . '.json';
            if (!file_exists($file)) {
                $file_content = file_get_contents(DOCROOT . $path);
                file_put_contents($file, $file_content);
            }
            $t = json_decode(file_get_contents($file), true);
            $t = dots_set($t, $id, $data[$lang['code']]);
            file_put_contents($file, json_encode($t, JSON_UNESCAPED_UNICODE));
        }
        return json_encode(array('s' => 1));
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

    public function csv()
    {
        $code = 'en';
        $theme = $this->settings->get('app_theme_current');
        $fn = "themes/$theme/lang/$code.json";;
        $translations = array_merge($this->getModules($code), $this->getFileContent($fn));
        header("Content-type: text/csv; charset=utf-8");
        header("Content-Disposition: inline; filename=translations".date("YmdHis").".csv; charset=utf-8");
        $csv = fopen('php://output', 'w');
        fputcsv($csv, array(
            'MODULE', 'CODE', 'TEXT'
        ), ';');
        foreach ($translations as $k => $item) {
            fputcsv($csv, array(
                $item['mod'],
                $item['id'],
                $item['text']
            ), ';');
        }
        fclose($csv);
        die();
    }
}