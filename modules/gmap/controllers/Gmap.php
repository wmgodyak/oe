<?php
namespace modules\gmap\controllers;
defined('CPATH') or die();

/**
 * Class Gmap *
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

    public function init()
    {
        parent::init(); // TODO: Change the autogenerated stub
    }

    public function get()
    {
        $items = $this->model->get();

        echo json_encode($items);
    }
}
