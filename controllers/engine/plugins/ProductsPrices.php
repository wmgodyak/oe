<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;
use models\components\Guides;
use models\engine\ContentRelationship;
use models\engine\Currency;

defined("CPATH") or die();

/**
 * Class ProductsPrices
 * @name Ціни товару
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class ProductsPrices extends Plugin
{
    private $prices;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index'];
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