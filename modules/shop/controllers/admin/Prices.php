<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:23
 */


namespace modules\shop\controllers\admin;

use system\Engine;

defined("CPATH") or die();

class Prices extends Engine
{
    private $prices;

    public function __construct()
    {
        parent::__construct();

        $this->prices = new \models\engine\plugins\ProductsPrices();
    }

    public function index(){}


    public function create()
    {
        $this->template->assign('groups', $this->prices->getUsersGroup(0));
        $this->template->assign('units',  Guides::getByCode('units'));
        $this->template->assign('currency',  Currency::get());
        return $this->template->fetch('plugins/shop/products_prices');
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->prices->getUsersGroup(0));
        $this->template->assign('units',  Guides::getByCode('units'));
        $this->template->assign('currency',  Currency::get());
        $this->template->assign('group_prices', $this->prices->get($id));
        $this->template->assign('content', $this->prices->getContentData($id));
        return $this->template->fetch('plugins/shop/products_prices');
    }

    public function delete($id){}

    public function process($id)
    {
        $prices = $this->request->post('prices');
        if(!$prices) return;

        foreach ($prices as $group_id => $price) {
            $this->prices->update($id, $group_id, $price);
        }
    }
}