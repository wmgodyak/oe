<?php
namespace modules\shop\models\admin\products\variants;
/**
 * Class ProductsVariants
 * @package modules\shop\models\admin\products\variants
 */
class ProductsVariants extends \modules\shop\models\products\variants\ProductsVariants
{
    /**
     * @param $content_id
     * @return bool|string
     */
    public function create($content_id)
    {
        return $this->createRow('__products_variants', ['content_id' => $content_id, 'in_stock' => 1]);
    }
}