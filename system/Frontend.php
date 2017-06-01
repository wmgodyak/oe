<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\exceptions\Exception;
use system\core\Request;
use system\core\Session;
use system\models\Images;
use system\models\Languages;
use system\models\Modules;
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

    public function __construct()
    {
        parent::__construct();

        $this->request->setMode('frontend');

        $this->settings = Settings::getInstance();

        $this->languages = \system\core\Languages::getInstance();

        $this->app = App::getInstance();

        if( ! $this->template ){
            $theme = $this->settings->get('app_theme_current');
            $this->template = Template::getInstance($theme);
        }

        // to access custom modules
        $this->page = $this->template->getVars('page');

        if(! $this->request->param('initialized')){

            $this->request->param('initialized', 1);

            $this->template->assign('base_url',    APPURL );
            $this->template->assign('app', $this->app);

            $events = events();

            $events->add('route', function($request){
                $lang = $request->param('lang');
                if($lang != null){
                    $s = $this->languages->setByCode($lang);
                    if(! $s) $this->e404();
                    \system\core\Lang::getInstance()->set($this->languages->code, $this->template->theme);
               }
            });

            $this->template->assign('events', $events);

            $this->template->assign('settings', $this->settings);

            \system\core\Lang::getInstance()->set($this->languages->code, $this->template->theme);
        }
    }

    public function index(){}

    protected function display($page)
    {
        if (!$page) {
            $this->e404();
        }

        if($this->settings->get('active') == 0) {
            $a = Session::get('backend.admin');
            if( ! $a) {
                $this->technicalWorks();
            }
        }

        Request::getInstance()->param('page', $page);

        if (isset($page['status']) && $page['status'] != 'published') {
            $a = Session::get('engine.admin');
            if (!$a) {
                $this->e404();
            }
        }

        $this->languages->set($page['languages_id']);

        //assign page to template
        $this->template->assign('page', $page);
        $this->page = $page;

        // init modules
        $m = Modules::getInstance();
        $this->app->module = $m->get();

        events()->call('init', ['page' => $page]);

        $this->template->assign('app', $this->app);
        $this->template->assign('modules_scripts', $this->template->getScripts());

        // fetch template
        $template_path = $this->settings->get('themes_path')
            . $this->settings->get('app_theme_current') . '/'
            . 'layouts/';

        return $this->template->fetch($template_path . $page['template']);
    }

    /**
     * todo fix it
     */
    private function technicalWorks()
    {
        echo '<!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Technikal works</title>
        <style type="text/css">
                html{background:#f9f9f9}
                body{
                    background:#fff;
                    color:#333;
                    font-family:sans-serif;
                margin:2em auto;
                padding:1em 2em 2em;
                -webkit-border-radius:3px;
                border-radius:3px;
                border:1px solid #dfdfdf;
                max-width:750px;
                text-align:left;
            }
            #error-page{margin-top:50px}
            #error-page h2{border-bottom:1px dotted #ccc;}
            #error-page p{font-size:16px; line-height:1.5; margin:2px 0 15px}
            #error-page .code-wrapper{color:#400; background-color:#f1f2f3; padding:5px; border:1px dashed #ddd}
            #error-page code{font-size:15px; font-family:Consolas,Monaco,monospace;}
            a{color:#21759B; text-decoration:none}
                    a:hover{color:#D54E21}
                        </style>
        </head>
        <body id="error-page">
            <h2>Technical work on the site</h2>
            <div class="code-wrapper">
                <code>Technical work on the site. Please visit page later</code>
            </div>
        </body>
        </html>';
        die();
    }

    /**
     * @return mixed
     * @throws Exception
     */
    protected function e404()
    {
        header("HTTP/1.0 404 Not Found");
        $this->template->display('layouts/404');
    }

    /**
     * get translation by key
     * @deprecated use global function t()
     * @param $key
     * @return string
     */
    protected function t($key=null)
    {
        return "This method is deprecated. Use t($key).";
    }
}