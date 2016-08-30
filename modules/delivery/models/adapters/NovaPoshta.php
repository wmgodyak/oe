<?php

namespace modules\delivery\models\adapters;

use helpers\Translit;
use system\models\Guides;
use system\models\Model;

class NovaPoshta extends Model
{
    private $url = 'https://api.novaposhta.ua/v2.0/json/';
    protected $settings = [];
    private $result;

    private $guides;

    public function __construct($settings)
    {
        parent::__construct();

        $this->settings = $settings;
        $this->guides = new Guides();
    }

    public function getAreas()
    {
        $r = $this->sendRequest(['modelName' => 'Address', 'calledMethod' => 'getAreas']);
        if( ! $r) die("Can't create request");

        $res = $this->getResponse();

        if( isset($res['status']) && $res['status'] == 'error'){
            echo 'Request Error';
            d($res);
            die;
        }

//        d($res);die;
        $area_parent_id = $this->guides->getID('nova_poshta_warehouses');

        foreach ($res['data'] as $row) {
            $area_id = $this->guides->getID($row['Ref']);
            if(empty($area_id)){
                // create area
                $area_id = $this->guides->create
                (
                    [
                        'external_id' => $row['Ref'],
                        'parent_id'   => $area_parent_id
                    ],
                    [
                        1 => [
                            'name' => $row['Description'],
                            'url'  => Translit::str2url($row['Description']),
                        ],
                        2 => [
                            'name' => $row['Description'],
                            'url'  => Translit::str2url($row['Description'])
                        ]
                    ]
                );

                if(empty($area_id)){
                    echo $this->guides->getError();
                    break;
                }
            }
        }
    }

    public function getCities()
    {
        $r = $this->sendRequest(['modelName' => 'Address', 'calledMethod' => 'getCities']);
        if( ! $r) die("Can't create request");

        $res = $this->getResponse();

        if( isset($res['status']) && $res['status'] == 'error'){
            echo 'Request Error';
            d($res);
            die;
        }

        foreach ($res['data'] as $row) {
            $wh_id = $this->guides->getID($row['Ref']);
            if(! empty($wh_id)) continue;

            // getAreaID
            $area_id = $this->guides->getID($row['Area']);

            if(empty($area_id)){
                echo "Empty area_id for ref: {$row['Area']}. Continue...<br>";
                continue;
            }

            echo "Створення {$row['Description']}. {$row['Ref']}";

            $data = [
                'parent_id'   => $area_id,
                'external_id' => $row['Ref'],
                'settings'    => serialize($row),
            ];

            $u1 = $this->guides->getUrl($area_id, 1) . '/';
            $u2 = $this->guides->getUrl($area_id, 2) . '/';

            $info = [
                1 => [
                    'name' => $row['Description'],
                    'url'  => $u1 . Translit::str2url($row['Description']),
                ],
                2 => [
                    'name' => $row['DescriptionRu'],
                    'url'  => $u2 . Translit::str2url($row['DescriptionRu'])
                ]
            ];

            $s = $this->guides->create($data, $info);
            if( ! $s){
                echo $this->guides->getError();
                break;
            }
            echo " OK <br>";
        }
    }
    public function getWarehouses()
    {
        $r = $this->sendRequest(['modelName' => 'Address', 'calledMethod' => 'getWarehouses']);

        if( ! $r) die("Can't create request");

        $res = $this->getResponse();

        if( isset($res['status']) && $res['status'] == 'error'){
            echo 'Request Error';
            d($res);
            die;
        }

//        d($res);die;

        foreach ($res['data'] as $row) {

            $wh_id = $this->guides->getID($row['Ref']);
            if(! empty($wh_id)) continue;

            $city_id = $this->guides->getID($row['CityRef']);

            if(empty($city_id)){
                echo "Empty city_id for ref: {$row['CityRef']}. Continue...<br>";
                continue;
            }

            echo "Створення {$row['Description']}. {$row['Ref']}";

            $data = [
                'parent_id'   => $city_id,
                'external_id' => $row['Ref'],
                'settings'    => serialize($row),
            ];

            $u1 = $this->guides->getUrl($city_id, 1) . '/';
            $u2 = $this->guides->getUrl($city_id, 2) . '/2-';

            $info = [
                1 => [
                    'name' => $row['Description'],
                    'url'  => $u1 . Translit::str2url($row['Description']),
                ],
                2 => [
                    'name' => $row['DescriptionRu'],
                    'url'  => $u2 . Translit::str2url($row['DescriptionRu'])
                ]
            ];

            $s = $this->guides->create($data, $info);
            if( ! $s){
                echo $this->guides->getError() . '<br>' . $this->guides->getSQL();
                break;
            }
            echo " OK <br>";
        }
    }

    public function sendRequest($data)
    {
        $data['apiKey'] = $this->settings['key'];

        $data_string = json_encode($data);

        $ch = curl_init($this->url);

        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($data_string))
        );

        $result = curl_exec($ch);
        if( ! $result) return false;

        $this->result = json_decode($result, true);

        return true;
    }

    private function getResponse()
    {
        return $this->result;
    }
}