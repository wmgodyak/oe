<?php

namespace modules\gmap\models;
use system\models\Model;

defined('CPATH') or die();
/**
 * Class Gmap *
 * @name Мапа
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\gmap\models
 */

class Gmap extends Model
{
    public function __construct()
    {
        parent::__construct();
    }


    public function get()
    {
        return self::$db->select("
                Select g.*,i.name from __gps g
                join __gps_info i on g.id=i.gps_id and i.e_languages_id={$this->languages_id}
                ORDER by abs(g.id)
            ")->all();
    }
}
