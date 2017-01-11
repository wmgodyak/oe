<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\components\admin\controllers\Admin;
use system\core\Config;
use system\core\Controller;
use system\core\EventsHandler;
use system\core\Lang;
use system\core\Session;
use system\core\Template;
use system\models\App;
use system\models\Images;
use system\models\Languages;
use system\models\Modules;
use system\models\Permissions;
use system\models\Settings;

if ( !defined("CPATH") ) die();

/**
 * Class Engine
 * @package controllers
 */
abstract class Backend extends Controller
{
    /**
     * content of body
     * @var string
     */
    private $content;
    /**
     * buttons
     * @var array
     */
    private $buttons = array();

    protected $settings;

    protected $images;


    protected $template;

    private $panel_nav = [];

    private $engine;

    private static $initialized = false;

    protected $languages;
    protected $languages_id = 1;

    protected $plugins;
    protected $admin = [];

    private $theme = null;
    private $lang = null;

    protected $modules = [];


    public function __construct()
    {
        parent::__construct();

        $this->engine = new \system\models\Backend();

        $this->languages = new Languages();
        $this->languages_id = $this->languages->getDefault('id');

        $this->images = new Images();

//        $namespace   = $this->request->param('namespace');
        $controller  = $this->request->param('controller');
        $action      = $this->request->param('action');

//        $this->request = Request::getInstance();


        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['backend_theme'];
        $this->theme = $theme;
        $this->lang = Session::get('backend_lang');

        $this->template = Template::getInstance($theme);

        $version = Config::getInstance()->get('core.version');
        $this->template->assign('version',    $version);
        $this->template->assign('base_url',   APPURL . "{$this->settings['backend_url']}/");
        $this->template->assign('settings',   $this->settings);

        $this->validateToken();

        if(
            (
                ! \system\components\admin\models\Admin::isOnline(Admin::id(), Session::id())
            )
        ){
            if( $controller != 'Admin' && $action != 'login' ){
                $this->redirect("/{$this->settings['backend_url']}/admin/login");
            }
        }

        if(!self::$initialized){

            $controller = $this->request->param('controller');
            $controller = lcfirst($controller);

            Permissions::set(Admin::data('permissions'));
            if( ($controller != 'admin' && $action != 'login') && $controller != 'module' ) {
                if (!Permissions::canComponent($controller, $action)) {
                    Permissions::denied();
                }
            }

            $this->_init();

            $this->makeCrumbs($this->t($controller . '.action_index'), $controller);
        }

        $this->admin = Admin::data();
    }

    public function init(){}

    private function _init()
    {
        self::$initialized = true;

        $controller = $this->request->param('controller');
        $action     = $this->request->param('action');
        $controller = lcfirst($controller);

        $this->template->assign('controller', $controller);

        $this->template->assign('action',     $action);
        $this->initSystemComponents();

        $app = new App();
        Template::getInstance()->assign('app', $app);

        // assign events
        $events = EventsHandler::getInstance();
        Template::getInstance()->assign('events', $events);

        $m = new Modules($this->theme, $this->lang, 'backend');
        $this->modules = $m->init();

        $this->template->assign('t', Lang::getInstance($this->theme, $this->lang)->t());

        // admin structure
        if($this->request->isGet() && ! $this->request->isXhr()){

            $this->makeNav();

            $a = Admin::data('avatar');

            if(empty($a)){
                Admin::data('avatar', '/uploads/avatars/0.png');
            }

            $this->template->assign('title', $this->t($controller . '.action_' . $action));
            $this->template->assign('name',  $this->t($controller . '.action_' . $action));
        }

        $this->template->assign('languages',  $this->languages->get());

        $this->template->assign('admin', Admin::data());

    }
    /**
     * @param $name
     * @param $url
     */
    protected function makeCrumbs($name, $url)
    {
        $breadcrumb =
            [
                [
                    'url'  => $url,
                    'name' => $name
                ]
            ];

        $this->template->assign('breadcrumb', $breadcrumb);
    }

    /**
     * @param $name
     * @param null $url
     */
    protected function addBreadCrumb($name, $url=null)
    {
        $items = $this->template->getVars('breadcrumb');

        $items = array_merge($items, [['name' => $name, 'url' => $url]]);
        $this->template->assign('breadcrumb', $items);
    }

    public function before(){}

    protected final function setButtonsPanel($buttons)
    {
        if(is_string($buttons)){
            $this->panel_nav = array($buttons);
        } else {
            $this->panel_nav = $buttons;
        }
        return $this;
    }

    /**
     * @param $button
     * @return $this
     */
    protected final function prependToPanel($button)
    {
        array_unshift($this->panel_nav, $button);

        return $this;
    }

    /**
     * @param $button
     * @return $this
     */
    protected final function appendToPanel($button)
    {
        $this->panel_nav[] = $button;

        return $this;
    }


    /**
     * translations
     * @param $key
     * @return string
     */
    protected function t($key)
    {
        return Lang::getInstance($this->theme, $this->lang)->t($key);
    }

    protected function setNav($b)
    {
        $this->buttons[] = $b;
    }

    protected function setContent($c)
    {
        $this->content = $c;
    }

    private final function renderHeadingPanel()
    {
        $this->template->assign('panel_nav', $this->panel_nav);
        $this->template->assign('heading_panel', $this->template->fetch('heading_panel'));
    }


    private static $menu_nav = [];

    /**
     * @param $name
     * @param $url
     * @param $icon
     * @param $parent
     * @param $position
     */
    protected function assignToNav($name, $url, $icon = null, $parent = null, $position = 0)
    {
        while(isset(self::$menu_nav[$position])){
            $position += 5;
        }

        self::$menu_nav[$position] = [
            'name'     => $name,
            'url'      => $url,
            'icon'     => $icon,
            'parent'   => $parent,
            'isfolder' => 0
        ];
    }
    /**
     *
     */
    private function makeNav()
    {
        $nav = []; $ws_parents = [];
        foreach (self::$menu_nav as $k=>$item) {
            if($item['parent'] != null){
                $ws_parents[] = $item;
                continue;
            }
            $nav[$k] = $item;
        }

        foreach ($ws_parents as $item) {
            foreach ($nav as $k=>$n) {
                if($n['url'] == $item['parent']){
                    $nav[$k]['isfolder'] = 1;
                    $nav[$k]['items'][] = $item;
                }
            }
        }

        ksort($nav);
        $this->template->assign('nav_items', $nav);
        $s = $this->template->fetch('nav');
        $this->template->assign('nav', $s);
    }

    private function initSystemComponents()
    {
        $ns = 'system\components';
        $root = str_replace('\\','/', $ns);

        $components = new \stdClass();
        if ($handle = opendir(DOCROOT . $root)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == 'content')  continue;

                if(! Permissions::canComponent($module, 'index')) continue;

                $c  = $ns .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {

                    $controller = new $c;
                    $components->{$module} = $controller;
                    if(is_callable(array($controller, 'init'))){
                        call_user_func(array($controller, 'init'));
                    }
                }
            }
            closedir($handle);
        }

        return $components;
    }

    /**
     * @param $body
     */
    protected final function output($body)
    {
        $this->renderHeadingPanel();
        $this->response->body($body)->asHtml();
    }

    /**
     * @return mixed
     */
    abstract public function create();

    /**
     * @param $id
     * @return mixed
     */
    abstract public function edit($id);

    /**
     * @param $id
     * @return mixed
     */
    abstract public function process($id);

    /**
     * @param $id
     * @return mixed
     */
    abstract public function delete($id);
}
