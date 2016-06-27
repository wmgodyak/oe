<?php

namespace system\components\widgets\controllers;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\core\exceptions\Exception;
use system\core\WidgetsArea;
use system\Engine;

defined("CPATH") or die();

class Widgets extends Engine
{
    private $modules_dir = 'modules';

    public function __construct()
    {
        parent::__construct();

        $this->template->assignScript(dirname(__FILE__) . "/js/widgets.js");
    }

    public function index()
    {
        $t = new DataTables2('widgets');

        $t
            -> ajax('widgets/index')
            -> th($this->t('common.id'), null, false, false, 'width: 240px')
            -> th($this->t('widgets_area.name'), null)
            -> th($this->t('widgets_area.description'), null, 0, 0, 'width: 300px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 40px')
        ;

        if($this->request->isXhr()){
            $this->initModules();
            $areas = WidgetsArea::get();
//            $this->dump($areas);die;
            $res = array(); $i=0;
            foreach ($areas as $id=> $meta) {
                $res[$i][] = "<input type='text' class='form-control' readonly onfocus='select();' value='{$id}'>";
                $res[$i][] = $meta['name'];
                $res[$i][] = $meta['description'];

                $res[$i][] =
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_SETTINGS),
                        ['class' => 'b-widgets-area-settings', 'href' => 'widgets/edit/'. $id, 'title' => $this->t('widgets_area.configure')]
                    )
                ;
                $i++;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->output($t->init());
    }

    private function initModules()
    {
        $modules = new \stdClass();
        if ($handle = opendir(DOCROOT . $this->modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == "..")  continue;

                $c  = $this->modules_dir .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(!file_exists(DOCROOT . $path . '.php')) {
                    throw new Exception("Module $module issue.");
                }

                $controller = new $c;
                $modules->{$module} = $controller;

                call_user_func(array($controller, 'init'));
            }
            closedir($handle);
        }

        return $modules;
    }

    public function create()
    {

    }

    public function edit($id)
    {
        $this->initModules();

        $areas = WidgetsArea::get();
        $this->dump($areas);
        $this->output($id);
//        $this->dump($this->admin);
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