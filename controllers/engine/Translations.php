<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class Translations
 * @name Переклади
 * @icon fa-globe
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Translations extends Engine
{
    private $translations;

    public function __construct()
    {
        parent::__construct();
        $this->translations = new \models\engine\Translations();
    }

    public function index()
    {
        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-translations-create']));

        $t = new DataTables();

        $t  -> setId('translations')
            -> ajaxConfig('translations/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('translations.code'))
            -> th($this->t('translations.name'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('translations t')
            -> get('t.id,ti.value, t.code')
            -> join("translations_info ti on ti.translations_id=t.id and ti.languages_id={$this->languages_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<input onfocus='select();' style='width: 300px;' class='form-control' value='{$row['code']}'>";
            $res[$i][] = $row['value'];
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-translations-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-translations-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )

            ;
        }

        return $t->renderJSON($res, $t->getTotal());

//        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('translations/edit'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->translations->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('translations/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $translations = $this->request->post('translations');
        $translations_info = $this->request->post('translations_info');
        $s=0; $i=[];

        FormValidation::setRule(['code'], FormValidation::REQUIRED);

        FormValidation::run($translations);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->translations->is($translations['code'])){
            $i[] = ["translations[code]" => $this->t('translations.code_isset')];
        } else {
            foreach ($translations_info as $languages_id=> $item) {
                if(empty($item['value'])){
                    $i[] = ["translations_info[$languages_id][value]" => $this->t('translations.empty_value')];
                }
            }
            if(empty($i)){
                switch($this->request->post('action')){
                    case 'create':
                        $s = $this->translations->create();
                        break;
                    case 'edit':
                        if( $id > 0 ){
                            $s = $this->translations->update($id);
                        }
                        break;
                }
                if(! $s){
                    echo $this->translations->getDBErrorMessage();
                }
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->translations->delete($id);
    }

}