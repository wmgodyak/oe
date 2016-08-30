<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 09.07.16
 * Time: 19:39
 */
namespace modules\share\controllers;

use system\core\EventsHandler;
use system\Front;

/**
 * Class Share
 * @name Шарінг в соц мережах
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\share\controllers
 */
class Share extends Front
{
    public function index()
    {
        return $this->template->fetch('modules/share');
    }

    public function init()
    {
        EventsHandler::getInstance()->add('shop.product.buy.after', [$this, 'index']);
    }
}