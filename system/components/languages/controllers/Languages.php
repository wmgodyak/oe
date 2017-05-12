<?php

namespace system\components\languages\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\core\Lang;
use system\Backend;
use system\models\Settings;

defined("CPATH") or die();

class Languages extends Backend
{
    public function init()
    {
        $this->assignToNav(t('languages.action_index'), 'languages', 'fa-lang', 'settings', 100);
    }

    public function index()
    {
        $this->appendToPanel((string)Button::create(t('common.button_create'), ['class' => 'btn-md btn-primary b-languages-create']));

        $t = new DataTables2('languages');

        $t
            -> th(t('common.id'), 'id')
            -> th(t('languages.name'), 'name', true, true)
            -> th(t('languages.code'), 'code', true, true)
            -> th(t('languages.is_main'), 'is_main')
            -> th(t('common.tbl_func'), null, false, false, 'width:200px');
//        ;

        $t-> ajax('languages/index');


        if($this->request->isXhr()){

            $t  -> from('__languages')
                -> get('id,name,code,is_main')
                -> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['code'];
                $res[$i][] = ($row['is_main'] == 1 ? "<label class='label'>ТАК</label>" : "");
                $res[$i][] =
                    ($row['is_main'] == 0 ? EventsHandler::getInstance()->call('system.languages.list.actions', $row, false) : "") .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-languages-edit  btn-primary', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                    ) .
                    ($row['is_main'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-languages-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                    ) : "")
                  ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('allowed', t()->getAllowedLanguages());
        $this->template->display('system/languages/edit');
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->languages->getData($id));
        $this->template->assign('allowed', t()->getAllowedLanguages());
        $this->template->assign('action', 'edit');
        $this->template->display('system/languages/edit');
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[];

        FormValidation::setRule(['name', 'code'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->languages->create($data);
                    if($s){
                        $this->copyTranslations($data['code']);
                    }
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->languages->update($id, $data);
                    }
                    break;
            }
        }

        return ['s'=>$s, 'i' => $i];
    }

    private function copyTranslations($code)
    {
        $def = $this->languages->getDefault('code');
        // copy theme file
        $theme_path = Settings::getInstance()->get('themes_path');
        $current = Settings::getInstance()->get('app_theme_current');

        $file = DOCROOT . $theme_path . $current . "/lang/{$def}.json";
        $dest = DOCROOT . $theme_path . $current . "/lang/{$code}.json";

        if( !file_exists($file) || file_exists($dest)) return false;
        $s = @copy($file, $dest);

        if( !$s) return false;

        foreach ($this->modules as $module => $instance) {
            $file = DOCROOT . "modules/{$module}/lang/{$def}.json";
            $dest = DOCROOT . "modules/{$module}/lang/{$code}.json";
            if( !file_exists($file) || file_exists($dest)) continue;
            $s = @copy($file, $dest);
        }

        if( !$s) return false;

        return true;
    }

    private function rmTranslations($code)
    {
        // copy theme file
        $theme_path = Settings::getInstance()->get('themes_path');
        $current = Settings::getInstance()->get('app_theme_current');

        $dest = DOCROOT . $theme_path . $current . "/lang/{$code}.json";

        $s = @unlink($dest);

        if( !$s) return false;

        foreach ($this->modules as $module => $instance) {
            $dest = DOCROOT . "modules/{$module}/lang/{$code}.json";
            if( !file_exists($dest)) continue;
            $s = @unlink($dest);
        }

        if( !$s) return false;

        return true;
    }

    public function delete($id)
    {
        $code = $this->languages->getData($id, 'code');
        $this->rmTranslations($code);
        return $this->languages->delete($id);
    }
}