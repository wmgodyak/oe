<?php

namespace system\components\features\models;

defined("CPATH") or die();

/**
 * Class Features
 * @package system\components\features\models
 */
class Features extends \system\models\Features
{
    private $featuresContent;

    public function __construct()
    {
        parent::__construct();
        $this->featuresContent = new \system\models\FeaturesContent();
    }

    public function reorder()
    {
        $order   = $this->request->post('order');
        $order   = str_replace('dt-','', $order);
        $a = explode(',', $order);
        foreach ($a as $k => $row_id) {
            self::$db->update('__features', ['position' => $k], " id = '$row_id' limit 1");
            if($this->hasError()) return false;
        }
    }
}