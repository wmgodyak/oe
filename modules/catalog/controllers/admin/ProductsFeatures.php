<?php

namespace modules\catalog\controllers\admin;

use system\Backend;

use system\models\ContentFeatures;
use system\models\ContentRelationship;
use system\models\FeaturesContent;

/**
 * Class ProductsFeatures
 * @package modules\catalog\controllers\admin
 */
class ProductsFeatures extends Backend
{
    private $features;
    private $featuresContent;
    private $contentRelations;
    private $contentFeatures;


    public function __construct()
    {
        parent::__construct();

        $this->features         = new \modules\catalog\models\backend\ProductsFeatures();

        $this->featuresContent  = new FeaturesContent();
        $this->contentRelations = new ContentRelationship();
        $this->contentFeatures  = new ContentFeatures();
    }

    public function init()
    {
        events()->add('content.main.after', [$this, 'index']);
        events()->add('content.process', [$this, 'process']);
    }

    public function index($content = null)
    {
        if(! $content && $this->request->isXhr()){
            $content = [];
            $categories_id = $this->request->post('categories_id', 'i');
            $content['id'] = $this->request->post('products_id', 'i');
        } else {
            $categories_id = $this->contentRelations->getMainCategoriesId($content['id']);
        }

        $this->template->assign('langs', $this->languages->get());
        $this->template->assign('features', $this->features->get($categories_id, $content['id']));

        if($this->request->isXhr()){
            return $this->template->fetch('modules/catalog/products/features/selected');
        }

        return $this->template->fetch('modules/catalog/products/features/index');
    }

    /**
     * @param $features_id
     * @param $products_id
     * @return array|string
     */
    public function addValue($features_id, $products_id)
    {
        if($this->request->isPost()){
            $s = $this->features->createValue($this->admin['id']);
            $v = null;
            if($s){
                $v = $this->features->getValues($features_id, $products_id);
            }

            return ['s' => $s, 'v' => $v];
        }

        $this->template->assign('features_id', $features_id);
        $this->template->assign('products_id', $products_id);

        return $this->template->fetch('modules/catalog/products/features/addValue');
    }

    /**
     * @param $content_id
     * @return array|string
     */
    public function select($content_id)
    {
        if(empty($content_id)) die('Empty contentID');

        if($this->request->post('action') == 'create'){
            $cdata = $this->featuresContent->getContentData($content_id);
            $items = $this->request->post('categories_features');
            $selected = $this->featuresContent->getSelectedFeatures($content_id);

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
                $this->featuresContent->deleteSelectedFeatures($content_id, $selected);
            }

            return ['s' => ! $this->featuresContent->hasError()];
        }

        $this->template->assign('content_id', $content_id);
        $this->template->assign('features', $this->features->getAll($content_id));

        return $this->template->fetch('modules/catalog/categories/features/select');
    }

    /**
     * @param $categories_id
     * @param $content_id
     * @return string
     */
    public function getSelected($categories_id, $content_id)
    {
        $this->template->assign('features', $this->features->get($categories_id, $content_id));
        return $this->template->fetch('modules/catalog/products/features/selected');
    }

    /**
     * @return array
     */
    public function reorder()
    {
        $o = $this->request->post('o');
        $this->featuresContent->reorder($o);

        return ['s' => ! $this->featuresContent->hasError()];
    }

    /**
     * @return array|string
     */
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
                $cdata = $this->featuresContent->getContentData($content_id);

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

        $this->template->assign('content_id', $content_id);
        $this->template->assign('data', ['parent_id' => $parent_id]);
        return $this->template->fetch('modules/catalog/categories/features/create');
    }


    public function delete($id)
    {

    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function process($id)
    {
        $products_features = $this->request->post('products_features');
        if($products_features){
            $this->contentFeatures->save($id, $products_features);
        }
    }
}