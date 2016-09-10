<?php
namespace modules\productsSimilar\controllers\admin;

use system\core\EventsHandler;
use system\Engine;
use system\models\ContentFeatures;
use system\models\ContentRelationship;

/**
 * Class ProductsSimilar
 * @package modules\productsSimilar\controllers\admin
 */
class ProductsSimilar extends Engine
{
    private $relations;
    private $contentFeatures;
    private $similar;

    public function __construct()
    {
        parent::__construct();

        $this->similar = new \modules\productsSimilar\models\admin\ProductsSimilar();
        $this->relations = new ContentRelationship();

        $this->contentFeatures = new ContentFeatures();
    }

    public function init()
    {
        parent::init();
        EventsHandler::getInstance()->add('content.params.after', [$this, 'index'], 50);
        $this->template->assignScript('modules/productsSimilar/js/admin/productsSimilar.js');
    }

    public function index($content = null)
    {
        if($content['type'] != 'products_categories') return null;

        return $this->template->fetch('productsSimilar/index');
    }

    public function getFeatures($categories_id)
    {
//        $categories_id = $this->relations->getMainCategoriesId($products_id);
//        if(empty($categories_id)){
//            return "Помилка. Ви не вибрали основну категорію. Виберіть основну категорію і натисніть зберегти. ";
//        }

        $features = $this->contentFeatures->get($categories_id);
        $this->template->assign('selected', $this->similar->getSelectedFeaturesId($categories_id));
        $this->template->assign('features', $features);
        $this->template->assign('categories_id', $categories_id);
        $this->response->body($this->template->fetch('productsSimilar/select'));
    }

    public function getSelected($categories_id)
    {
        $this->response->body(['items' => $this->similar->getFeatures($categories_id)])->asJSON();
    }

    public function create()
    {
        // TODO: Implement create() method.
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function delete($id)
    {
        echo $this->similar->delete($id);
    }

    public function process($id)
    {
        $this->response->body(['s' => $this->similar->update($id)])->asJSON();
    }
}