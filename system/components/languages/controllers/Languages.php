<?php

namespace system\components\languages\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\core\Lang;
use system\Engine;
use system\models\Settings;

defined("CPATH") or die();

class Languages extends Engine
{
    public function init()
    {
        $this->assignToNav('Мови', 'languages', 'fa-lang', 'settings', 100);
    }

    public function index()
    {

        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-languages-create']));

        $t = new DataTables2('languages');

        $t
            -> th($this->t('common.id'), 'id')
            -> th($this->t('languages.name'), 'name', true, true)
            -> th($this->t('languages.code'), 'code', true, true)
            -> th($this->t('languages.is_main'), 'is_main')
            -> th($this->t('common.tbl_func'), null, false, false, 'width:200px');
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
                    ($row['is_main'] == 0 ? EventsHandler::getInstance()->call('system.languages.list.actions', ['language' => $row], false) : "") .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-languages-edit  btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    ($row['is_main'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-languages-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
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
        $this->template->assign('allowed', Lang::getInstance()->getAllowedLanguages());
        $this->response->body($this->template->fetch('languages/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->languages->getData($id));
        $this->template->assign('allowed', Lang::getInstance()->getAllowedLanguages());
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('languages/edit'))->asHtml();
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

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();

    }

    private function copyTranslations($code)
    {
        $def = $this->languages->getDefault('code');
        // copy theme file
        $theme_path = Settings::getInstance()->get('themes_path');
        $current = Settings::getInstance()->get('app_theme_current');

        $file = DOCROOT . $theme_path . $current . "/lang/{$def}.ini";
        $dest = DOCROOT . $theme_path . $current . "/lang/{$code}.ini";

        if( !file_exists($file) || file_exists($dest)) return false;
        $s = @copy($file, $dest);

        if( !$s) return false;

        foreach ($this->modules as $module => $instance) {
            $file = DOCROOT . "modules/{$module}/lang/{$def}.ini";
            $dest = DOCROOT . "modules/{$module}/lang/{$code}.ini";
            if( !file_exists($file) || file_exists($dest)) continue;
            @copy($file, $dest);
        }
    }

    private function rmTranslations($code)
    {
        // copy theme file
        $theme_path = Settings::getInstance()->get('themes_path');
        $current = Settings::getInstance()->get('app_theme_current');

        $dest = DOCROOT . $theme_path . $current . "/lang/{$code}.ini";

        $s = @unlink($dest);

        if( !$s) return false;

        foreach ($this->modules as $module => $instance) {
            $dest = DOCROOT . "modules/{$module}/lang/{$code}.ini";
            if( !file_exists($dest)) continue;
            $s = @unlink($dest);
        }

        return true;
    }

    public function delete($id)
    {
        $code = $this->languages->getData($id, 'code');
        $this->rmTranslations($code);
        return $this->languages->delete($id);
    }
}