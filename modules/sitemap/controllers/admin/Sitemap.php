<?php

namespace modules\sitemap\controllers\admin;
use system\core\EventsHandler;
use system\Engine;
use system\models\ContentTypes;

/**
 * Class Sitemap
 * @package modules\sitemap\controllers\admin
 */
class Sitemap extends Engine
{
    public function __construct()
    {
        parent::__construct();
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('content.params.after', [$this, 'params']);
        EventsHandler::getInstance()->add('system.modules.config.Sitemap', [$this, 'config']);
    }

    public function params($content)
    {
        return $this->template->fetch('modules/sitemap/params');
    }

    public function config($config)
    {
        $this->template->assign('types', new ContentTypes());
        return $this->template->fetch('modules/sitemap/config');
    }

    public function index()
    {
    }

    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function delete($id)
    {
    }

    public function process($id)
    {
    }

}