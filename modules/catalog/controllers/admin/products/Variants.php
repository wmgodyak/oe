<?php

namespace modules\catalog\controllers\admin\products;

use modules\catalog\models\ProductFeatures;
use system\Backend;
use system\models\ContentRelationship;
use system\models\UsersGroup;

/**
 * Class Variants
 * @package modules\catalog\controllers\backend\products
 */
class Variants extends Backend
{
    private $variants;

    private $customersGroup;
    private $contentRelations;

    public function __construct()
    {
        parent::__construct();

        $this->variants = new \modules\catalog\models\backend\products\Variants();
        $this->customersGroup = new UsersGroup();
        $this->contentRelations = new ContentRelationship();
    }

    public function init()
    {
        events()->add('content.main.after', [$this, 'index']);
        events()->add('content.process', [$this, 'process']);
    }

    public function index($content = null)
    {
        $this->template->assign('customers_group', $this->customersGroup->getItems(0));
        $this->template->assign('variants', $this->variants->get($content['id']));
        return $this->template->fetch('modules/catalog/products/variants/index');
    }

    public function create($products_id = 0)
    {
        if($this->request->isPost() && $this->request->post('action')){
            $this->variants->deleteAll($products_id);
            $s = $this->variants->create($products_id);
            return ['s'=>$s];
        }

        $category_id = $this->contentRelations->getMainCategoriesId($products_id);

        if(empty($category_id)){
            return "Помилка. Ви не вибрали основну категорію. Виберіть основну категорію і натисніть зберегти. ";
        }

        $features = new ProductFeatures($products_id, $category_id, $this->languages);

        $this->template->assign('features', $features->get());
        $this->template->assign('content_id', $products_id);

        return $this->template->fetch('modules/catalog/products/variants/create');
    }

    public function edit($id)
    {

    }

    public function process($id)
    {
        $s = $this->variants->update($id);
//
//        $m = 'Error: ' . $this->variants->getErrorMessage();
//
//        if(!$s){
//            $m = 'Variants generated!';
//        }

//        return ['s' => $s, 'm' => $m];
    }

    public function get($content_id)
    {
        if(empty($content_id)) return '';

        $this->template->assign('customers_group', $this->customersGroup->getItems(0));
        $this->template->assign('variants', $this->variants->get($content_id));

        return $this->template->fetch('modules/catalog/products/variants/items');
    }

    public function delete($variant_id)
    {
        return $this->variants->delete($variant_id);
    }

    public function uploadImage()
    {
        return $this->variants->uploadImage();
    }
}