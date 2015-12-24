<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace controllers;

use controllers\core\Controller;
use controllers\core\Event;
use controllers\core\Request;
use controllers\core\Response;
use controllers\core\Session;
use controllers\core\Settings;
use controllers\core\Template;
use controllers\engine\Admin;

//use controllers\engine\Auth;
//use controllers\engine\Plugins;
//use controllers\core\Languages;
//use models\engine\content\Images;

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

    public function __construct()
    {
        parent::__construct();

        $this->request = Request::instance();

        if(
            (
                $this->request->get('controller') != 'Admin' &&
                $this->request->get('action') != 'login'
            )
            && (
                engine\Admin::id() == null ||
                ! \models\engine\Admin::isOnline(engine\Admin::id(), Session::id())
            )
        ){
            $this->redirect('/engine/admin/login');
        }

        // response
        $this->response = Response::instance();

        // settings
        $this->settings = Settings::instance()->get();

        // шаблонізатор
        $theme = $this->settings['themes_path'] . $this->settings['engine_theme_current'];
        $this->template = Template::instance($theme);

        // авторизуватись
        // що треба визначити
        // мову адмінки

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

    protected function output()
    {
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
