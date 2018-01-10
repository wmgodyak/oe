<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\backend\Breadcrumbs;
use system\backend\ButtonsPanel;
use system\backend\Menu;
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
    protected $settings;

    protected $images;

    protected $template;

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
     * @deprecated
     * @param $name
     * @param null $url
     */
    protected function addBreadCrumb($name, $url = null)
    {
        Breadcrumbs::add($name, $url);
    }

    /**
     * @deprecated
     * @param $button
     * @return $this
     */
    protected final function prependToPanel($button)
    {
        ButtonsPanel::prepend($button);

        return $this;
    }

    /**
     * @deprecated
     * @param $button
     * @return $this
     */
    protected final function appendToPanel($button)
    {
        ButtonsPanel::add($button);

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

    /**
     * @param $name
     * @param $url
     * @param $icon
     * @param $parent
     * @param $position
     */
    protected function assignToNav($name, $url, $icon = null, $parent = null, $position = 0)
    {
        Menu::add($name, $url, $icon, $parent, $position);
    }

    /**
     * @param $body
     */
    protected final function output($body)
    {
        $this->template->assign('version',    self::VERSION);
        $this->template->assign('admin', Auth::data());

        $module = $this->request->module;
        $controller = $this->request->controller;
        $controller = lcfirst($controller);
        $action = $this->request->action;

        $url = $this->settings->get('backend');

        if(!empty($module)){
            $url .= "module/run/";
        }

        $url .= "$controller";

        if (Breadcrumbs::$default) {
            Breadcrumbs::prepend(t($controller . '.action_index'), $url);
        }
        $this->template->assign('breadcrumb', Breadcrumbs::get());

        $this->template->assign('nav_items', Menu::get());

        $s = $this->template->fetch('chunks/nav');
        $this->template->assign('nav', $s);

        $this->template->assign('title', t($controller . '.action_' . $action));
        $this->template->assign('name',  t($controller . '.action_' . $action));


        $this->template->assign('panel_nav', ButtonsPanel::get());
        $this->template->assign('heading_panel', $this->template->fetch('chunks/heading_panel'));

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
