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

    public function index()
    {
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

    public function process($id)
    {
        // TODO: Implement process() method.
    }

    public function translateContent()
    {

    }
}