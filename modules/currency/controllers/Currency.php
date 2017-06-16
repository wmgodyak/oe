<?php

namespace modules\currency\controllers;

use system\core\Session;
use system\Frontend;

/**
 * Class Currency
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\currency\controllers
 */
class Currency extends Frontend
{
    private $currency;

    public function __construct()
    {
        parent::__construct();

        $this->currency = new \modules\currency\models\Currency();
    }

    public function init()
    {
        parent::init();

        events()->add('init', function(){

            $main = $this->currency->getMainMeta('id,code,rate,symbol');
            $site = $this->currency->getOnSiteMeta('id,code,rate,symbol');

            Session::set('currency', ['main' => $main, 'site' => $site ]);
            $this->template->assign('currency', $site);
        });
    }
}