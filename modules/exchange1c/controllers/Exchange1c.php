<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 01.08.16
 * Time: 21:43
 */

namespace modules\exchange1c\controllers;

use system\core\Logger;
use system\Front;
use system\models\Settings;

/**
 * Class Exchange1c
 * @name Обмін з 1с
 *
 * @description Синхронізація каталогу і замовлень з 1C
 * @copyright &copy; 2014 Otakoyi.com
 * @package controllers\modules
 * @author wmgodyak mailto:wmgodyak@gmail.com
 * @link http://v8.1c.ru/edi/edi_stnd/131/
 * @link https://1c.1c-bitrix.ru/support/faq.php
 * @package modules\exchange1c\controllers
 */
class Exchange1c extends Front
{
//    private $exchange;

    private $login;
    private $password;

    private $time;

    private $config;

    public function __construct()
    {
        parent::__construct();

//        $this->exchange = new \modules\exchange1c\models\Exchange1c();

        $this->config['debug'] = $this->request->get('debug');

        $this->time = microtime(true);

        $this->login    = isset($_SERVER['PHP_AUTH_USER']) ? trim($_SERVER['PHP_AUTH_USER']) : NULL;
        $this->password = isset($_SERVER['PHP_AUTH_PW']) ? trim($_SERVER['PHP_AUTH_PW']) : NULL;

        $user = [
            'login' => Settings::getInstance()->get('modules.Exchange1c.config.login'),
            'pass'  => Settings::getInstance()->get('modules.Exchange1c.config.pass')
        ];

        $this->config['user'] = $user;

        $this->config['owner_id'] = Settings::getInstance()->get('modules.Exchange1c.config.owner_id');

        // перевірка підтримки zip
        if (class_exists('ZipArchive')) {
            $this->config['zip'] = 'yes';
        } else {
            $this->config['zip'] = 'no';
        }

        // post max file size
        $this->config['file_limit'] = $this->toBytes('5M'); //ini_get('post_max_size')

        Logger::init('1c', 'exchange');
    }

    public function run()
    {
        Logger::debug('******* Run exchange *******');

        $type = $this->request->get('type', 's');
        $mode = $this->request->get('mode', 's');

        if($type && $mode){
            $ns   = 'modules\exchange1c\models\\';
            $path = str_replace('\\', '/', $ns);
            $type = ucfirst($type);

            if( !file_exists(DOCROOT . $path . $type . '.php')){
                $this->callback(['failure', "Model {$type} not found"]);
            }

            $c = $ns . $type;
            $instance = new $c($this->login, $this->password, $this->config);

            if (! method_exists($instance, $mode)) {
                Logger::error("$type::$mode not exists");
                $this->callback(['failure', "$type::$mode not exists"]);
            }

            Logger::debug("Run $type::$mode");

            $res = $instance->$mode();
            if($res){
                $this->callback($res);
            }

            Logger::debug("******* End exchange *******");
        }
    }

    /**
     * display response
     * @param array $data
     */
    private function callback(array $data)
    {
        /*if(! $this->debug){
            header('Content-type: text/html; charset=cp1251');
        }*/
//        header('Content-type: text/html; charset=utf8');
        echo  /*chr(239) . chr(187) . chr(191) .*/ implode("\n", $data); die();
    }

    private function toBytes ($size_str)
    {
        switch (substr ($size_str, -1))
        {
            case 'M': case 'm': return (int)$size_str * 1048576;
            case 'K': case 'k': return (int)$size_str * 1024;
            case 'G': case 'g': return (int)$size_str * 1073741824;
            default: return $size_str;
        }
    }
}