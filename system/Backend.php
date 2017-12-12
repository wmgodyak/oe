<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\components\auth\controllers\Auth;
use system\core\Components;
use system\core\Config;
use system\core\Controller;
use system\core\Lang;
use system\core\Languages;
use system\core\Session;
use system\core\Template;
use system\core\Validator;
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

    protected $languages;

    protected $admin;

    protected $validator;

    public function __construct()
    {
        parent::__construct();

        $this->languages = Languages::getInstance();

        // settings
        $this->settings = Settings::getInstance();

        // template settings
        $theme = $this->settings->get('backend_theme');
        $this->template = Template::getInstance($theme);


        if(! $this->validator){
            $this->validator = new Validator(t('validator'));
        }

        $this->admin = Auth::data();
    }

    public function init(){}

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

        $this->template->assign('languages',  $this->languages->languages);
        $this->template->assign('admin', Auth::data());

        $this->template->assign('version',    self::VERSION);

        $module = $this->request->module;
        $controller = $this->request->controller;
        $controller = lcfirst($controller);
        $action = $this->request->action;

        $url = $this->settings->get('backend');

        if(!empty($module)){
            $url .= "module/run/";
        }

        $url .= "$controller";


        $this->addBreadCrumb(t($controller . '.action_index'), $url);
        $items = $this->template->getVars('breadcrumb');
        rsort($items);
        $this->template->assign('breadcrumb', $items);

        $this->makeNav();
        $this->template->assign('title', t($controller . '.action_' . $action));
        $this->template->assign('name',  t($controller . '.action_' . $action));

        $this->renderHeadingPanel();

        $this->template->assign('body', $body);
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
