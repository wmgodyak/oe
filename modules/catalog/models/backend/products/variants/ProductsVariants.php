<?php
namespace modules\catalog\models\backend\products\variants;
/**
 * Class ProductsVariants
 * @package modules\catalog\models\backend\products\variants
 */
class ProductsVariants extends \modules\catalog\models\products\variants\ProductsVariants
{
    /**
     * @param $content_id
     * @return bool|string
     */
    public function create($content_id)
    {
        $r = self::$db->select("select sku, in_stock from __products where content_id = $content_id limit 1")->row();
        $c = self::$db->select("select count(*) as t from __products_variants where content_id = {$content_id}")->row('t');

        $c++;

        $sku = "{$r['sku']}-$c";

        return $this->createRow('__products_variants', ['content_id' => $content_id, 'in_stock' => $r['in_stock'], 'sku' => $sku]);
    }
}