<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.02.16 : 14:11
 */


namespace controllers\engine;

use controllers\core\exceptions\DbException;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Link;

defined("CPATH") or die();

/**
 * Class Content
 * @package controllers\engine
 */
class Content extends Engine
{
    protected $mContent;
    /**
     * Content Type
     * @var
     */
    protected $type = 'pages';

    protected $form_template = 'content/default';
    protected $form_action   = '';
    protected $form_success  = '';

    public function __construct()
    {
        parent::__construct();

        $this->mContent = new \models\engine\Content($this->type);

        if(empty($this->form_action)){
            $this->form_action = 'content/' . $this->type . '/process/';
        }
    }

    public function index()
    {

    }

    public function create($parent_id=0)
    {
        return $this->mContent->create($parent_id);
    }

    public function edit($id)
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $content = $this->mContent->getData($id);

        if($this->mContent->hasDBError()){
            throw new DbException($this->mContent->getDBErrorMessage());
        }
//        $this->dump($content);die;
        $this->template->assign('content', $content);
        $this->template->assign('subtypes', $this->mContent->getSubtypes($content['types_id']));
        $this->template->assign('form_action', $this->form_action . $id);
        $this->template->assign('form_success', $this->form_success);

        //$content.settings.type.features
        $this->makeFeatures($content['features'], $content['settings']['type']['features']);

        $form = $this->template->fetch($this->form_template);

        $this->output($form);
    }

    private function makeFeatures($features, $settings)
    {
//        $this->dump($settings);die;
        $out = '';
        $disable_values = isset($settings['disable_values']) ? $settings['disable_values'] : 0;
        foreach ($features as $feature) {
            $feature['disable_values'] = $disable_values;
            $this->template->assign('feature', $feature);
            $out .= $this->template->fetch('contentFeatures/feature');
        }

        $this->template->assign('content_features', $out);
    }

    public function delete($id)
    {
        $s = $this->mContent->delete($id);
        $m = $this->mContent->getDBError();

        $this->response->body(['s'=>$s,'m' => $m])->asJSON();
    }

    public function process($id)
    {
        $i=[]; $m = $this->t('common.update_success');
        $s = $this->mContent->update($id);
        if(! $s){
            $i = $this->mContent->getDBError();
            $m = $this->mContent->getDBErrorMessage();
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function pub($id)
    {
        return $this->mContent->pub($id);
    }

    public function hide($id)
    {
        return $this->mContent->hide($id);
    }

}