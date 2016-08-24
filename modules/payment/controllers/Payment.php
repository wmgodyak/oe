<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\payment\controllers;

use system\core\EventsHandler;
use system\Front;

/**
 * Class Payment
 * @name Оплата
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\payment\controllers
 */
class Payment extends Front
{
    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('layouts.pages.content', [$this, 'index']);
    }

    public function index()
    {
        if($this->page['id'] != 13) return ;

        $oid = $this->request->get('oid');
        if(! $oid)  return;


    }
}