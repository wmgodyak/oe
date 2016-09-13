<?php

namespace modules\shopExport\controllers\admin;

use system\core\EventsHandler;
use system\Engine;
use system\models\Content;
use system\models\Currency;
use system\models\Languages;
use system\models\Settings;
use system\models\UsersGroup;

/**
 * Class ShopExport
 * @package modules\shopExport\controllers\admin
 */
class ShopExport extends Engine
{
    private $content;
    private $se;

    public function __construct()
    {
        parent::__construct();

        $this->content = new Content();
        $this->se = new \modules\shopExport\models\ShopExport();
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


    public function tree()
    {
        $items = array();
        $parent_id = $this->request->get('id', 'i');
        foreach ($this->content->tree($parent_id, 'products_categories') as $item) {
            $item['children'] = $item['isfolder'] == 1;
            if ($parent_id > 0) {
                $item['parent'] = $parent_id;
            }
            $item['text'] = "#{$item['id']} {$item['text']} ";
            $item['li_attr'] = [
                'id' => 'li_' . $item['id'],
                'class' => 'status-' . $item['status'],
                'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')

            ];
            $item['type'] = $item['isfolder'] ? 'folder' : 'file';

            $items[] = $item;
        }

        $this->response->body($items)->asJSON();
    }

    public function selectCategories($adapter)
    {
        $this->template->assign('adapter', $adapter);

        $this->response->body($this->template->fetch('modules/shopExport/select_categories'));
    }

    public function saveCategories()
    {
        $adapter = $this->request->post('adapter');
        $selected = $this->request->post('selected');
        Settings::getInstance()->set("shop_export_{$adapter}_categories", $selected);
        $this->response->body(['s' => 1])->asJSON();
    }

    public function getSelectedCategories()
    {
        $adapter = $this->request->post('adapter');
        $a = Settings::getInstance()->get("shop_export_{$adapter}_categories");

        $items = [];

        if( !empty($a)){
            $items = $this->se->getSelectedCategories($a);
        }

        $this->response->body(['items' => $items])->asJSON();
    }

    public function deleteCategory()
    {
        $id = $this->request->post('id', 'i');
        $adapter = $this->request->post('adapter', 's');
        $a = Settings::getInstance()->get("shop_export_{$adapter}_categories");
        $a = explode(',', $a);
        $k = array_search($id, $a);

        if($k !== false){
            unset($a[$k]);
        }

        $a = implode(',', $a);
        Settings::getInstance()->set("shop_export_{$adapter}_categories", $a);

        $this->response->body(['s' => 1])->asJSON();
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