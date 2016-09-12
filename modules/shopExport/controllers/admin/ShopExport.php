<?php

namespace modules\shopExport\controllers\admin;

use system\core\EventsHandler;
use system\Engine;
use system\models\Currency;
use system\models\Languages;
use system\models\UsersGroup;

/**
 * Class ShopExport
 * @package modules\shopExport\controllers\admin
 */
class ShopExport extends Engine
{
    public function __construct()
    {
        parent::__construct();
    }


    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('system.modules.config.ShopExport', [$this, 'config']);
    }

    public function config($config)
    {
        $adapters_dir = 'modules/shopExport/models/adapters/';
        $adapters = [];

        if ($handle = opendir(DOCROOT . $adapters_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == "..")  continue;

                $adapters[] = str_replace('.php','', $module);
            }
            closedir($handle);
        }
        $this->template->assign('adapters', $adapters);

        $ug = new UsersGroup();
        $this->template->assign('users_group', $ug->getItems(0));

        $cu = new Currency();
        $this->template->assign('currency', $cu->get());
        $l = new Languages();
        $this->template->assign('langs', $l->get());
        return $this->template->fetch('modules/shopExport/config');
    }

    public function index()
    {
        // TODO: Implement index() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}