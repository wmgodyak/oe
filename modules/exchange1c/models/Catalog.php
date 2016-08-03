<?php

namespace modules\exchange1c\models;

use modules\shop\models\admin\Import;
use system\core\Logger;
use system\models\Model;
use system\models\Settings;

/**
 * Class Catalog
 * @package modules\exchange1c\models
 */
class Catalog extends Model
{
    private $tmp_dir;
    private $config;
    private $login;
    private $password;
    private $mImport;
    /**
     * csv array data
     * @var array
     */
    private $data = [];

    public function __construct($login, $password, $config)
    {
        parent::__construct();

        $this->tmp_dir = DOCROOT . 'tmp/1c_exchange/catalog/';

        if(!is_dir($this->tmp_dir)){
            mkdir($this->tmp_dir, 0777, true);
        }

        $this->config   = $config;
        $this->login    = $login;
        $this->password = $password;

        $this->mImport  = new Import(1, ['id' => $this->config['owner_id']] ,'', 'USD');
    }

    public function checkauth()
    {
        if (($this->config['user']['login'] == $this->login)  && ($this->config['user']['password'] == $this->password)) {

            $key  = session_name();
            $pass = TOKEN;

            Logger::info("Auth success. SN: $key PASS: $pass");

            Settings::getInstance()->set('1c_token', $pass);

            return ['success', $key, $pass];

        }

        Logger::error("Auth fail. L:{$this->login}. P:{$this->password}");
        Logger::debug(var_export($_SERVER, 1));

        return ['failure', "Bad login or password."];
    }

    public function init()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];

        return ["zip={$this->config['zip']}", "file_limit={$this->config['file_limit']}"];
    }

    private function auth()
    {
        $pass = Settings::getInstance()->get('1c_token');

        if($pass == TOKEN){
            Logger::debug('Auth OK');

            return true;
        }

        Logger::error('Auth FAIL');

        return false;
    }

    public function file()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];
        
        $file_info = pathinfo($this->request->get('filename', 's'));

        if(empty($file_info['basename'])){
            return ['failure', "empty filename"];
        }
        
        $file_extension = $file_info['extension'];
        $basename = $file_info['basename'];

        Logger::debug('Loading filename:' . $basename);
        
        $file_content = file_get_contents('php://input');
        
        if(empty($file_content)){
            Logger::error('failure php://input  return empty string');
            return ['failure', 'php://input  return empty string'];
        }

        if ( $file_extension == 'csv' ) {
            if (! $this->saveFile($this->tmp_dir . $this->request->get('filename', 's'), $file_content, 'w+')) {
                return ['failure', "Can't save file"];
            }
        } else if ($file_extension == 'zip' && class_exists('ZipArchive')) {
            $zip = new \ZipArchive();
            $res = $zip->open($this->tmp_dir . $this->request->get('filename', 's'));
            if ($res > 0 && $res != TRUE) {
                switch ($res) {
                    case \ZipArchive::ER_NOZIP :
                        Logger::error('Not a zip archive.');
                        break;
                    case \ZipArchive::ER_INCONS :
                        Logger::error('Zip archive inconsistent.');
                        break;
                    case \ZipArchive::ER_CRC :
                        Logger::error('checksum failed');
                        break;
                    case \ZipArchive::ER_EXISTS :
                        Logger::error('File already exists.');
                        break;
                    case \ZipArchive::ER_INVAL :
                        Logger::error('Invalid argument.');
                        break;
                    case \ZipArchive::ER_MEMORY :
                        Logger::error('Malloc failure.');
                        break;
                    case \ZipArchive::ER_NOENT :
                        Logger::error('No such file.');
                        break;
                    case \ZipArchive::ER_OPEN :
                        Logger::error("Can't open file.");
                        break;
                    case \ZipArchive::ER_READ :
                        Logger::error("Read error.");
                        break;
                    case \ZipArchive::ER_SEEK :
                        Logger::error("Seek error.");
                        break;
                }
                return ['failure', "Can't save zip archive"];
            }

            $zip->extractTo($this->tmp_dir);
            $zip->close();
        }

        return ['success'];
    }

    public function import()
    {
//        if( ! $this->auth()) return ['failure', "Wrong token"];

        $filename = $this->request->get('filename', 's');

        if(empty($filename) || !file_exists($this->tmp_dir . $filename)){
            Logger::error("Can't find file {$filename}");
            return ['failure', "Can't find file {$filename}"];
        }

        $file_handle = fopen($this->tmp_dir . $filename, 'r');

        while (!feof($file_handle) ) {
            $a = fgetcsv($file_handle, 1024, ',');
            if(!is_array($a)) continue;

            foreach ($a as $k=>$v) {
                $a[$k] = trim(iconv('cp1251', 'utf-8', $v));
            }
            $this->data[] = $a;
        }

        fclose($file_handle);

        $fname = pathinfo($filename, PATHINFO_FILENAME);

        switch($fname){
            case 'kategorii':
                return $this->parseCategories();
                break;

            case 'tovaru':
                return $this->parseProducts();
                break;
        }

        return ['failure', "Wrong filename"];
    }

    private function parseCategories()
    {
        foreach ($this->data as $cat) {

            $ex_parent_id =  $cat[0];
            $external_id  =  $cat[1];
            $name         = trim($cat[2]);

            $s = $this->mImport->category($external_id, $name, $ex_parent_id);

            if(! $s) {
                Logger::error(implode("\n", $this->mImport->log));
                return ['failure', implode("\n", $this->mImport->log)];
            }
        }

        // set is folder for parents
        $this->mImport->setIsFolder();

        Logger::info(implode("\n", $this->mImport->log));

        return ['success', implode("\n", $this->mImport->log)];
    }

    /**
     *
     */
    public function parseProducts()
    {
        foreach ($this->data as $i=>$product) {

            // exclude headers
            if($i == 0) continue;

            $currency = [
                'USD' => 1,
                'UAH' => 2
            ];

            $data = []; $info = []; $prices = [];

            $category_ex_id = $product[0];
            $ex_id          = $product[1];

            $data['sku']         = $product[2];
            $data['currency_id'] = $product[5] == 'ДОЛАР' ? $currency['USD'] : 'UAH';
            $data['quantity'] = $product[6];
            $data['in_stock'] = $product[6] > 0 ? 1 : 0;

            $info['name']   = $product[3];
            $info['title']  = $product[4];

            $prices[5] = $product[7] * 1;
            $prices[6] = $product[8] * 1;
            $prices[7] = $product[9] * 1;
            $prices[8] = $product[10] * 1;

            $s = $this->mImport->product2
            (
                $ex_id,
                $category_ex_id,
                $data,
                $info,
                $prices
            );

            if( ! $s){
//                d($product);
                Logger::error(implode("\n", $this->mImport->log));
                Logger::error($this->mImport->getErrorMessage());
                return ['failure', implode("\n", $this->mImport->log)];
            }
        }

        Logger::info(implode("\n", $this->mImport->log));

        return ['success', implode("\n", $this->mImport->log)];
    }


    /**
     * @param $path
     * @param $data
     * @param string $mode
     * @return bool
     */
    private function saveFile($path, $data, $mode = 'w+b')
    {
        if ( ! $fp = @fopen($path, $mode))
        {
            return FALSE;
        }

        flock($fp, LOCK_EX);
        fwrite($fp, $data);
        flock($fp, LOCK_UN);
        fclose($fp);

        return TRUE;
    }
}