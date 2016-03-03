<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace controllers;

use controllers\core\Controller;
use controllers\core\Request;
use controllers\core\Response;
use controllers\core\Session;
use controllers\core\Settings;
use controllers\core\Template;
use controllers\engine\Admin;
use controllers\engine\Lang;
use controllers\engine\Plugins;
use controllers\engine\PluginsFactory;
use models\engine\Languages;

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

    public function __construct()
    {
        parent::__construct();

        $this->engine = new \models\Engine();

        $this->languages = new Languages();
        $this->languages_id = $this->languages->getDefault('id');

        $controller  = $this->request->get('controller');
        $action      = $this->request->get('action');

        $this->request = Request::getInstance();

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['engine_theme_current'];
        $this->template = Template::getInstance($theme);

//        echo $this->request->get('controller') ,'.', $this->request->get('action');die;
        if(
            (
                engine\Admin::id() == null ||
                ! \models\engine\Admin::isOnline(engine\Admin::id(), Session::id())
            )
        ){
            if( $controller != 'Admin' && $action != 'login' ){
                $this->redirect('/engine/admin/login');
            }
        }

        if(!self::$initialized){
            $this->init();
        }
    }

    private function init()
    {
        self::$initialized = true;

        $controller = $this->request->get('controller');
        $action = $this->request->get('action');
        $controller = lcfirst($controller);

        $this->template->assign('base_url',    APPURL . 'engine/');
        $this->template->assign('controller',  $controller);
        $this->template->assign('action',      $action);
        $this->template->assign('t',           Lang::getInstance()->t());

//        echo '<pre>'; print_r(Lang::getInstance()->t()); die;
        // admin structure
        if($this->request->isGet() && ! $this->request->isXhr()){

            $this->makeNav();

            $a = Admin::data('avatar');

            if(empty($a)){
                Admin::data('avatar', '/uploads/avatars/0.png');
            }

            $this->template->assign('title', $this->t($controller . '.action_' . $action));
            $this->template->assign('name', $this->t($controller . '.action_' . $action));

            $this->template->assign('languages',   $this->languages->get());

            $this->template->assign('admin', Admin::data());

            $this->requireComponents();
        }

        $this->plugins = Plugins::get();
        $this->template->assign('plugins', $this->plugins);
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
        $nav = [];
        foreach ($this->engine->nav() as $item) {
            $c = $item['controller'];
            if(strpos($c, '/') !== false){
                $a = explode('/', $c);
                $c = end($a);
                $c = mb_strtolower($c);
            }
            $item['name'] = $this->t($c . '.action_index');
            $nav[] = $item;
        }

        $this->template->assign('nav_items', $nav);
        $s = $this->template->fetch('nav');
        $this->template->assign('nav', $s);
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
//        echo $this->template->fetch('heading_panel');die;
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
        $this->response->body($body)->render();
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
