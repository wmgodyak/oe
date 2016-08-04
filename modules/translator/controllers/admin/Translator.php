<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.08.16 : 13:17
 */

namespace modules\translator\controllers\admin;
use system\core\EventsHandler;
use system\Engine;
use system\models\Languages;

defined("CPATH") or die();

/**
 * Class Translator
 * @package modules\translator\controllers\admin
 */
class Translator extends Engine
{
    private $translator;

    public function __construct()
    {
        parent::__construct();
        $this->translator = new \modules\translator\models\Translator();
    }

    public function init()
    {
        EventsHandler::getInstance()->add('content.main.languages.switcher', [$this, 'button']);
        EventsHandler::getInstance()->add('system.languages.list.actions', [$this, 'autoTranslateButton']);
        $this->template->assignScript('modules/translator/js/admin/translator.js');
    }

    public function button($mainLang)
    {
        echo '<button type="button translator-content-translate" onclick="engine.translator.translateContent(\''. $mainLang['code'] .'\'); return false;" class="btn" title="Auto translate content"><i class="fa fa-globe"></i></button>';
    }

    public function autoTranslateButton($language)
    {
        return '<button type="button" class="btn auto-translate-language" data-id="'. $language['id'] .'" title="Auto translate content"><i class="fa fa-globe"></i></button>';
    }

    public function translate($text, $from, $to, $isHtml= true)
    {
        $config = isset($this->settings['modules']['Translator']['config']) ? $this->settings['modules']['Translator']['config'] : null;

        $ns = 'modules\translator\models\\';
        $translator=$this->settings['translator'];

        if(empty($translator)){
            die('Select translator on settings');
        }

        $path = str_replace('\\', '/', $ns);

        if(!file_exists($path . ucfirst($translator) . '.php')){
            die('Translator not found');
        }

        $key = $config[$translator . '_api_key'];
        $c = $ns . ucfirst($translator);

        $t = new $c($key);

        if( !is_callable([$t, 'translate'])){
            die('Action translate not supported on selected adapter');
        }

        $out = $t->translate($text, $from, $to, $isHtml);

        return $out;
    }

    public function ajaxTranslate()
    {
        $text = $this->request->post('text');
        $from = $this->request->post('from', 's');
        $to   = $this->request->post('to', 's');

        echo $this->translate($text, $from, $to);
    }

    public function index($id = null)
    {
        $this->template->assign('id', $id);
        $this->template->assign('tables', $this->translator->getInfoTables());
        echo $this->template->fetch('translator/index');
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

    public function process($languages_id)
    {
        $tables = $this->request->post('table');
        if( ! $tables) return;

        $res= array();

        $def_lang_id = $this->languages_id;

        if($languages_id == $def_lang_id) die;

        foreach ($tables as $table) {
            $col = array();
            $tbl_info = $this->translator->describe($table);
            // формую масив полів
            foreach ($tbl_info as $row) {
                $iv = array();
                $iv['translate'] = 0;
                if($row['Extra'] == 'auto_increment') continue;
                $table_fields[$table]['iv'][] = $row['Field'];

                if(preg_match('/varchar|text|longtext/i',$row['Type'])){
                    $table_fields[$table]['to_tranlate'][] = $row['Field'];
                    $iv['translate'] = 1;
                }
                $iv['field'] = $row['Field'];
                $col[] = $iv;
            }

            $total = $this->translator->getTotalTableRecords($table, $def_lang_id);
            $res[] = array(
                'start' => 0,
                'total' => $total,
                'table' => $table,
                'col'   => $col,
                'from_lang' => $def_lang_id,
                'to_lang'   => $languages_id
            );
        }

        echo json_encode(array('t' => $res));die;
    }

    public function translateContent()
    {
        $l = new Languages();

        $table = $_POST['table'];
        $start = (int) $_POST['start'];
        $total = (int) $_POST['total'];
        $col = $_POST['col'];
        $from_lang = (int) $_POST['from_lang'];
        $to_lang   = (int) $_POST['to_lang'];

        $from = $l->getData($from_lang, 'code');
        $to   = $l->getData($to_lang, 'code');

        $iv = array();

        $rowInfo = $this->translator->getTableRow($table, $from_lang, $start);

        foreach ($col as $field) {
            $value = $rowInfo[$field['field']];

            if($field['field'] == 'languages_id') {
                $value = $to_lang;
                $field['translate'] = 0;
            }

            if($field['field'] == 'url') {
                $field['translate'] = 0;
            }

            if($field['translate'] == 1) {
                $value = $this->translate($value, $from, $to);
            }

            $iv[$field['field']] = $value;
        }

        $this->translator->insertTranslatedData($table, $iv);

        $start++;

        echo json_encode(
            array(
                'table' => $table,
                'start' => $start,
                'total' => $total,
                'col'   => $col,
                'from_lang' => $from_lang,
                'to_lang'   => $to_lang
            )
        );die;
    }
}