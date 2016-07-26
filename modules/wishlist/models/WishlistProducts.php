<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.07.16
 * Time: 10:02
 */

namespace modules\wishlist\models;
use modules\shop\models\Products;
use system\models\Model;

/**
 * Class WishlistProducts
 * @package modules\wishlist\models
 */
class WishlistProducts extends Model
{
    private $products;

    public function __construct()
    {
        parent::__construct();

        $this->products = new Products();
    }

    /**
     * @param $wishlist_id
     * @param $products_id
     * @param $variants_id
     * @return bool|string
     */
    public function create($wishlist_id, $products_id, $variants_id)
    {
        return $this->createRow
        (
            '__wishlist_products',
            ['wishlist_id' => $wishlist_id, 'products_id' => $products_id, 'variants_id' => $variants_id]
        );
    }

    public function get($wishlist_id)
    {

        $this->products->fields('wp.id as wp_products_id');

        $this->products->join("join __wishlist_products wp on wp.wishlist_id='{$wishlist_id}' and wp.products_id=c.id");
        return $this->products->get();
    }

    public function delete($id)
    {
        return $this->deleteRow('__wishlist_products', $id);
    }
}