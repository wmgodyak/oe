<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.06.16 : 16:53
 */

namespace system\components\features\controllers;

use system\Backend;

defined("CPATH") or die();

class Content extends Backend
{
    private $features;

    private $featuresContent;
    public function __construct()
    {
        parent::__construct();

        $this->features = new \system\components\features\models\Features();
        $this->featuresContent = new \system\components\features\models\FeaturesContent();
    }

    public function index($features_id = 0)
    {
        if($this->request->post('action') == 'process'){
            $s = $this->featuresContent->selectContent($features_id); $sc = null;
            if(! $s){
                echo $this->features->getErrorMessage();
            } else {
                $sc = $this->featuresContent->getSelectedContent($features_id);
            }

            return ['s' => $s, 'sc' => $sc];
        }

        $this->template->assign('types', $this->featuresContent->getContentTypes(0));
        $this->template->assign('action', 'process');
        $this->template->assign('features_id', $features_id);
        $this->template->display('system/features/sel_content_types');
    }

    public function getTypes($parent_id)
    {
        return ['o' => $this->featuresContent->getContentTypes($parent_id)];
    }

    public function getContent($types_id, $subtypes_id = 0)
    {
        if($subtypes_id == 0) $subtypes_id = $types_id;

        return ['o' => $this->featuresContent->getContent($types_id, $subtypes_id)];
    }

    public function delete($id)
    {
        $s = $this->featuresContent->delete($id);
        if(! $s){
            echo $this->features->getErrorMessage();
        }

        return ['s' => $s];
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
    public function create()
    {
        // TODO: Implement create() method.
    }

}