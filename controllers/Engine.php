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
    /**
     * right sidebar
     * @var
     */
    private $sidebar;

    /**
     * plugins list
     * @var
     */
    private $plugins;

    private $settings;

    protected $images;

    protected $request;

    protected $response;

    protected $template;

    private $panel_nav = [];

    private $require_components = [];
    private $required_components = [];

    public function __construct()
    {
        parent::__construct();

        $controller  = $this->request->get('controller');
        $action      = $this->request->get('action');

        $this->request = Request::getInstance();
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

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['engine_theme_current'];
        $this->template = Template::getInstance($theme);

        $this->template->assign('base_url',    APPURL . 'engine/');
        $this->template->assign('controller',  mb_strtolower($this->request->get('controller')));
        $this->template->assign('action',      $this->request->get('action'));
        $this->template->assign('t',           Lang::getInstance()->t());

        // admin structure
        if($this->request->isGet() && ! $this->request->isXhr()){
            $this->makeNav();
            $a = Admin::data('avatar');
            if(empty($a)){
                Admin::data('avatar', '/uploads/avatars/0.png');
            }

            $c = $this->request->get('controller');
            $a = $this->request->get('action');

            $this->template->assign('title', $this->t($c . '.action_' . $a));
            $this->template->assign('name', $this->t($c . '.action_' . $a));
            $this->template->assign('admin', Admin::data());

            $this->requireComponents();
        }

        $t_json =
        [
            'common' => Lang::getInstance()->t('common'),
            mb_strtolower($controller) => Lang::getInstance()->t(mb_strtolower($controller))
        ];


        foreach ($this->required_components as $c) {
            $t_json[$c] = $this->t($c);
        }

        $this->template->assign
        (
            't_json',
            json_encode($t_json)
        );
    }

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
        $nav = new \models\Engine();
        $this->template->assign('nav_items', $nav->nav());
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

    protected function setSidebar($sb)
    {
        $this->sidebar = $sb;
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
