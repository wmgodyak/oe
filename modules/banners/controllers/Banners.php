<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\banners\controllers;

use system\Front;

class Banners extends Front
{
    private $banners;

    public function __construct()
    {
        parent::__construct();

        $this->banners = new \modules\banners\models\Banners();
    }

    public function get($place_code, $limit = null, $order_by = null)
    {
        return $this->banners->get($place_code, $limit, $order_by);
    }

    public function click($key=null)
    {
        if(! $key){
            die;
        }

        $url = $this->banners->getUrlByKey($key);
        if(empty($url)){
            die;
        }

        $this->redirect($url);
    }
}