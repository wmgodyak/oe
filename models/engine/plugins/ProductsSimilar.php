<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */

namespace models\engine\plugins;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class ProductsSimilar
 * @package models\engine\plugins
 */
class ProductsSimilar extends Model
{
   public function getFeatures($parent_id=0)
   {
       return self::$db
           ->select("
                select f.id, fi.name, f.type
                from __features f
                join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
                where f.parent_id={$parent_id} and f.status='published'
                order by f.id asc
                ")
           ->all();
   }

    public function getSelected($products_id)
    {
        return self::$db
            ->select("select features_id from __products_similar where products_id={$products_id}")
            ->all('features_id');
    }

    /**
     * @param $products_id
     */
    public function save($products_id)
    {

        $similar = $this->request->post('similar_products');
        $selected = $this->getSelected($products_id);

        if(!empty($similar)){

            foreach ($similar as $k=>$features_id) {

                $c = array_search($features_id, $selected);

                if($c !== FALSE){
                    unset($selected[$c]);
                    continue;
                }

                $this->create($products_id, $features_id);
            }
        }

        if(!empty($selected)){
            foreach ($selected as $k=>$features_id) {
                $this->delete($products_id, $features_id);
            }
        }

    }
    public function create($products_id, $features_id)
    {
        return $this->createRow('products_similar', ['products_id' => $products_id, 'features_id' => $features_id]);
    }

    public function delete($products_id, $features_id)
    {
        return self::$db->delete('products_similar', "products_id={$products_id} and features_id={$features_id} limit 1");
    }
}