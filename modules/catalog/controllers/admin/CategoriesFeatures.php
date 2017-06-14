<?php

namespace modules\catalog\controllers\admin;

use system\Backend;

use system\models\FeaturesContent;

class CategoriesFeatures extends Backend
{
    private $features;
    private $featuresContent;
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');
        
        $this->features = new \modules\catalog\models\backend\CategoriesFeatures();
        $this->featuresContent = new FeaturesContent();
    }

    public function init()
    {
        events()->add('content.params.after', [$this, 'index']);
    }

    public function index($content = null)
    {
        if( !isset($content['type']) || $content['type'] != $this->config->type->category) return null;
        
        $this->template->assign('features', $this->features->get(0, $content['id'], true));
        return $this->template->fetch('modules/catalog/categories/features/index');
    }

    /**
     * @param $content_id
     * @return array|string
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

            return ['s' => ! $this->featuresContent->hasError()];
        }

        $this->template->assign('content_id', $content_id);
        $this->template->assign('features', $this->features->get(0, $content_id));
        return $this->template->fetch('modules/catalog/categories/features/select');
    }

    public function getSelected($content_id)
    {
        $this->template->assign('features', $this->features->get(0, $content_id, true));
        return $this->template->fetch('modules/catalog/categories/features/selected');
    }

    public function reorder()
    {
        $o = $this->request->post('o');
        $this->featuresContent->reorder($o);

        return ['s' => ! $this->featuresContent->hasError()];
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

            return ['s' => ! $this->featuresContent->hasError()];
        }

        $parent_id = $this->request->post('parent_id', 'i');

        $this->template->assign('action', 'create');
        $this->template->assign('content_id', $content_id);
        $this->template->assign('types', $this->features->getTypes());
        $this->template->assign('data', ['parent_id' => $parent_id]);
        return $this->template->fetch('modules/catalog/categories/features/create');
    }


    public function delete($id)
    {
        return $this->featuresContent->delete($id);
    }

    public function drop($id)
    {
        return $this->features->delete($id);
    }

    public function edit($id = null)
    {
        if($this->request->post('action') == 'edit'){
            $id = $this->request->post('id', 'i');
            $this->features->update($id);
            return ['s' => ! $this->featuresContent->hasError()];
        }

        $id = $this->request->post('id', 'i');
        $this->template->assign('types', $this->features->getTypes());
        $this->template->assign('data', $this->features->getData($id));
        $this->template->assign('action', 'edit');

        return $this->template->fetch('modules/catalog/categories/features/create');
    }

    public function process($id){}
}