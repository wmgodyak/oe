<?php

namespace system\components\contentFeatures\controllers;

use system\Backend;

defined("CPATH") or die();

class ContentFeatures extends Backend
{
    private $cf;

    public function __construct()
    {
        parent::__construct();

        $this->cf = new \system\components\contentFeatures\models\ContentFeatures();
    }

    public function index($categories_id=null, $content_id=null)
    {
        if(! $categories_id || !$content_id) return;

        $features = $this->cf->getByCategoryId($categories_id, $content_id);

//        $this->dump($features);
        $out = '';
        foreach ($features as $feature) {
            $out .= $this->makeFeature($feature);
        }

        echo $out;
    }

    public function create()
    {
        $content_id = $this->request->post('content_id', 'i');
        $parent_id  = $this->request->post('parent_id', 'i');
        $allowed    = $this->request->post('allowed');
        $disable_values  = $this->request->post('disable_values', 'i');

        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);

        $this->template->assign('types', $this->cf->getFeaturesTypes($allowed));
        $this->template->assign('content_id', $content_id);
        $this->template->assign('disable_values', $disable_values);

        $this->template->display('system/contentFeatures/create');
    }

    public function createValue()
    {
        if($this->request->post('action') == 'create'){
//            $data = $this->request->post('data');
            $info = $this->request->post('info');

            $s=0; $i=[]; $m=null;

            /*FormValidation::setRule(['code'], FormValidation::REQUIRED);

            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {*/
            foreach ($info as $languages_id=> $item) {
                if(empty($item['name'])){
                    $i[] = ["info[$languages_id][name]" => t('features.empty_name')];
                }
            }
            if(empty($i)) {
                $s = $this->cf->createValue();
            }
//            }

            if($this->cf->hasError()){
                $m = $this->cf->getErrorMessage();
            }

            $v = null;

            if($s > 0){
                reset($info);
                $info  = current($info);
                $v = ['value' => $s, 'name' => $info['name']];
            }

            return ['s'=>$s, 'i' => $i, 'm' => $m, 'v' => $v];
        }

        $parent_id = $this->request->post('parent_id', 'i');

        $data = ['parent_id' => $parent_id];
        $this->template->assign('data', $data);

        $this->template->display('system/contentFeatures/create_value');
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

        /* FormValidation::setRule(['code'], FormValidation::REQUIRED);

         FormValidation::run($data);

         if(FormValidation::hasErrors()){
             $i = FormValidation::getErrors();
         } else {*/
        foreach ($info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => t('features.empty_name')];
            }
        }
        if(empty($i)) {
            $s = $this->cf->create();
        }
//        }

        if($this->cf->hasError()){
            $m = $this->cf->getErrorMessage();
        }

        $f = null;
        if($s > 0){
            $data['id']      = $s;
            $feature = $data;
            reset($info);
            $info  = current($info);

            $feature['name']    = $info['name'];
            $feature['disable_values'] = $this->request->post('disable_values');

            $f = $this->makeFeature($feature);
        }

        return ['s'=>$s, 'i' => $i, 'm' => $m, 'f' => $f];
    }

    private function makeFeature($feature)
    {
        $this->template->assign('feature', $feature);
        return $this->template->fetch('system/contentFeatures/feature');
    }
}