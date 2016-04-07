<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 06.04.16 : 16:40
 */

namespace models\engine\plugins;

use models\core\Model;

defined("CPATH") or die();

class ProductsVariantsFeatures extends Model
{
    /**
     * @param $variants_id
     * @param $features_id
     * @param $values_id
     * @return bool|string
     */
    public function create($variants_id, $features_id, $values_id)
    {
        return self::$db->insert
        (
            'products_variants_features',
            ['variants_id' => $variants_id, 'features_id' => $features_id, 'values_id'=> $values_id]
        );
    }

    /**
     * @param $variants_id
     * @return mixed
     */
    public function get($variants_id)
    {
        return self::$db
            ->select("
              select v.features_id, v.values_id, fi.name as features_name, vi.name as values_name
              from products_variants_features v
               join features_info fi on fi.features_id=v.features_id and fi.languages_id={$this->languages_id}
               join features_info vi on vi.features_id=v.values_id and vi.languages_id={$this->languages_id}
              where v.variants_id={$variants_id}
              ")
            ->all();
    }
}