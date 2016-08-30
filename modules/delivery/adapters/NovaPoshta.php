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
//        $this->np->getWarehouses();

        die('__ok__');
    }

    public function onSelect()
    {
        $out = [
            'areas'      => ['label' => 'Область', 'name' => 'data[delivery_region_id]', 'id' => 'delivery_region_id', 'items' => []],
            'city'       => ['label' => 'Місто', 'name' => 'data[delivery_city_id]', 'id' => 'delivery_city_id', 'items' => []],
            'warehouses' => ['label' => 'Відділення', 'name' => 'data[delivery_department_id]', 'id' => 'delivery_department_id', 'items' => []]
        ];

        $guides = new Guides();

        $delivery_id = $this->request->post('delivery_id', 'i');
        $region_id   = $this->request->post('region_id', 'i');
        $city_id     = $this->request->post('city_id', 'i');

        if($delivery_id > 0){
            if($delivery_id == 2) {
                $wh = $guides->get('nova_poshta_warehouses');
                $out['areas']['items'] = $wh['items'];
            }
        }

        if($region_id > 0){
            $out['city']['items'] = $guides->getItems($region_id);
        }

        if($city_id > 0){
            $out['warehouses']['items'] = $guides->getItems($city_id);
        }

        return json_encode($out);
    }
}