<?php

namespace system\components\widgets\controllers;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\core\exceptions\Exception;
use system\core\WidgetsAreas;
use system\core\WidgetsFactory;
use system\Engine;
use system\models\Settings;

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
            $areas = WidgetsAreas::get();
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

            return $t->render($res,count($res));
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
        // примусово перемкну режим на backend тому що ініціалізація фронт модулів переключила режим
        $this->request->setMode('backend');
        return $modules;
    }

    public function create()
    {

    }

    public function edit($area)
    {
        $this->addBreadCrumb('Налаштування розміщення');
        // примусово ініціалізую модулі
        $this->initModules();


        $areas = WidgetsAreas::get();

        if(!isset($areas[$area])) {
            $this->redirect('/', 404);
        }

        $t = new DataTables2('widgets');

        $t
            -> title('Встановлені віджети')
            -> ajax('widgets/edit/' . $area)
            -> th('<i class="fa-list fa"></i>', null, false, false, 'width: 40px')
            -> th($this->t('common.id'), null, false, false, 'width: 240px')
            -> th($this->t('widgets.name'), null, 0, 0, 'width: 300px')
            -> th($this->t('widgets.description'), null)
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 140px')
        ;

        if($this->request->isXhr()){

            $this->initModules();
            $installed_widgets = Settings::getInstance()->get('widgets');

            $res = array(); $i=0;
            if(isset($installed_widgets[$area])){
                foreach ($installed_widgets[$area] as $k=> $a) {
                    $widget_id = $a['id'];
                    $widget = WidgetsFactory::get($widget_id);
                    if(! $widget) continue;

                    $meta = $widget->getMeta();
                    $res[$i][] = "<i class='fa-list fa' id='$widget_id'></i>";
                    $res[$i][] = "<input type='text' class='form-control' readonly onfocus='select();' value='{$widget_id}'>";
                    $res[$i][] = $meta['name'];
                    $res[$i][] = $meta['description'];

                    $res[$i][] =
                        (string)Button::create
                        (
                            Icon::create(Icon::TYPE_EDIT),
                            ['class' => 'b-widgets-form', 'data-id' => $widget_id, 'data-area' => $area, 'title' => $this->t('widgets.edit')]
                        ) .
                        (string)Button::create
                        (
                            Icon::create(Icon::TYPE_DELETE),
                            ['class' => 'b-widgets-delete btn-danger', 'data-id' => $widget_id, 'data-area' => $area, 'title' => $this->t('widgets.delete')]
                        )
                    ;
                    $i++;
                }
            }

            return $t->render($res,  count($res));
        }

        // список доступних віджетів
        $this->template->assign('area', $area);
        $this->template->assign('available_widgets', WidgetsFactory::get());

        $this->output
        (
            $t->init() .
            $this->template->fetch('system/widgets/available')
        );
    }

    public function add()
    {
        $widget = $this->request->post('widget');
        $area   = $this->request->post('area');

        if(empty($widget) || empty($area)){
            die('0');
        }

        $installed_widgets = Settings::getInstance()->get('widgets');

        if(!isset($installed_widgets[$area])){
            $installed_widgets[$area][] = ['id' => $widget];
            Settings::getInstance()->set('widgets', $installed_widgets);
            echo 1;
        } else {
            foreach ($installed_widgets[$area] as $k => $w) {
                if($w == $widget) {
                    return 0;
                }
            }

            $installed_widgets[$area][] = ['id' => $widget];
            Settings::getInstance()->set('widgets', $installed_widgets);
        }
    }

    public function delete($id = null)
    {
        $widget = $this->request->post('widget');
        $area   = $this->request->post('area');

        if(empty($widget) || empty($area)){
            die;
        }

        $installed_widgets = Settings::getInstance()->get('widgets');

        if(isset($installed_widgets[$area])){

            $k = array_search($widget, $installed_widgets[$area]);
            if($k){
                unset($installed_widgets[$area][$k]);
                Settings::getInstance()->set('widgets', $installed_widgets);
                echo 1;
            }
        }
    }

    public function form()
    {
        $widget = $this->request->post('widget');
        $area   = $this->request->post('area');

        if(empty($widget) || empty($area)){
            die;
        }

        $installed_widgets = Settings::getInstance()->get('widgets');

        if(!isset($installed_widgets[$area])){
            die;
        }

        $this->initModules();

        $k = array_search($widget, $installed_widgets[$area]);
        $widget_id = $installed_widgets[$area][$k]['id'];
        $widget_data = isset($installed_widgets[$area][$k]['data']) ? $installed_widgets[$area][$k]['data'] : [];
        $widgetInstance = WidgetsFactory::get($widget_id);


        $this->template->assign('widget_form', $widgetInstance->form($widget_data));
        $this->template->assign('widget', $widget);
        $this->template->assign('area', $area);

        return $this->template->fetch('system/widgets/form');
    }

    public function update()
    {
        $widget = $this->request->post('widget');
        $area   = $this->request->post('area');
        $data   = $this->request->post('data');

        if(!$data || empty($widget) || empty($area)){
            die;
        }

        $installed_widgets = Settings::getInstance()->get('widgets');

        if(isset($installed_widgets[$area])){
            $k = array_search($widget, $installed_widgets[$area]);
            $installed_widgets[$area][$k]['data'] = $data;
            Settings::getInstance()->set('widgets', $installed_widgets);
            $this->response->body(['s' => 1])->asJSON();
        }

    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}