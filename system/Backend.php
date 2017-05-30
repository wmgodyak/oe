<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\components\admin\controllers\Admin;
use system\core\Components;
use system\core\Config;
use system\core\Controller;
use system\core\EventsHandler;
use system\core\Lang;
use system\core\Languages;
use system\core\Session;
use system\core\Template;
use system\models\App;
use system\models\Images;
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

    protected $settings;

    protected $images;

    protected $template;

    private $panel_nav = [];

    private static $initialized = false;

    protected $languages;

    protected $admin;

    public function __construct()
    {
        parent::__construct();

        $this->languages = Languages::getInstance();

        $this->images = new Images();

        // settings
        $this->settings = Settings::getInstance();

        // template settings
        $theme = $this->settings->get('backend_theme');
        $this->template = Template::getInstance($theme);

        $this->template->assign('base_url',   APPURL . $this->settings->get('backend_url') ."/");
        $this->template->assign('settings',   $this->settings);

        $this->validateToken();

        if(!self::$initialized){
             $this->_init();
        }

        $this->admin = Admin::data();
    }

    public function init(){}

    private function _init()
    {
        self::$initialized = true;

        $action      = $this->request->param('action');

        $controller = $this->request->param('controller');
        $controller = lcfirst($controller);

        if(
        (
        ! \system\components\admin\models\Admin::isOnline(Admin::id(), Session::id())
        )
        ){
            if( $controller != 'admin' && $action != 'login' ){
                $this->redirect("/{$this->settings->get('backend_url')}/admin/login");
            }
        }

        Permissions::set(Admin::data('permissions'));

        if( ($controller != 'admin' && $action != 'login') && $controller != 'module' ) {
            if (!Permissions::canComponent($controller, $action)) {
                Permissions::denied();
            }
        }

        $theme = $this->settings->get('backend_theme');
        $lang = Session::get('backend_lang');

        Lang::getInstance()->set($lang, $theme);

        Components::init();

        $events = EventsHandler::getInstance();

        $app = App::getInstance();
        $this->template->assign('app', $app);


        Modules::getInstance()->init('backend', $lang);
        $events->call('backend.init');

        // assign events
        $this->template->assign('events', $events);

        $this->template->assign('languages',  $this->languages->languages);
        $this->template->assign('t', t()->get()); // todo remove it in future

        $this->template->assign('admin', Admin::data());
    }

    /**
     * @param $name
     * @param null $url
     */
    protected function addBreadCrumb($name, $url = null)
    {
        $items = $this->template->getVars('breadcrumb');
        $items = array_merge((array) $items, [['name' => $name, 'url' => $url]]);
        $this->template->assign('breadcrumb', $items);
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
     * @deprecated use function t()
     * translations
     * @param $key
     * @return string
     */
    protected function t($key)
    {
        return t($key);
    }

    protected function setContent($c)
    {
        $this->content = $c;
    }

    private final function renderHeadingPanel()
    {
        $this->template->assign('panel_nav', $this->panel_nav);
        $this->template->assign('heading_panel', $this->template->fetch('chunks/heading_panel'));
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
        $s = $this->template->fetch('chunks/nav');
        $this->template->assign('nav', $s);
    }

    /**
     * @param $body
     */
    protected final function output($body)
    {
        $version = Config::getInstance()->get('core.version');
        $this->template->assign('version',    $version);

        $controller = $this->request->param('controller');
        $controller = lcfirst($controller);

        $action = $this->request->param('action');

        $this->addBreadCrumb(t($controller . '.action_index'), $controller);
        $items = $this->template->getVars('breadcrumb');
        rsort($items);
        $this->template->assign('breadcrumb', $items);

        $this->makeNav();
        $this->template->assign('title', t($controller . '.action_' . $action));
        $this->template->assign('name',  t($controller . '.action_' . $action));

        $this->renderHeadingPanel();

        $this->template->assign('body', $body);

        $scripts = $this->template->getScripts();
        $this->template->assign('components_scripts', $scripts);

        $styles = $this->template->getStyles();
        $this->template->assign('components_styles', $styles);

        $this->template->display('index');
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
