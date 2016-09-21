<?php
namespace modules\shop\controllers\admin\products;

use modules\shop\models\admin\products\ContentFeatures;
use system\Engine;
use system\models\ContentRelationship;
use system\models\FeaturesContent;

/**
 * Class Features
 * @package modules\shop\controllers\admin\products
 */
class Features extends Engine
{
    private $features;
    private $featuresContent;
    private $contentRelations;
    private $contentFeatures;


    public function __construct()
    {
        parent::__construct();

        $this->features         = new \modules\shop\models\admin\products\Features();

        $this->featuresContent  = new FeaturesContent();
        $this->contentRelations = new ContentRelationship();
        $this->contentFeatures  = new ContentFeatures();
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
            $this->response->body($this->template->fetch('modules/shop/products/features/selected'));
            return null;
        }

        return $this->template->fetch('modules/shop/products/features/index');
    }

    /**
     * @param $features_id
     * @param $products_id
     */
    public function addValue($features_id, $products_id)
    {
        if($this->request->isPost()){
            $s = $this->features->createValue($this->admin['id']);
            $v = null;
            if($s){
                $v = $this->features->getValues($features_id, $products_id);
            }
            $this->response->body(['s' => $s, 'v' => $v])->asJSON();
            return ;
        }

        $this->template->assign('features_id', $features_id);
        $this->template->assign('products_id', $products_id);
        $this->response->body($this->template->fetch('modules/shop/products/features/addValue'));
    }

    public function contentProcess($id)
    {
        $products_features = $this->request->post('products_features');
        if($products_features){
            $this->contentFeatures->save($id, $products_features);
        }
    }

    /**
     * @param $content_id
     * @return null|void
     */
    public function select($content_id)
    {
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

            $this->response->body(['s' => ! $this->featuresContent->hasError()])->asJSON();

            return null;
        }

        $this->template->assign('content_id', $content_id);
        $this->template->assign('features', $this->features->getAll($content_id));
        $this->response->body($this->template->fetch('modules/shop/categories/features/select'));

        return;
    }

    public function getSelected($categories_id, $content_id)
    {
        $this->template->assign('features', $this->features->get($categories_id, $content_id));
        echo $this->template->fetch('modules/shop/products/features/selected');
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
        echo $this->template->fetch('modules/shop/categories/features/create');
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
        // TODO: Implement process() method.
    }

}