<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.08.16 : 13:48
 */

namespace modules\exchange1c\models;

use system\core\Logger;
use system\models\Model;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Currency
 * @package modules\exchange1c\models
 */
class Currency extends Model
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

        $this->tmp_dir = DOCROOT . 'tmp/1c_exchange/currency/';

        if(!is_dir($this->tmp_dir)){
            mkdir($this->tmp_dir, 0777, true);
        }

        $this->config   = $config;
        $this->login    = $login;
        $this->password = $password;
    }

    public function checkauth()
    {
        if (!isset($_SERVER['PHP_AUTH_USER'])) {
            header('WWW-Authenticate: Basic realm="OYi.Engine"');
            return ['failure', "EX000. Authentication Required."];
        }

        if (
            ($this->config['user']['login'] == $this->login)
            && ($this->config['user']['password'] == $this->password)
        ) {

            $key  = session_name();
            $pass = TOKEN;

            Logger::info("Auth success. SN: $key PASS: $pass");

            Settings::getInstance()->set('1c_token', $pass);

            return ['success', $key, $pass];
        }

        Logger::error("Auth fail. L:{$this->login}. P:{$this->password}");
//        Logger::debug(var_export($_SERVER, 1));

        return ['failure', "EX003. Bad login or password."];
    }

    public function init()
    {
        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

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

   public function update()
   {
       if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

       $code = $this->request->get('code');
       $rate = $this->request->get('rate');

       if($code && $rate){
           $currency = new \system\models\Currency();
           $s = $currency->setRateByCode($code, $rate);
           if(! $s) {
               Logger::error($currency->getErrorMessage());
               return ['failure', 'EX009. ' .$currency->getErrorMessage()];
           }
           return ['success'];
       }

       return ['failure', 'Wrong currency code or rate'];
   }

    public function file()
    {
        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

        $file_info = pathinfo($this->request->get('filename', 's'));

        if(empty($file_info['basename'])){
            return ['failure', "EX005. empty filename"];
        }

        $file_extension = $file_info['extension'];
        $basename = $file_info['basename'];

        Logger::debug('Loading filename:' . $basename);

        $file_content = file_get_contents('php://input');

        if(empty($file_content)){
            Logger::error('failure php://input  return empty string');
            return ['failure', 'EX006. php://input  return empty string'];
        }

        if ( $file_extension == 'csv' ) {
            if (! $this->saveFile($this->tmp_dir . $this->request->get('filename', 's'), $file_content, 'w+')) {
                return ['failure', "EX007. Can't save file"];
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
                return ['failure', "EX008. Can't save zip archive"];
            }

            $zip->extractTo($this->tmp_dir);
            $zip->close();
        }

        return ['success'];
    }

    public function import()
    {
        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

        $filename = $this->request->get('filename', 's');

        if(empty($filename) || !file_exists($this->tmp_dir . $filename)){
            Logger::error("Can't find file {$filename}");
            return ['failure', "EX005. Can't find file {$filename}"];
        }

        $file_handle = fopen($this->tmp_dir . $filename, 'r');

        while (!feof($file_handle) ) {
            $a = fgetcsv($file_handle, 1024, ';');
            if(!is_array($a)) continue;

            foreach ($a as $k=>$v) {
                $a[$k] = trim(iconv('cp1251', 'utf-8', $v));
            }
            $csv[] = $a;
        }

        fclose($file_handle);

        array_walk($csv, function(&$a) use ($csv) {
            $a = array_combine($csv[0], $a);
        });
        array_shift($csv); # remove column header

        $currency = new \system\models\Currency();
        foreach ($csv as $cu) {
            $s = $currency->setRateByCode($cu['code'], $cu['rate']);
            if(! $s) {
                Logger::error($currency->getErrorMessage());
                return ['failure', 'EX009. ' .$currency->getErrorMessage()];
            }
        }

        return ['success'];
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