<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.08.16 : 14:59
 */

namespace modules\shop\controllers\admin\products;

use system\Engine;

defined("CPATH") or die();

/**
 * Class Kits
 * @package modules\shop\controllers\admin\products
 */
class Kits extends Engine
{
    private $kits;
    public function __construct()
    {
        parent::__construct();

        $this->kits = new \modules\shop\models\products\Kits();
    }

    public function init()
    {
        parent::init();
    }

    public function index()
    {
        return $this->template->fetch('shop/products/kits/index');
    }

    public function create($products_id = null)
    {
        if(! $products_id) die;

        if($this->request->post('action')){
            $this->response->body(['s' => $this->kits->create(), 'items' => $this->kits->get($products_id)])->asJSON();
            return;
        }

        $this->template->assign('products_id', $products_id);

        $this->response->body($this->template->fetch('shop/products/kits/create'));
    }

    public function get($products_id)
    {
        $this->response->body(['items' => $this->kits->get($products_id)])->asJSON();
    }

    public function edit($id)
    {
        $this->response->body($this->template->fetch('shop/products/kits/edit'));
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
}