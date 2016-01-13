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

    public function __construct()
    {
        parent::__construct();

        $this->request = Request::getInstance();
//        echo $this->request->get('controller') ,'.', $this->request->get('action');die;
        if(
            (
                engine\Admin::id() == null ||
                ! \models\engine\Admin::isOnline(engine\Admin::id(), Session::id())
            )
        ){
            if( $this->request->get('controller') != 'Admin' && $this->request->get('action')     != 'login' ){
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
        $this->template->assign('controller',  $this->request->get('controller'));
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
        }
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
     * @param $name
     * @param array $args
     * @param null $icon
     * @return $this
     */
    protected final function prependButtonToPanel($name, array $args, $icon=null)
    {
        $button = [
            'type'   => 'button',
            'name'   => $name,
            'args'   => $this->parseArgs($args),
            'icon'   => $icon
        ];

        array_unshift($this->panel_nav, $button);

        return $this;
    }

    /**
     * @param $name
     * @param array $args
     * @param null $icon
     * @return $this
     */
    protected final function appendButtonToPanel($name, array $args, $icon=null)
    {

        $button = [
            'type'   => 'button',
            'name'   => $name,
            'args'   => $this->parseArgs($args),
            'icon'   => $icon
        ];

        $this->panel_nav[] = $button;

        return $this;
    }

    /**
     * @param $name
     * @param array $args
     * @param null $icon
     * @return $this
     */
    protected final function prependLinkToPanel($name, array $args, $icon=null)
    {
        $button = [
            'type'   => 'link',
            'name'   => $name,
            'args'   => $this->parseArgs($args),
            'icon'   => $icon
        ];

        array_unshift($this->panel_nav, $button);

        return $this;
    }

    /**
     * @param $name
     * @param array $args
     * @param null $icon
     * @return $this
     */
    protected final function appendLinkToPanel($name, array $args, $icon=null)
    {
        $button = [
            'type'   => 'link',
            'name'   => $name,
            'args'   => $this->parseArgs($args),
            'icon'   => $icon
        ];

        $this->panel_nav[] = $button;

        return $this;
    }


    /**
     * @param array $args
     * @return string
     */
    private function parseArgs(array $args)
    {
        $_args = ''; $has_class = false;
        foreach ($args as $k => $v) {
            if($k == 'class'){
                $a = explode(' ', $v);
                if (!in_array('btn', $a))  $v .= ' btn';
                $has_class = true;
            }

            if(!$has_class){ $_args .= " class=\"btn btn-md\"";}

            $_args .= " $k=\"$v\"";
        }

        return $_args;
    }

    /**
     *
     */
    private function makeNav()
    {
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
    /**
     * @param $body
     */
    protected final function output($body)
    {
        $this->renderHeadingPanel();
        $this->response->body($body)->render();

//        $this->request->mode = "engine";
//        return $this->load->view('content',array(
//            'title_block' => $this->load->view('title_block',array(
//                'title'       => $this->request->name,
//                'icon'       => $this->request->icon,
//                'description' => $this->request->description,
//                'buttons'     => $this->buttons
//            )),
//            'user_menu'   => $this->load->view('user_menu'),
//            'breadcrumb'  => $this->breadcrumb($this->request->namespace . $this->request->controller),
//            'sidebar'     => $this->sidebar,
//            'content'     => $this->content,
//            'js_file'     => $this->getJs()
//        ));
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
