<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:23
 */


namespace modules\catalog\controllers\admin;

use modules\currency\models\Currency;
use system\Backend;
use system\models\Guides;
use system\models\UsersGroup;

defined("CPATH") or die();

/**
 * Class ProductsPrices
 * @package modules\catalog\controllers\admin
 */
class ProductsPrices extends Backend
{
    private $prices;
    private $currency;
    private $guides;
    private $usersGroup;
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $this->usersGroup = new UsersGroup();
        $this->guides     = new Guides();
        $this->currency   = new Currency();
        $this->prices = new \modules\catalog\models\backend\ProductsPrices();
    }

    public function init()
    {
        events()->add('content.params.after', [$this, 'index']);
        events()->add('content.process', [$this, 'process']);

        filter_add('catalog.admin.products.table.th', [$this, 'assignToProductsList']);
        filter_add('catalog.admin.products.table.xhr.res',  [$this, 'assignToProductsListXhr']);
    }

    public function assignToProductsList($th)
    {
        $created = array_pop($th);
        $func = array_pop($th);
        foreach ($this->usersGroup->getItems(0, 0) as $group) {
            $th[] = [$group['name'], null,null, null];
        }

        $th[] = $func;
        $th[] = $created;

        return $th;
    }

    public function assignToProductsListXhr($res)
    {
        $groups = $this->usersGroup->getItems(0, 0);

        $my = [];

        foreach ($res as $k=>$row) {

            $_row = $row;

            $created = array_pop($_row);
            $func = array_pop($_row);

            foreach ($groups as $group) {
                $price = $this->prices->getByGroupId($row[0], $group['id']);
                $_row[] = $price;
            }

            $_row[] = $func;
            $_row[] = $created;

            $my[] = $_row;
        }

        return $my;
    }

    public function index($content = null)
    {
        if($content['type'] != $this->config->type->product) return null;

        $this->template->assign('groups', $this->usersGroup->getItems(0, 0));
        $this->template->assign('units',  $this->guides->get($this->config->units_guides_key));
        $this->template->assign('currency', $this->currency->get());
        $this->template->assign('prices', $this->prices->get($content['id']));

        return $this->template->fetch('modules/catalog/products/prices');
    }

    public function process($id)
    {
        $prices = $this->request->post('prices');
        if(!$prices) return;

        foreach ($prices as $group_id => $price) {
            $this->prices->update($id, $group_id, $price);
        }
    }

    public function create(){}
    public function edit($id){}
    public function delete($id){}

}