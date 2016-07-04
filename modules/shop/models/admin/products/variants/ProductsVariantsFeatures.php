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
}