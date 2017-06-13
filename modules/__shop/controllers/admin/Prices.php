<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:23
 */


namespace modules\shop\controllers\admin;

use modules\currency\models\Currency;
use system\Backend;
use system\models\Guides;
use system\models\UsersGroup;

defined("CPATH") or die();

class Prices extends Backend
{
    private $prices;
    private $currency;
    private $guides;
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->usersGroup = new UsersGroup();
        $this->guides     = new Guides();
        $this->currency   = new Currency();
        $this->prices = new \modules\shop\models\admin\Prices();
    }

    public function index($content = null)
    {
        $this->template->assign('groups', $this->usersGroup->getItems(0, 0));
        $this->template->assign('units',  $this->guides->get('units'));
        $this->template->assign('currency', $this->currency->get());
        $this->template->assign('prices', $this->prices->get($content['id']));
        return $this->template->fetch('modules/shop/products/prices');
    }


    public function create()
    {
    }

    public function edit($id)
    {
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