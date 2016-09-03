<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\shop\controllers;

use helpers\Pagination;
use modules\shop\models\Categories;
use modules\shop\models\Products;
use system\Front;
use system\models\Settings;

/**
 * Class shop
 * @package modules\shop\controllers
 */
class Search extends Front
{
    private $products;
    private $ipp;
    private $total;
    private $group_id;
    private $bonus_rate;

    public function __construct($products, $group_id)
    {
        parent::__construct();

        $this->products = $products;
        $this->group_id = Settings::getInstance()->get('modules.Shop.config.group_id');
        $this->ipp      = Settings::getInstance()->get('modules.Shop.config.ipp');
        $this->bonus_rate = Settings::getInstance()->get('modules.Shop.config.bonus_rate');
    }

    public function index(){}

    /**
     * @return bool
     */
    public function results()
    {
        $start = (int) $this->request->get('p', 'i');
        $categories_id = (int) $this->request->get('cat', 'i');

        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * $this->ipp;
        }

        $this->products->categories_id = $categories_id;
        $this->products->start = $start;
        $this->products->num = $this->ipp;

        $products = $this->products->get();
        if($this->products->hasError()){
            return false;
        }

        // save total posts count
        $this->total = $this->products->getTotal();

        return $products;
    }

    public function getError()
    {
        return $this->products->getError();
    }

    public function total()
    {
        return $this->total;
    }

    public function categories()
    {
        return $this->products->filteredCategories();
    }

    /**
     * display pagination
     * @param string $tpl
     * @return string
     */
    public function pagination($tpl = 'modules/pagination')
    {
        $p = $this->request->get('p', 'i');

        $url = $this->page['id'] . ';';

        $filter = $this->request->param('filter');

        if($filter){
            $url .= 'filter/' . $filter;
        }

        Pagination::init($this->total, $this->ipp, $p, $url);

        $this->template->assign('pagination', Pagination::getPages());
        return $this->template->fetch($tpl);
    }
}