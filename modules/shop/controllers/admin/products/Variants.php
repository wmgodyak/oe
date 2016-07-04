<?php

namespace modules\shop\controllers\admin\products;

use modules\shop\models\admin\products\ContentFeatures;
use system\Engine;
use system\models\ContentRelationship;
use system\models\UsersGroup;

/**
 * Class Variants
 * @package modules\shop\controllers\admin\products
 */
class Variants extends Engine
{
    private $variants;

    private $contentFeatures;
    private $customersGroup;
    private $contentRelations;

    public function __construct()
    {
        parent::__construct();
        $this->variants = new \modules\shop\models\admin\products\variants\Variants();
        $this->contentFeatures = new ContentFeatures();
        $this->customersGroup = new UsersGroup();
        $this->contentRelations = new ContentRelationship();
    }

    public function index()
    {
        $this->template->assign('customers_group', $this->customersGroup->getItems(0));
        $this->template->assign('variants', []);
        return $this->template->fetch('shop/products/variants/index');
    }

    public function create($products_id = 0)
    {
        if($this->request->isPost() && $this->request->post('action')){
            $s = $this->variants->create($products_id);
            $this->response->body(['s'=>$s])->asJSON();
        }

        $category_id = $this->contentRelations->getMainCategoriesId($products_id);

        if(empty($category_id)){
            return "Помилка. Ви не вибрали основну категорію. Виберіть основну категорію і натисніть зберегти. ";
        }

        $features = $this->contentFeatures->get($category_id);
        $this->template->assign('features', $features);
        $this->template->assign('content_id', $products_id);
        $this->response->body($this->template->fetch('shop/products/variants/create'));
    }

    public function edit($id)
    {
    }

    public function process($id)
    {
        $this->variants->update($id);
    }

    public function get($content_id)
    {
        if(empty($content_id)) return '';
        echo 'OK';die;
        $this->template->assign('customers_group', $this->customersGroup->get());
        $this->template->assign('variants', $this->variants->get($content_id));
        return $this->template->fetch('shop/products/variants/items');
    }

    public function delete($variant_id)
    {
        echo $this->variants->delete($variant_id);die;
    }

    public function uploadImage()
    {
        $s = $this->variants->uploadImage();
        $this->response->body($s)->asJSON();
    }
}