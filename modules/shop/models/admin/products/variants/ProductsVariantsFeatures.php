<?php

namespace modules\shop\models\admin\products\variants;
/**
 * Class ProductsVariantsFeatures
 * @package modules\shop\models\admin\products\variants
 */
class ProductsVariantsFeatures extends \modules\shop\models\products\variants\ProductsVariantsFeatures
{
    /**
     * @param $variants_id
     * @param $features_id
     * @param $values_id
     * @return bool|string
     */
    public function create($variants_id, $features_id, $values_id)
    {
        return $this->createRow
        (
            '__products_variants_features',
            [
                'variants_id' => $variants_id,
                'features_id' => $features_id,
                'values_id'   => $values_id
            ]
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
              from __products_variants_features v
               join __features_info fi on fi.features_id=v.features_id and fi.languages_id={$this->languages_id}
               join __features_info vi on vi.features_id=v.values_id and vi.languages_id={$this->languages_id}
              where v.variants_id={$variants_id}
              ")
            ->all();
    }
}