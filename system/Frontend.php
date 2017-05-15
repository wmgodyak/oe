<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\Config;
use system\core\DataFilter;
use system\core\DB;
use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\core\Lang;
use system\core\Request;
use system\core\Session;
use system\models\Images;
use system\models\Languages;
use system\models\Modules;
use system\models\Parser;
use system\models\Settings;
use system\core\Template;
use system\models\App;

use MatthiasMullie\Minify;

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
     * defined languages id
     * @var array|mixed|null
     */
    protected $languages_id;
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
     * @var string
     */
    public $page = [];

    protected $languages_code;

    private $theme;

    public function __construct()
    {
        parent::__construct();

        $this->request->setMode('frontend');

        $this->settings = Settings::getInstance();

        $frontend = new \system\models\Frontend();

        $this->app = App::getInstance();

        // template settings
        $theme = $this->settings->get('app_theme_current');
        $this->template = Template::getInstance($theme);
        $this->template->assign('app', $this->app);



        $this->languages = $frontend->languages;
        $this->languages_id = $frontend->languages_id;
        $this->images =  $frontend->images;

        // to access custom modules
        $this->page = $this->template->getVars('page');

//        $this->languages_code = $this->frontend->languages->getData($this->languages_id, 'code');

    }

    public function boot(){}

    protected function display($page)
    {
        if (!$page) {
            $page = $this->e404();
        }

        $env = Config::getInstance()->get('core.environment');

        $this->template->assign('base_url',    APPURL );
        $this->template->assign('app', $this->app);

        $events = EventsHandler::getInstance();
        $this->template->assign('events', $events);

        $this->template->assign('settings', $this->settings);

        if($this->settings->get('active') == 0) {
            $a = Session::get('backend.admin');
            if( ! $a) {
                $this->technicalWorks();
            }
        }

        $page['content'] = $this->template->fetchString($page['content']);

        Request::getInstance()->param('page', $page);

        if ($page['status'] != 'published') {
            $a = Session::get('engine.admin');
            if (!$a) {
                $page = $this->e404();
            }
        }

        $this->languages_id   = $page['languages_id'];
        $this->languages_code = $page['languages_code'];

        $_SESSION['app'] = [
            'languages_id'   => $page['languages_id'],
            'languages_code' => $page['languages_code']
        ];

        $this->request->param('languages_id', $page['languages_id']);

        Request::getInstance()->param('languages_id', $this->languages_id);
        Request::getInstance()->param('languages_code', $this->languages_code);

        //assign page to template
        $this->template->assign('page', $page);
        $this->page = $page;

        // init modules
        $m = Modules::getInstance();
        $m->init('frontend', $page['languages_code'], ['page'=>$page]);
        $this->app->module = $m->get();

        $this->template->assign('app', $this->app);
        $this->template->assign('modules_scripts', $this->template->getScripts());

        if ($page['id'] == $this->settings->get('page_404')) {
            $this->response->sendError(404);
        }

        // fetch template
        $template_path = $this->settings->get('themes_path')
            . $this->settings->get('app_theme_current') . '/'
            . 'layouts/';

        $ds = $this->template->fetch($template_path . $page['template']);

        $parser = new Parser($ds);
        $ds = $parser->getDocumentSource();

        $ds = DataFilter::apply('documentSource', $ds);

        $db = DB::getInstance();

        if($env == 'production'){

            $ds = $this->compress($ds);

        } elseif($env == 'debugging' ){

            $db = DB::getInstance();
            $time = $_SERVER['REQUEST_TIME_FLOAT'];
            $q = $db->getQueryCount();

            $ds.= "\r\n<!--\r\n";
            $time_end = microtime(true);
            $exec_time = round($time_end-$time, 4);
            $mu = memory_get_usage();
            $mp = 0; $mpf=0;
            if(function_exists('memory_get_peak_usage')){
                $mp = memory_get_peak_usage();
                $mpf = round(($mp / 1024) / 1024, 3);
            }
            $muf = round((memory_get_usage() / 1024) / 1024, 3);
            $ml=ini_get('memory_limit');

            if($mp > 0){
                $ds.= "    Memory peak in use: $mp ($mpf M)\r\n";
            }

            $ds.= "    Page generation time: ".$exec_time." seconds\r\n";
            $ds.= "    Memory in use: $mu ($muf M) \r\n";
            $ds.= "    Memory limit: $ml \r\n";
            $ds.= "    Total queries: $q \r\n";
            $ds.=  "-->";
        }

        $db->close();
        echo $ds; die;
    }


    /**
     * @param $buffer
     * @return mixed
     */
    private function compress($buffer)
    {
        $compile_force = Config::getInstance()->get('core.assets_compile_force');

        $js_path = "tmp/{$this->template->theme}.min.js";
        $css_path = "tmp/{$this->template->theme}.min.css";

        $css_exists = file_exists(DOCROOT . $css_path);
        $js_exists = file_exists(DOCROOT . $js_path);

        if($compile_force || !$css_exists){

            $css = $this->template->getStyles();
            if(! empty($css)){

                $minifier = new Minify\CSS();

                foreach ($css as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $css_path);
            }
        }

        if( $css_exists ){
            $v = filemtime(DOCROOT . $css_path);
            $css_compiled = "<link href='$css_path?_=$v' rel='stylesheet'>";
            $buffer = str_replace('</head>', "$css_compiled\n</head>", $buffer);
        }


        if($compile_force || !$js_exists){
            $js = $this->template->getScripts();
            if(!empty($js)){

                $minifier = new Minify\JS();

                foreach ($js as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $js_path);

            }
        }

        if($js_exists){
            $v = filemtime(DOCROOT . $js_path);
            $js_compiled  = "<script src='$js_path?_=$v'></script>";
            $buffer = str_replace('</body>', "$js_compiled\n</body>", $buffer);
        }

        // minify html
        $search = array(
            '/\>[^\S ]+/s',  // strip whitespaces after tags, except space
            '/[^\S ]+\</s',  // strip whitespaces before tags, except space
            '/(\s)+/s'       // shorten multiple whitespace sequences
        );
        $replace = array(
            '>',
            '<',
            '\\1'
        );
        return preg_replace($search, $replace, $buffer);
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
        $id = $this->settings->get('page_404');

        if(empty($id)){
            throw new Exception("Неможливо здійснити перенаправлення на 404 сторінку. Введіть ід сторінки в налаштуваннях");
        }

        header("HTTP/1.0 404 Not Found");
        $page = $this->app->page->fullInfo($id);
        $this->display($page);
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