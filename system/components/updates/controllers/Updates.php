<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 08.11.16 : 12:15
 */

namespace system\components\updates\controllers;

use system\Backend;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Updates
 * @package system\components\updates\controllers
 */
class Updates extends Backend
{
    const CORE_URL = "http://downloads.engine.loc";

    public function check()
    {
        $period = 24*60*60;
        $period = 60;
        $res = Settings::getInstance()->get('core_updates');
        if(isset($res->last_check) && ( time() - $res->last_check < $period)) {
            return;
        }

        $res = $this->api('core/version', ['version' => self::VERSION, 'php_version' => phpversion()]);

        if(isset($res['status']) && $res['status']){

            $res = $res['response'];
            $res->last_check = time();

            Settings::getInstance()->set('core_updates', $res);


            if (version_compare(self::VERSION, $res->currenct, '<')) {
                echo "<p>Доступна нова версія Engine {$res->current}. <button id='b_update_core'>Оновіться</button> будь-ласка.</p>";
            }
        }
    }

    public function run()
    {
        $res = Settings::getInstance()->get('core_updates');
    }

    public function index(){}
    public function create(){}
    public function edit($id){}
    public function process($id){}
    public function delete($id){}

    /**
     * @param $url
     * @param array $params
     * @return array
     */
    private function api($url, $params = [])
    {
        $status = false; $response = null;

        $url = self::CORE_URL .'/'. $url;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);

        $server_output = curl_exec($ch);

        if(!$server_output){
            $response = 'Error: "' . curl_error($ch) . '" - Code: ' . curl_errno($ch);
        } else {
            $status = true;
            $response = json_decode($server_output);
        }

        curl_close($ch);

        return [
            'status' => $status,
            'response' => $response
        ];
    }
}