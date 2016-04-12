<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;

defined("CPATH") or die();

/**
 * Class ProductsAccessories
 * @name ProductsAccessories
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @position
 * @package controllers\engine
 */
class ProductsAccessories extends Plugin
{
    private $accessories;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index','delete'];
        $this->accessories = new \models\engine\plugins\ProductsAccessories();
    }

    public function index(){}

    public function create($id=0)
    {
        return $this->template->fetch('plugins/shop/accessories');
    }

    public function edit($id)
    {
        $this->template->assign('selected_accessories', $this->accessories->get($id));
        return $this->template->fetch('plugins/shop/accessories');
    }

    public function delete($id){}

    public function process($id){}

    public function search()
    {
        $q = $this->request->get('q');
        $pid = $this->request->get('pid','i');
        if(empty($q)) {
            $this->response->body([])->asJSON();
        }
        $res = $this->accessories->search($q, $pid);
        echo $this->accessories->getDBErrorMessage();
        $this->response->body(['items' => $res])->asJSON();
    }

    public function add($products_id, $accessories_id)
    {
        $s = $this->accessories->add($products_id, $accessories_id);
        echo $s;die;
    }

    public function get($products_id)
    {
        $this->response->body(['items' => $this->accessories->get($products_id)])->asJSON();
    }

    public function del()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) return 0;

        echo $this->accessories->delete($id);die;
    }
}
