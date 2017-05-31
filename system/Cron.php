<?php
namespace system;
use system\core\EventsHandler;
use system\models\Modules;

/**
 * Class Cron
 * @package system
 */
class Cron
{
    public function index()
    {
        EventsHandler::getInstance()->call('system.cron.run');
    }

    public function __destruct()
    {
        die;
    }
}