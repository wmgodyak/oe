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
        $period = 6;
        $res = Settings::getInstance()->get('core_updates');
        if(isset($res->last_check) && ( time() - $res->last_check < $period)) {
            return;
        }

        $res = $this->api('core/version', ['version' => self::VERSION, 'php_version' => phpversion()]);

        if(isset($res['status']) && $res['status']){

            $res = $res['response'];
            $res->last_check = time();

            Settings::getInstance()->set('core_updates', $res);

            if (version_compare(self::VERSION, $res->current, '<')) {
                echo "<p>Доступна нова версія Engine {$res->current}. <button id='b_update_core' class='btn'>Оновіться</button> будь-ласка.</p>";
            }
        }
    }

    public function run()
    {
        $s = 0; $m = [];

        $res = Settings::getInstance()->get('core_updates');

        if (version_compare(self::VERSION, $res->current, '<')) {
            $u = end($res->updates);
            d($u);
            $dir  = "tmp/updates/";
            $s = $this->downloadSource($u->source, $dir);
            if($s){
                $this->createBackup();
                // extract
//                $this->extractArchive()
            }
        }

        $this->response->body(['s'=>$s,'m'=>$m])->asJSON();
    }

    private function downloadSource($url, $dest)
    {
        set_time_limit(0);
        if(! is_dir(DOCROOT . $dest)){ mkdir(DOCROOT . $dest , 0777, true); }

        $i = pathinfo($url);
        $fn = $i['basename'];

        if(file_exists(DOCROOT . $dest . $fn)) @unlink(DOCROOT . $dest . $fn);

        $fp = fopen (DOCROOT . $dest . $fn, 'w+');

        $ch = curl_init(str_replace(" ","%20",$url));

        curl_setopt($ch, CURLOPT_TIMEOUT, 50);
        curl_setopt($ch, CURLOPT_FILE, $fp);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);

        $res = curl_exec($ch);//get curl response

        curl_close($ch);

        return $res;
    }

    /**
     * @return bool
     */
    private function createBackup()
    {
        $excluded = ['.git', '.idea','uploads', 'tmp', 'logs'];
        $name = self::VERSION;

        $backup_path = DOCROOT ."tmp/updates/backup/";
        if(! is_dir($backup_path)){ mkdir($backup_path , 0777, true); }

        $rootPath = DOCROOT;

        $zip = new \ZipArchive();
        $zip->open("{$backup_path}{$name}.zip", \ZipArchive::CREATE | \ZipArchive::OVERWRITE);

        $files = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($rootPath),
            \RecursiveIteratorIterator::LEAVES_ONLY
        );

        foreach ($files as $name => $file)
        {
            //exclude some direrctories
            $ex = false;
            foreach ($excluded as $k=>$v) {
                if(strpos($name, $v) != false){
                    $ex = true; break;
                }
            }
            if($ex) continue;

//            echo "$name\r\n";    continue;

            if (!$file->isDir())
            {
                $filePath = $file->getRealPath();

                $localname = str_replace(DOCROOT, '', $filePath);
                $zip->addFile($filePath, $localname);
            }
        }

        $zip->close();

        return true;
    }

    /**
     * @param $path
     * @param $dest
     * @return bool
     */
    private function extractArchive($path, $dest)
    {
//        $zip = new \ZipArchive;
//        if ($zip->open($path) === true) {
//            for($i = 0; $i < $zip->numFiles; $i++) {
//                $filename = $zip->getNameIndex($i);
//                $fileinfo = pathinfo($filename);
////                copy("zip://".$path."#".$filename, "/your/new/destination/".$fileinfo['basename']);
//            }
//            $zip->close();
//            return true;
//        }
//
//        return false;
        $zip = new \ZipArchive;
        $res = $zip->open($path);
        if ($res === TRUE) {
            $zip->extractTo($dest);
            $zip->close();

            return true;
        }

        return false;
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