<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */

namespace models\engine\plugins;

use models\engine\Content;
use models\engine\ContentRelationship;

defined("CPATH") or die();

/**
 * Class ProductsCategories
 * @package models\engine\plugins
 */
class ProductsCategories extends Content
{
    private $rs;

    public function __construct()
    {
        parent::__construct('productsCategories');
        $this->rs = new ContentRelationship();
    }

    public function getItems($parent_id)
    {
        $parent_id = (int) $parent_id;

        return self::$db->select("
          select c.id, c.isfolder, c.status, ci.name as text, ci.name
          from __content c
          join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id={$parent_id} and c.status in ('published', 'hidden')
          ")->all();
    }

    /**
     * @param $products_id
     */
    public function save($products_id)
    {
        $main_categories_id = $this->request->post('main_categories_id', 'i');
        if($main_categories_id > 0) {
            $this->rs->clearMainCategory($products_id);
            $this->rs->create($products_id, $main_categories_id, 1);
        }

        $categories = $this->request->post('categories');
        $selected = $this->rs->getCategories($products_id);

        if(!empty($categories)){

            foreach ($categories as $k=>$categories_id) {

                $c = array_search($categories_id, $selected);

                if($c !== FALSE){
                    unset($selected[$c]);
                    continue;
                }

                $this->rs->create($products_id, $categories_id);
            }
        }

        if(!empty($selected)){
            foreach ($selected as $k=>$categories_id) {
                $this->rs->delete($products_id, $categories_id);
            }
        }
    }
}