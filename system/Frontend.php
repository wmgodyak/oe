<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\exceptions\Exception;
use system\core\Session;
use system\core\Validator;
use system\models\Images;
use system\models\Languages;
use system\models\Settings;
use system\core\Template;
use system\models\App;


if ( !defined("CPATH") ) die();

/**
 * Class App
 * @package controllers
 */
abstract class Frontend extends core\Controller
{
    /**
     * Settings instance
     * @var Settings
     */
    protected $settings;

    /**
     * Template instance
     * @var
     */
    protected $template;
    /**
     * @var models\Frontend
     */
    protected $frontend;
    /**
     * @var Languages
     */
    protected $languages;

    /**
     * @var Images
     */
    protected $images;
    /**
     * @var App
     */
    protected $app;

    /**
     * Current page info
     * @var array
     */
    public $page = [];

    protected $validator;

    public function __construct()
    {
        parent::__construct();

        $this->settings = Settings::getInstance();

        $this->languages = \system\core\Languages::getInstance();

        $this->app = App::getInstance();

        if( ! $this->template ){
            $theme = $this->settings->get('app_theme_current');
            $this->template = Template::getInstance($theme);
//            \system\core\Lang::getInstance()->set($this->languages->code, $this->template->theme);
        }

        if(! $this->validator){
            $tt = t('validator');
            $this->validator = new Validator(is_string($tt) ? [] : $tt);
        }
    }

    protected function display($page)
    {
        if (!$page) {
            return $this->e404();
        }

        if($this->settings->get('active') == 0) {
            $a = Session::get('backend.admin');
            if( ! $a) {
                technicalWorks();
            }
        }

        $this->request->page = $page;

        if (isset($page['status']) && $page['status'] != 'published') {
            $a = Session::get('engine.admin');
            if (!$a) {
                return $this->e404();
            }
        }

        //assign page to template
        $this->template->assign('page', $page);
        $this->page = $page;

        events()->call('init', ['page' => $page]);

        // fetch template
        $template_path = $this->settings->get('themes_path')
            . $this->settings->get('app_theme_current') . '/'
            . 'layouts/';

        return $this->template->fetch($template_path . $page['template']);
    }



    /**
     * @return mixed
     * @throws Exception
     */
    public function e404()
    {
        $this->response->withCode(404);
        if($this->request->isGet()){
            return $this->template->fetch('layouts/404');
        }
    }

    /**
     * get translation by key
     * @deprecated use global function t()
     * @param $key
     * @return string
     */
    protected function t($key=null)
    {
        return "This method is deprecated. Use helper t($key).";
    }

    public function index(){}
}