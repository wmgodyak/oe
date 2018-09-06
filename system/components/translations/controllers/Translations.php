<?php

namespace system\components\translations\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataTables2;
use system\Backend;

defined("CPATH") or die();

class Translations extends Backend
{
    protected $default_code;
    protected $default_theme;
    protected $file_ext = 'json';
    protected $theme_path;
    protected $localization_file;

    public function __construct()
    {
        parent::__construct();
        $this->default_code = $this->languages->getDefault('code');
        $this->default_theme = $this->settings->get('app_theme_current');
        $this->getThemePath();
        $this->checkIssetLocalizationFile();
    }

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
            -> th(t('translations.code'), 'code', 1, 1, 'width: 300px')
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
        $translations = $this->getAllTranslation();

        if (mb_strlen($search) > 2) {
            $translations = array_filter($translations, function($v) use ($search){
                return (!empty($v['text']) && mb_strpos($v['text'], $search) !== false) || (!empty($v['id']) && mb_strpos($v['id'], $search) !== false);
            });
        }
        $total = count($translations);
        $translations = array_slice($translations, $start, $length);
        switch ($order) {
            case 0:
                if ($direction == 'desc') {
                    usort($translations, function($a, $b){
                        return strcmp($b['id'], $a['id']);
                    });
                } else {
                    usort($translations, function($a, $b){
                        return strcmp($a['id'], $b['id']);
                    });
                }
                break;
            case 1:
                if ($direction == 'desc') {
                    usort($translations, function($a, $b){
                        return strcmp($b['text'], $a['text']);
                    });
                } else {
                    usort($translations, function($a, $b){
                        return strcmp($a['text'], $b['text']);
                    });
                }
                break;
        }
        $res = [];
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

        return $t->render($res, $total);
    }

    private function checkIssetLocalizationFile()
    {
        $file_name = $this->default_code.'.'.$this->file_ext;
        if(!is_dir($this->theme_path) && !file_exists($this->theme_path)) {
            if(!mkdir($this->theme_path, 0777, true)) {
                die('Cannot create localization folder');
            }
        }
        $this->localization_file = $this->theme_path.'/'.$file_name;
    }

    private function getThemePath()
    {
        $path = "themes/".$this->default_theme."/lang";
        $this->theme_path = str_replace('//','/', $path);
    }

    private function getAllTranslation()
    {
        $modules = $this->getModules($this->default_code);
        $themes = $this->getFileContent($this->localization_file);
        $translation = array_merge($modules,$themes);
        if(!file_exists($this->localization_file)) {
            if(is_bool(file_put_contents($this->localization_file, $this->transformArray($translation)))) {
                return "We have a problem with creating file localization";
            }
        }
        return $translation;
    }

    private function transformArray($array)
    {
        $transformation = [];
        if(!empty($array)) {
            foreach ($array as $item) {
                $a = $this->stringToArray($item['id'], $item['text']);
                $transformation = array_replace_recursive($a, $transformation);
            }
        }
        return json_encode($transformation);
    }

    function stringToArray($string, $value = '')
    {
        $keys_array = explode('.',$string);
        if (count($keys_array) === 1) {
            return array("{$string}" => $value);
        }
        $key = reset($keys_array);
        $string = str_replace($key.'.','', $string);
        $result = array(
            "{$key}" => $this->stringToArray($string, $value),
        );
        return $result;
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

                if ($module == "." || $module == ".." || $module == '.htaccess' || $module == 'index.html') continue;

                $fn = "$modules_dir/$module/lang/$lang_code.json";
                if(!file_exists(DOCROOT . $fn)){
                    $fn = "$modules_dir/$module/lang/en.json";
                }

                if(!file_exists(DOCROOT . $fn)) continue;

                $arratFromFile = $this->getFileContent($fn, $module);

                if(!empty($arratFromFile)) {
                    $modules = array_merge($arratFromFile, $modules);
                }
            }
            closedir($handle);
        }
        return $modules;
    }

    /**
     * @param $file
     * @return array
     */
    private function getFileContent($file, $module = '')
    {
        $file = str_replace('//','/', $file);
        if(file_exists($file)) {
            $r = file_get_contents($file);
            if (!empty($r)) {
                $a = json_decode($r, true);
                if(!empty($a)) {
                    return $this->createTranslationArray($a, $file, $module);
                }
            }
        }
        return [];
    }

    private function createTranslationArray($array, $path, $parent_key = '', $res = [])
    {
        foreach ($array as $key=>$value) {
            if(is_array($value)) {
                $res = $this->createTranslationArray($value, $path, ($parent_key == '') ? $key : $parent_key.'.'.$key, $res)    ;
            } else {
                $res[($parent_key == '') ? $key : $parent_key.'.'.$key] = ['id'=> ($parent_key == '') ? $key : $parent_key.'.'.$key, 'text' => $value, 'path' => $path];
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

        $dir_path = preg_replace('/[a-z]{2}\.json/', '', $path);

        $languages = $this->languages->languages->get();

        $data = array();
        foreach ($languages as $lang) {
            $file = $dir_path . $lang['code'] . '.json';
            if (!file_exists($file)) {
                $file = $path;
            }

            $t = $this->getFileContent($file);
            if(!isset($t[$id]['text'])) {
                $position = strpos($id, '.');
                $module_id = substr($id, $position + 1);
                $t[$id]['text'] = $t[$module_id]['text'];
            }
            $data[$lang['code']] = $t[$id]['text'];
        }
        $this->template->assign('allowed_languages', $languages);
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
        $data = $this->request->post('data');
        if(empty($id)) return 'Wrong id';
        if(!file_exists($this->theme_path)) {
            if(!mkdir($this->theme_path,0777,true)){
                return "Cannot create language folder for theme";
            }
        }
        $languages = $this->languages->languages->get();

        foreach ($languages as $lang) {
            $theme_file = $this->theme_path. '/' . $lang['code'] . '.json';
            $modules = $this->getModules($this->default_code);
            $themes = $this->getFileContent($theme_file);
            $translation = array_merge($modules,$themes);
            $translation[$id]['text'] = $data[$lang['code']];
            if(is_bool(file_put_contents($theme_file, $this->transformArray($translation)))) {
                return "We have a problem with creating file localization";
            }
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

}