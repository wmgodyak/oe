<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 20.07.16
 * Time: 22:50
 */

namespace modules\order\controllers\admin;

use system\Engine;

/**
 * Class Products
 * @package modules\order\controllers\admin
 */
class Products extends Engine
{
    public function index()
    {
        // TODO: Implement index() method.
    }
    public function create()
    {
        $orders_id = $this->request->post('orders_id', 'i');
        $products_id = $this->request->post('products_id', 'i');
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}