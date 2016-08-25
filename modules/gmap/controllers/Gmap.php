<?php
namespace modules\gmap\controllers;
use system\models\Settings;

defined('CPATH') or die();

/**
 * Class Gmap
 * @name Мапа
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\gmap\controllers
 */
class Gmap extends \system\Front
{
    private $model;
    public function __construct()
    {
        parent::__construct();
        $this->model = new \modules\gmap\models\Gmap();
    }

    public function getMarkers($json = true)
    {
        $items = [];
        $r = $this->model->get();
        foreach ($r as $k=>$item) {
            $a = explode(',', $item['value']);
            $items[] = [
                'title' => $item['name'],
                'position' => [
                    'lat' => $a[0] * 1,
                    'lng' => $a[1] * 1
                ]
            ];
        }
        if($json){
            return json_encode($items);
        }

        return $items;
    }

    public function getApiKey()
    {
        return Settings::getInstance()->get('modules.Gmap.config.api_key');
    }
}
