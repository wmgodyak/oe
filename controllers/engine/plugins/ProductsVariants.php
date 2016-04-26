<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;
use models\components\Guides;
use models\engine\ContentFeatures;
use models\engine\ContentRelationship;
use models\engine\Currency;
use models\engine\CustomersGroup;

defined("CPATH") or die();

/**
 * Class ProductsVariants
 * @name Варіанти товару
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class ProductsVariants extends Plugin
{
    private $variants;
    private $contentFeatures;
    private $customersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index'];
        $this->variants         = new \models\engine\plugins\ProductsVariants();
        $this->contentFeatures  = new ContentFeatures();
        $this->customersGroup   = new CustomersGroup();
    }

    public function index(){}


    public function create($id=0)
    {
        $this->template->assign('variants', $this->get($id));
        return $this->template->fetch('plugins/shop/products_variants/index');
    }

    public function edit($id)
    {
        $this->template->assign('variants', $this->get($id));
        return $this->template->fetch('plugins/shop/products_variants/index');
    }

    public function delete($id){}

    public function process($id)
    {
        $this->variants->update($id);
    }

    public function get($content_id)
    {
        if(empty($content_id)) return '';
        $this->template->assign('customers_group', $this->customersGroup->get());
        $this->template->assign('variants', $this->variants->get($content_id));
        return $this->template->fetch('plugins/shop/products_variants/items');
    }

    public function add($content_id)
    {
        if($this->request->isPost() && $this->request->post('action')){
            $s= $this->variants->create($content_id);
            $this->response->body(['s'=>$s])->asJSON();
        }

        $category_id = $this->variants->getMainCategory($content_id);
        if(empty($category_id)){
            return "Помилка. Ви не вибрали основну категорію. Виберіть основну категорію і натисніть зберегти. ";
        }
        $features = $this->contentFeatures->getByCategoryId($category_id, $content_id);
        $this->template->assign('features', $features);
        $this->template->assign('content_id', $content_id);
        $this->response->body($this->template->fetch('plugins/shop/products_variants/add'));
    }

    public function del($variant_id)
    {
        echo $this->variants->delete($variant_id);die;
    }

    public function uploadImage()
    {
        $s = $this->variants->uploadImage();
        $this->response->body($s)->asJSON();
    }
}