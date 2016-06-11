<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\components\admin\controllers\Admin;
use system\core\Config;
use system\core\Controller;
use system\core\Lang;
use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Settings;
use system\core\Template;
use system\models\Languages;
use system\models\Permissions;

if ( !defined("CPATH") ) die();

/**
 * Class Engine
 * в адмінці присутні наступні компоненти
 * блок навігації
 * функціональний блок
 * блок з сайдбаром
 * плагіни
 * @package controllers
 */
abstract class Engine extends Controller
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

    private $settings;

    protected $images;

    protected $request;

    protected $response;

    protected $template;

    private $panel_nav = [];

    private $require_components = [];
    private $required_components = [];

    private $engine;

    private static $initialized = false;

    protected $languages;
    protected $languages_id;

    protected $plugins;
    protected $admin = [];

    private $theme = null;

    public function __construct()
    {
        parent::__construct();

        $this->engine = new \system\models\Engine();

        $this->languages = new Languages();
        $this->languages_id = $this->languages->getDefault('id');

        $namespace   = $this->request->param('namespace');
        $controller  = $this->request->param('controller');
        $action      = $this->request->param('action');

        $this->request = Request::getInstance();

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['engine_theme_current'];
        $this->theme = $theme;

        $this->template = Template::getInstance($theme);

        if(
            (
                !\system\components\admin\models\Admin::isOnline(Admin::id(), Session::id())
            )
        ){
            if( $controller != 'Admin' && $action != 'login' ){
                $this->redirect('/engine/admin/login');
            }
        }

        if(!self::$initialized){

            Permissions::set(Admin::data('permissions'));
            if( $controller != 'Admin' && $action != 'login' ) {
                $namespace = str_replace('controllers\engine\\','', $namespace);
                if (!Permissions::check($namespace . $controller, $action)) {
                    $this->permissionDenied();
                }
            }

            $this->init();

            $this->makeCrumbs();
        }

        $this->admin = Admin::data();
    }

    private function init()
    {
        self::$initialized = true;

        $controller = $this->request->param('controller');
        $action     = $this->request->param('action');
        $controller = lcfirst($controller);


        if(! isset($_COOKIE["$this->theme.lang"])){
            $lang = Config::getInstance()->get('core.lang');
            $_COOKIE["$this->theme.lang"] = $lang;
        } else {
            $lang = $_COOKIE["$this->theme.lang"];
        }

        $this->template->assign('version',    $this->version);
        $this->template->assign('base_url',   APPURL . 'engine/');
        $this->template->assign('controller', $controller);
        $this->template->assign('action',     $action);
        $this->template->assign('t',          Lang::getInstance($this->theme, $lang)->t());
        $this->template->assign('languages',  $this->languages->get());

        // admin structure
        if($this->request->isGet() && ! $this->request->isXhr()){

            $this->makeNav();

//            $a = Admin::data('avatar');
//
//            if(empty($a)){
//                Admin::data('avatar', '/uploads/avatars/0.png');
//            }

            $this->template->assign('title', $this->t($controller . '.action_' . $action));
            $this->template->assign('name', $this->t($controller . '.action_' . $action));

// todo змінити на підвантаження assignScript assignStyle
//            $this->requireComponents();
        }
/*
        $com = '/themes/engine/assets/js/bootstrap/' . lcfirst($controller) . '.js';

        if(file_exists(DOCROOT . $com)){
            $this->template->assign('component_script',  $com);
        }
*/
        $this->template->assign('admin', Admin::data());

//        $this->plugins = Plugins::get();
//        $this->template->assign('plugins', $this->plugins);

    }

    private function permissionDenied()
    {
        $this->response->sendError(401);
        if($this->request->isXhr()){
            die;
        }
        echo $this->template->fetch('permission_denied'); die;
    }

    /**
     *
     */
    private function makeCrumbs()
    {
        $controller = $this->request->param('controller');
        $controller = lcfirst($controller);

        $breadcrumb =
            [
                [
                    'url'  => $controller,
                    'name' => $this->t($controller . '.action_index')
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
     *
     */
    private function makeNav()
    {
        $nav = $this->makeNavTranslations($this->engine->nav());

        $this->template->assign('nav_items', $nav);
        $s = $this->template->fetch('nav');
        $this->template->assign('nav', $s);
    }

    private function makeNavTranslations($nav)
    {
        $res = [];
        foreach ($nav as $item) {
            if($item['isfolder']){
                $item['items'] = $this->makeNavTranslations($item['items']);
            }

            $c = $item['controller'];
            if(strpos($c, '/') !== false){
                $a = explode('/', $c);
                $c = end($a);
                $c = lcfirst($c);
            }
            $item['name'] = $this->t($c . '.action_index');
            $res[] = $item;
        }

        return $res;
    }

    /**
     * translations
     * @param $key
     * @return string
     */
    protected function t($key)
    {
        return Lang::getInstance()->t($key);
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

    protected function requireComponent($component)
    {
        $this->require_components[] = $component;

        return $this;
    }

    private function requireComponents()
    {
        $components = [];
        foreach ($this->require_components as $component) {
            $component = mb_strtolower($component);
            $path = 'assets/js/bootstrap/' . $component . '.js';
            if(!file_exists($this->template->getThemePath() . $path)) continue;
            $components[] = $this->template->getThemeUrl() . $path;
            $this->required_components[] = $component;
        }

        if(!empty($components)){
            $this->template->assign('required_components', $components);
        }
    }

    /**
     * @param $body
     */
    protected final function output($body)
    {
        $this->renderHeadingPanel();
        return $body;
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
