<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 20.07.16
 * Time: 22:50
 */

namespace modules\order\controllers\admin;

use modules\order\models\admin\OrdersProducts;
use modules\shop\models\products\Prices;
use system\Engine;

/**
 * Class Products
 * @package modules\order\controllers\admin
 */
class Products extends Engine
{
    private $products;
    private $prices;
    public function __construct()
    {
        parent::__construct();

        $this->products = new OrdersProducts();
        $this->prices   = new Prices();
    }

    public function index()
    {
        // TODO: Implement index() method.
    }

    public function create()
    {
        $orders_id = $this->request->post('orders_id', 'i');
        $products_id = $this->request->post('products_id', 'i');
        $currency_id = $this->request->post('currency_id', 'i');
        $group_id    = $this->request->post('group_id', 'i');
        $price       = $this->prices->get($products_id, $group_id, $currency_id);
        $this->products->create($orders_id, $products_id, 1, $price, 0);

        echo $this->products->hasError() ? 0 : 1;
    }

    public function search()
    {
        $group_id    = $this->request->post('group_id', 'i');
        $currency_id = $this->request->post('currency_id', 'i');
        $q           = $this->request->post('q', 's');

        $where =[];$items= [];

        if(!empty($q)){
            $q = explode(' ', $q);
            foreach ($q as $k=>$v) {
                $v = trim($v);
                if(empty($v)) continue;

                $where[] = " ((ci.name like '%{$v}%') or (c.id like '{$v}%') or (c.sku like '{$v}%') )";
            }
        }

        if(!empty($where)){
            $items = $this->products->search($where, $group_id, $currency_id);
            foreach ($items as $k=>$item) {
                $items[$k]['text'] = "{$item['sku']} {$item['name']} {$item['price']} {$item['symbol']}";
            }
        }


        $res = array(
            'total_count' => $this->products->searchTotal(),
            'incomplete_results' => false,
            'results' => $items
        );

        echo json_encode($res);
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
        echo $this->products->delete($id);
    }

}