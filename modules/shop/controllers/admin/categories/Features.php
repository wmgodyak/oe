<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 10:17
 */

namespace modules\shop\controllers\admin\categories;

use system\Engine;
use system\models\FeaturesContent;

defined("CPATH") or die();

class Features extends Engine
{
    private $features;
    private $featuresContent;

    public function __construct()
    {
        parent::__construct();

        $this->features = new \modules\shop\models\admin\categories\Features();
        $this->featuresContent = new FeaturesContent();
    }

    public function index($content = null)
    {
        $this->template->assign('features', $this->features->get(0, $content['id'], true));
        return $this->template->fetch('shop/categories/features/index');
    }

    /**
     * @param $content_id
     * @return null|void
     */
    public function select($content_id)
    {
        if($this->request->post('action') == 'create'){
            $cdata = $this->features->getContentData($content_id);
            $items = $this->request->post('categories_features');
            $selected = $this->features->getSelectedFeatures($content_id);
            foreach ($items as $k => $features_id) {

                if(isset($selected[$features_id])){
                    unset($selected[$features_id]);
                    continue;
                }

                $this->featuresContent->create
                (
                  [
                      'features_id'         => $features_id,
                      'content_types_id'    => $cdata['types_id'],
                      'content_subtypes_id' => $cdata['subtypes_id'],
                      'content_id'          => $content_id
                  ]
                );
            }

            if(!empty($selected)){
                $this->features->deleteSelectedFeatures($content_id, $selected);
            }

            $this->response->body(['s' => ! $this->featuresContent->hasError()])->asJSON();

            return null;
        }

        $this->template->assign('content_id', $content_id);
        $this->template->assign('features', $this->features->get(0, $content_id));
        $this->response->body($this->template->fetch('shop/categories/features/select'));

        return;
    }

    public function getSelected($content_id)
    {
        $this->template->assign('features', $this->features->get(0, $content_id, true));
        echo $this->template->fetch('shop/categories/features/selected');
    }

    public function reorder()
    {
        $o = $this->request->post('o');
        $this->featuresContent->reorder($o);

        $this->response->body(['s' => ! $this->featuresContent->hasError()])->asJSON();
    }

    public function create()
    {
        $content_id = $this->request->post('content_id', 'i');
        if(empty($content_id)){
            die('Empty content ID');
        }

        if($this->request->post('action') == 'create'){
            $data = $this->request->post('data');
            $features_id = $this->features->createBlank($data['parent_id'], $this->admin['id']);
            $this->features->update($features_id);

            if(! $this->features->hasError()){
                $cdata = $this->features->getContentData($content_id);

                $this->featuresContent->create
                (
                    [
                        'features_id'         => $features_id,
                        'content_types_id'    => $cdata['types_id'],
                        'content_subtypes_id' => $cdata['subtypes_id'],
                        'content_id'          => $content_id
                    ]
                );
            }

            $this->response->body(['s' => ! $this->featuresContent->hasError()])->asJSON();
            return null;
        }

        $parent_id = $this->request->post('parent_id', 'i');

        $this->template->assign('content_id', $content_id);
        $this->template->assign('data', ['parent_id' => $parent_id]);
        echo $this->template->fetch('shop/categories/features/create');
    }


    public function delete($id)
    {
        $this->featuresContent->delete($id);
    }

    public function drop($id)
    {
        echo $this->features->delete($id);
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }

}