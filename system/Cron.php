<?php
namespace system;
use system\core\EventsHandler;
use system\models\Modules;

/**
 * Class Cron
 * @package system
 */
class Cron// extends Front
{
    public function index()
    {
        // todo check cli
        $m = new Modules();
        $m->init();
        EventsHandler::getInstance()->call('system.cron.run');
//        echo 'done';
    }

    public function __destruct()
    {
        die;
    }
}