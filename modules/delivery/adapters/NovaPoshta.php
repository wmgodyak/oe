<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 30.06.16
 * Time: 0:42
 */

namespace modules\delivery\adapters;
use system\core\Session;
use system\Front;
use system\models\Guides;

/**
 * Class NovaPoshta
 * @name Нова пошта
 * refresh data daily
 * @package modules\delivery\adapters
 */
class NovaPoshta extends Front
{
    public $settings = ['key' => '3bcfd1b3117485325fca9a70f6bb83c1'];

    private $np;

    public function __construct()
    {
        parent::__construct();

        $this->np = new \modules\delivery\models\adapters\NovaPoshta($this->settings);
    }

    public function refresh()
    {
        if( !isset($this->settings['key']) || empty($this->settings['key'])){
            die('Wrong Api Key');
        }

//        $this->np->getAreas();
//        $this->np->getCities();
        $this->np->getWarehouses();

        die('__ok__');
    }

    public function onSelect()
    {
        $out = null;
        $guides = new Guides();
        $action  = $this->request->post('action');
        switch($action){
            default:
                $out = json_encode($guides->get('nova_poshta_warehouses'));
                break;
        }

        return $out;
    }
}