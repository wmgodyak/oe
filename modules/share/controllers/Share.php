<?php
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
    /**
     * for vk https://vk.com/dev/widget_share
     * @return string
     */
    public function index()
    {
        return $this->template->fetch('modules/share');
    }

    public function init()
    {
        EventsHandler::getInstance()->add('shop.product.buy.after', [$this, 'index']);
        $this->template->assignScript('modules/share/js/share.js');
    }
}