<?php

namespace modules\catalog\controllers;

use system\Frontend;

/**
 * Class Catalog
 * @package modules\catalog\controllers
 */
class Catalog extends Frontend
{
    public function init()
    {
        parent::init();

//        events()->add('init', function(){
//
//            $main = $this->currency->getMainMeta('id,code,rate,symbol');
//            $site = $this->currency->getOnSiteMeta('id,code,rate,symbol');
//
//            Session::set('currency', ['main' => $main, 'site' => $site ]);
//        });
    }
}