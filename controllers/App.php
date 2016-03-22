<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace controllers;

use controllers\core\Controller;
use controllers\core\exceptions\Exception;
use controllers\core\Request;
use controllers\core\Response;
use controllers\core\Session;
use controllers\core\Settings;
use controllers\core\Template;
use controllers\engine\Plugins;
use models\app\Content;
use models\app\Images;
use models\app\Nav;
use models\app\Translations;

if ( !defined("CPATH") ) die();

/**
 * Class App
 * @package controllers
 */
class App extends Controller
{
    /**
     * Request instance
     * @var
     */
    protected $request;
    /**
     * Response instance
     * @var
     */
    protected $response;
    /**
     * Template instance
     * @var
     */
    protected $template;

    /**
     * init status
     * @var bool
     */
    private static $initialized = false;

    /**
     * all system settings
     * @var array
     */
    private $settings;

    protected $images;

    protected $languages_id;

    protected $page;

    public function __construct()
    {
        parent::__construct();

        $this->request = Request::getInstance();

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['app_theme_current'];
        $this->template = Template::getInstance($theme);

        $this->images   = new Images();

        if(!self::$initialized){
            $this->init();
        }
    }

    private function init()
    {
//        echo "App::init()\r\n";
        self::$initialized = true;

        $this->template->assign('base_url',    APPURL );

        if($this->request->isXhr()){
            die("AjaxRequest in development");
        } else {

            if($this->settings['active'] == 0){
                $a = Session::get('engine.admin');
                if( ! $a) {
                    $this->eTechnicalWorks();
                }
            }

            // init page
            $args = $this->request->get('args');

            $app = new \models\App($args);
            $this->page = $app->getPage();

            if(! $this->page){
                $this->e404();
            }

            if($this->page['status'] != 'published'){
                $a = Session::get('engine.admin');
                if( ! $a){
                    $this->e404();
                }
            }

            // set language
            $this->languages_id = $this->page['languages_id'];
            $this->request->setParam('languages_id', $this->languages_id);

            //assign page to template
            $this->template->assign('page', $this->page);

            // для парсера тест
            $nav = new Nav();
            $this->template->assign('nav_top', $nav->get('top'));
        }

        // assign translations to template
        $this->template->assign('t', $this->t());
    }

    public function e404()
    {
        $id = $this->settings['page_404'];
        if(empty($id)){
            throw new Exception("wrong page");
        }

        $content = new Content();

        $url = $content->getUrlById($id);

        $this->redirect( APPURL . $url, 404);
    }

    private function eTechnicalWorks()
    {
        $template_path = $this->settings['themes_path']
            . $this->settings['app_theme_current'] .'/'
            . $this->settings['app_views_path'];

        $ds = $this->template->fetch($template_path . 'technical_works');

        $this->response->body($ds)->asHtml();
    }

    public function before(){}

    /**
     * get translation by key
     * @param $key
     * @return string
     */
    protected function t($key=null)
    {
        return Translations::getInstance($this->languages_id)->get($key);
    }

    /**
     * @return mixed
     */
    public function index()
    {
        $template_path = $this->settings['themes_path']
                       . $this->settings['app_theme_current'] .'/'
                       . $this->settings['app_views_path']
                       . 'content_types/';
        $ds = $this->template->fetch($template_path . $this->page['template']);

        $this->response->body($ds);

        if($this->page['id'] == $this->settings['page_404']){
            $this->response->sendError(404);
        }
    }

    /**
     *
     */
    public function create(){}

    /**
     * @param $id
     * @return mixed
     */
    public function edit($id){}

    /**
     * @param $id
     * @return mixed
     */
    public function process($id){}

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id){}
}
