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
use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\core\Lang;
use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Template;
use system\models\ContentImages;
use system\models\Languages;
use system\models\Permissions;
use system\models\Settings;

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

        $this->images = new ContentImages();

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
                ! \system\components\admin\models\Admin::isOnline(Admin::id(), Session::id())
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

            $this->_init();

            $controller = $this->request->param('controller');
            $controller = lcfirst($controller);

            $this->makeCrumbs($this->t($controller . '.action_index'), $controller);
        }

        $this->admin = Admin::data();
    }

    public function init(){}

    private function getLang()
    {
        if(! isset($_COOKIE["$this->theme.lang"])){
            $lang = Config::getInstance()->get('core.lang');
            $_COOKIE["$this->theme.lang"] = $lang;
        } else {
            $lang = $_COOKIE["$this->theme.lang"];
        }

        return $lang;
    }

    private function _init()
    {
        self::$initialized = true;

        $controller = $this->request->param('controller');
        $action     = $this->request->param('action');
        $controller = lcfirst($controller);

        $lang = $this->getLang();

        $this->template->assign('version',    $this->version);
        $this->template->assign('base_url',   APPURL . 'engine/');
        $this->template->assign('controller', $controller);
        $this->template->assign('action',     $action);

        $this->initSystemComponents();
        $this->initModules();
        // assign events
        $events = EventsHandler::getInstance();

        $this->template->assign('events', $events);

//        $this->dump(Lang::getInstance($this->theme, $lang)->t());die;
        $this->template->assign('t', Lang::getInstance($this->theme, $lang)->t());

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

    private function permissionDenied()
    {
        $this->response->sendError(401);
        if($this->request->isXhr()){
            die;
        }
        echo $this->template->fetch('permission_denied'); die;
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
        /*if($parent != null){
            foreach (self::$menu_nav as $k=>$item) {
                if($item['url'] == $parent){

                    if(!isset(self::$menu_nav[$k]['items'])) self::$menu_nav[$k]['items'] = [];

                    while(isset(self::$menu_nav[$k]['items'][$position])){
                        $position += 5;
                    }
                    self::$menu_nav[$k]['isfolder'] = 1;
                    self::$menu_nav[$k]['items'][$position] = [
                        'name'     => $name,
                        'url'      => $url,
                        'icon'     => $icon,
                        'parent'   => $parent,
                        'isfolder' => 0
                    ];
                    return ;
                }
            }

//            throw new Exception("Wrong parent url.");
        }*/

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
            $nav[] = $item;
        }

        foreach ($ws_parents as $item) {
            foreach ($nav as $k=>$n) {
                if($n['url'] == $item['parent']){
                    $nav[$k]['isfolder'] = 1;
                    $nav[$k]['items'][] = $item;
                }
            }
        }



//        ksort(self::$menu_nav);
//        d(self::$menu_nav);die;
        $this->template->assign('nav_items', $nav);
        $s = $this->template->fetch('nav');
        $this->template->assign('nav', $s);
    }

    private function initModules()
    {
        $modules_dir = 'modules';
        $modules = new \stdClass();
        if ($handle = opendir(DOCROOT . $modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == "..")  continue;

                $c  = $modules_dir .'\\'. $module . '\controllers\admin\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {

                    $this->assignModuleLang($module);
                    $controller = new $c;
                    $modules->{$module} = $controller;

                    call_user_func(array($controller, 'init'));
                }

            }
            closedir($handle);
        }

        return $modules;
    }

    private function initSystemComponents()
    {
        $ns = 'system\components';
        $root = str_replace('\\','/', $ns);

        $components = new \stdClass();
        if ($handle = opendir(DOCROOT . $root)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == ".." || $module == 'content')  continue;

                $c  = $ns .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(file_exists(DOCROOT . $path . '.php')) {

//                    $this->assignModuleLang($module);
                    $controller = new $c;
                    $components->{$module} = $controller;

                    call_user_func(array($controller, 'init'));
                }

            }
            closedir($handle);
        }

        return $components;
    }

    private function assignModuleLang($module)
    {
        $modules_dir = 'modules';
        $dir  =  $modules_dir .'/'. $module . '/lang';

        $lang = $this->getLang();

        if(!is_dir(DOCROOT . $dir . '/' . $lang)) {
//            echo('Missing modules lang ' . $dir . '/' . $lang . '<br>');
            return ;
        }

        Lang::getInstance($this->theme, $lang)->setTranslations($dir);
    }

    /**
     * @param $body
     */
    protected final function output($body)
    {
//        $this->dump($this->t('callbacks'));
//        die;
        $this->renderHeadingPanel();
//        return  $body;
        $this->response->body($body)->asHtml(); // todo ???
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
