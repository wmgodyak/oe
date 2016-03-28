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
use controllers\core\exceptions\Exception;
use controllers\core\Request;
use controllers\core\Response;
use controllers\core\Session;
use controllers\core\Settings;
use controllers\core\Template;
use controllers\engine\Plugins;
use models\app\Content;
use models\app\Images;
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

        $this->page = $this->template->getVars('page');
        $this->languages_id = $this->page['languages_id'];
    }

    private function runModule($controller, $action, $params)
    {
        $namespace = '\controllers\modules\\';
        $c  = $namespace . $controller;
        $path = str_replace("\\", "/", $c);

        if(! file_exists(DOCROOT . $path . ucfirst($controller) . '.php')) {
            throw new \FileNotFoundException("Модуль {$controller} не знайдено.");
        }

        $controller = new $c;

        if(!is_callable(array($controller, $action))){
            die('Action '. $action .'is not callable: ' . DOCROOT . $path . '.php');
        }

        Event::fire($c, 'before'.ucfirst($action), $params);

        if(!empty($params)){
            call_user_func_array(array($controller, 'before'), $params);
            call_user_func_array(array($controller, $action), $params);
        } else{
            call_user_func(array($controller, 'before'));
            call_user_func(array($controller, $action));
        }

        Event::fire($c, 'after' . ucfirst($action), $params);
    }

    private function init()
    {
//        echo "App::init()\r\n";
        self::$initialized = true;

        $this->template->assign('base_url',    APPURL );

        if($this->request->isXhr()){
            $this->languages_id = isset($_SERVER['HTTP_X_LANGUAGES_ID']) ? (int)$_SERVER['HTTP_X_LANGUAGES_ID'] : null;

            // init page
            $args = $this->request->param();
            $app = new \models\App($args);
        } else {
            if($this->settings['active'] == 0){
                $a = Session::get('engine.admin');
                if( ! $a) {
                    $this->eTechnicalWorks();
                }
            }

            // init page
            $args = $this->request->param();
            $app = new \models\App($args);
            $page = $app->getPage();

            Request::getInstance()->param('page', $page);

            if(! $page){
                $this->e404();
            }

            if($page['status'] != 'published'){
                $a = Session::get('engine.admin');
                if( ! $a){
                    $this->e404();
                }
            }

            $this->languages_id = $page['languages_id'];
            Request::getInstance()->param('languages_id', $this->languages_id);

            //assign page to template
            $this->template->assign('page', $page);

            if(!empty($page['settings']['modules'])){
                foreach ($page['settings']['modules'] as $k=>$module) {
                    $app->callModule($module);
                }
            }
        }

        // assign translations to template
        $this->template->assign('t', $this->t());

        $template_path = $this->settings['themes_path']
            . $this->settings['app_theme_current'] .'/'
            . $this->settings['app_views_path']
            . 'layouts/';

        $ds = $this->template->fetch($template_path . $page['template']);

        $this->response->body($ds);

        if($page['id'] == $this->settings['page_404']){
            $this->response->sendError(404);
        }
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

    public function index(){}
}
