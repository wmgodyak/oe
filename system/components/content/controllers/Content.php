<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 12.06.16
 * Time: 0:51
 */

namespace system\components\content\controllers;

use controllers\core\exceptions\Exception;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\EventsHandler;
use system\Engine;

defined("CPATH") or die();

class Content extends Engine
{
    protected $mContent;
    /**
     * Content Type
     * @var
     */
    protected $type = null;

    protected $form_template = 'content/default';
    protected $form_action   = '';
    protected $form_success  = '';
    protected $data = [];

    protected $form_display_blocks =
        [
            'content'  => true,
            'features' => true,
            'intro'    => true,
            'main'     => true,
            'meta'     => true,
            'params'   => true
        ];

    protected $form_display_params =
        [
            'owner'    => true,
            'parent'   => true,
            'pub_date' => true
        ];

    public function __construct($type)
    {
        parent::__construct();

        $this->type = $type;

        $this->mContent = new \system\models\Content($this->type);

        if(empty($this->form_action)){
            $this->form_action = $this->type . '/process/';
        }
    }

    public function index($parent_id = 0)
    {

    }

    /**
     * @param int $parent_id
     * @return bool|string
     */
    public function create($parent_id=0)
    {
        $controller  = $this->request->param('controller');
        $controller  = lcfirst($controller);

        $this->addBreadCrumb($this->t($controller . '.action_create'));

        return $this->mContent->create($parent_id, $this->admin['id']);
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

        if(empty($content)){
            $this->redirect('dashboard', 404);
        }

        if($this->mContent->hasError()){
            throw new \system\core\exceptions\Exception($this->mContent->getErrorMessage());
        }
//        $this->dump($content);die;
        $this->template->assign('content', $content);
        $this->template->assign('subtypes', $this->mContent->getSubtypes($content['types_id']));
        $this->template->assign('form_action', $this->form_action . $id);
        $this->template->assign('form_success', $this->form_success);
        $this->template->assign('form_display_blocks', $this->form_display_blocks);
        $this->template->assign('form_display_params', $this->form_display_params);

        if(!empty($content['features'])){
            $this->makeFeatures
            (
                $content['features'],
                isset($content['settings']['type']['features']) ? $content['settings']['type']['features'] : null
            );
        }

        $this->data = $content;
        $info = array_shift($this->data['info']);
        if(!empty($info)){
            $this->addBreadCrumb($info['name']);
        }


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
        $m = $this->mContent->getError();
        if($s){
            EventsHandler::getInstance()->call('content.delete', ['id' => $id]);
        }
        $this->response->body(['s'=>$s,'m' => $m])->asJSON();
    }

    public function process($id, $response = true)
    {
        $i=[]; $m = $this->t('common.update_success');

        $s = $this->mContent->update($id);
        if($s){
            EventsHandler::getInstance()->call('content.process', $id);
        }

        if(! $s){
            $i = $this->mContent->getError();
            $m = $this->mContent->getErrorMessage();
        }

        $a = ['s'=>$s, 'i' => $i, 'm' => $m];

        if($response){
            $this->response->body($a)->asJSON();
        }

        return $a;
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