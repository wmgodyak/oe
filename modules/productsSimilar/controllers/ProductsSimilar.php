<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 01.09.16
 * Time: 6:59
 */

namespace modules\productsSimilar\controllers;

use system\core\EventsHandler;
use system\Front;

/**
 * Class ProductsSimilar
 * @name Схожі товари
 * @description Спрощені варіанти товару по одному з атрибутів
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\productsSimilar\controllers
 */
class ProductsSimilar extends Front
{
    private $mSimilar;

    public function __construct()
    {
        parent::__construct();

        $this->mSimilar = new \modules\productsSimilar\models\ProductsSimilar();
    }


    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('shop.product.buy.after', [$this, 'similar']);
    }

    public function similar($product)
    {
        $this->template->assign('similar', $this->mSimilar->getProducts($product));
        return $this->template->fetch('modules/productsSimilar/index');
    }
}