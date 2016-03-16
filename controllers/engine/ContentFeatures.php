<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.03.16 : 11:49
 */


namespace controllers\engine;

use controllers\Engine;
use helpers\FormValidation;

defined("CPATH") or die();

class ContentFeatures extends Engine
{
    private $cf;

    public function __construct()
    {
        parent::__construct();

        $this->cf = new \models\engine\ContentFeatures();
    }

    public function index()
    {
        return 'FirstPlugin::index';
    }

    public function create()
    {
        $content_id = $this->request->post('content_id', 'i');
        $parent_id = $this->request->post('parent_id', 'i');

        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);

        $this->template->assign('types', $this->cf->getFeaturesTypes());
        $this->template->assign('content_id', $content_id);

        $this->response->body($this->template->fetch('contentFeatures/create'));
    }

    public function createValue()
    {
        if($this->request->post('action') == 'create'){
            $data = $this->request->post('data');
            $info = $this->request->post('info');

            $s=0; $i=[]; $m=null;

            FormValidation::setRule(['code'], FormValidation::REQUIRED);

            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {
                foreach ($info as $languages_id=> $item) {
                    if(empty($item['name'])){
                        $i[] = ["info[$languages_id][name]" => $this->t('features.empty_name')];
                    }
                }
                if(empty($i)) {
                    $s = $this->cf->createValue();
                }
            }

            if($this->cf->hasDBError()){
                $m = $this->cf->getDBErrorMessage();
            }

            $v = null;

            if($s > 0){
                reset($info);
                $info  = current($info);
                $v = ['value' => $s, 'name' => $info['name']];
            }


            $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m, 'v' => $v])->asJSON();
        }

        $parent_id = $this->request->post('parent_id', 'i');

        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);

        $this->response->body($this->template->fetch('contentFeatures/create_value'));
    }

    public function edit($id)
    {

    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id=null)
    {

        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $s=0; $i=[]; $m=null;

        FormValidation::setRule(['code'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            foreach ($info as $languages_id=> $item) {
                if(empty($item['name'])){
                    $i[] = ["info[$languages_id][name]" => $this->t('features.empty_name')];
                }
            }
            if(empty($i)) {
                $s = $this->cf->create();
            }
        }

        if($this->cf->hasDBError()){
            $m = $this->cf->getDBErrorMessage();
        }

        $f = null;
        if($s > 0){

            $data['id']      = $s;
            $feature = $data;
            reset($info);
            $info  =current($info);
            $feature['name'] = $info['name'];
            $f = $this->makeFeature($feature);
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m, 'f' => $f])->asJSON();
    }

    private function makeFeature($feature)
    {
        $this->template->assign('feature', $feature);
//        return var_export($feature,1);
        return $this->template->fetch('contentFeatures/feature');
    }

}