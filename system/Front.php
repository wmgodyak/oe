<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\core\Lang;
use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Template;
use system\models\App;
use system\models\Content;
use system\models\Images;
use system\models\Languages;
use system\models\Modules;
use system\models\Settings;

if ( !defined("CPATH") ) die();

/**
 * Class App
 * @package controllers
 */
class Front extends core\Controller
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
    protected $languages_code;

    protected $page;
    private $theme;

    public function __construct()
    {
        parent::__construct();

        $this->request = Request::getInstance();
        $this->request->setMode('frontend');

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['app_theme_current'];
        $this->theme= $theme;
        $this->template = Template::getInstance($theme);

        if(!self::$initialized){
            $this->initialize();
        }

        $this->images   = new Images();

        $this->languages_id   = Session::get('app.languages_id');

        $this->languages_code = Session::get('app.languages_code');


        // to access custom modules
        $this->page = $this->template->getVars('page');


        $events = EventsHandler::getInstance();

        $this->template->assign('events', $events);
        $this->template->assign('settings', $this->settings);
    }

    public function index()
    {
//        echo "App::init()\r\n"; $this->dump($_SESSION);
        self::$initialized = true;

        $this->template->assign('base_url',    APPURL );

        // init page
//        $args = $this->request->param();

        if(
            $this->request->isXhr()
            // || (isset($args['controller']) && $args['namespace'] != 'controllers\App' && $args['controller'] != 'App')
        ){
            echo 'Configure XHR or move it to model front ';
//            if( ! $this->languages_id){
//                $l = new Languages();
//                $lang = $l->getDefault();
//                $this->languages_id   = $lang['id'];
//                $this->languages_code = $lang['code'];
//
//                $a = [];
//                $a['app']['languages_id']   = $this->languages_id;
//                $a['app']['languages_code'] = $this->languages_code;
//
//                Session::set($a, $this->languages_id);
//            }
//
//            Request::getInstance()->param('languages_id', $this->languages_id);
//            Request::getInstance()->param('languages_code', $this->languages_code);
//
//            // assign translations to template
//            $this->template->assign('t', $this->t());
        } else {

            if($this->settings['active'] == 0){
                $a = Session::get('engine.admin');
                if( ! $a) {
                    $this->technicalWorks();
                }
            }

            // завантаження сторінки
            $app  = new \system\models\Front(true);

            $page = $app->getPage();

            if (!$page) {
                $this->e404();
            }

            $page['content'] = $this->template->fetchString($page['content']);

            Request::getInstance()->param('page', $page);

            if ($page['status'] != 'published') {
                $a = Session::get('engine.admin');
                if (!$a) {
                    $this->e404();
                }
            }

            $this->languages_id   = $page['languages_id'];
            $this->languages_code = $page['languages_code'];
            $a = [];
            $a['app']['languages_id']   = $this->languages_id;
            $a['app']['languages_code'] = $this->languages_code;

            Session::set($a, $this->languages_id);
            Request::getInstance()->param('languages_id', $this->languages_id);
            Request::getInstance()->param('languages_code', $this->languages_code);

            //assign page to template
            $this->template->assign('page', $page);

            // load default translations
//            Lang::getInstance($this->settings['app_theme_current'], $this->languages_code);

            // init modules
            $m = new Modules($this->theme, $this->languages_code);
            $modules = $m->init();

            // assign translations to template
            $this->template->assign('t', $this->t());

            // assign app
            $app = new App();
//                echo '<pre>'; var_dump($app->languages->get());die;
            $this->template->assign('app', $app);
            $this->template->assign('mod', $modules);

            $this->template->assign('settings', $this->settings);

            $this->template->assign('modules_scripts', $this->template->getScripts());

            $template_path = $this->settings['themes_path']
                . $this->settings['app_theme_current'] . '/'
                . 'layouts/';

            $ds = $this->template->fetch($template_path . $page['template']);

            $this->response->body($ds);

            if ($page['id'] == $this->settings['page_404']) {
                $this->response->sendError(404);
            }
        }
    }

    private function initialize()
    {
        $app = Session::get('app');

        if(isset($app['languages_id'])) return;

        $l = new Languages();
        $lang = $l->getDefault();
        $this->languages_id   = $lang['id'];
        $this->languages_code = $lang['code'];

        $a = [];
        $a['app']['languages_id']   = $this->languages_id;
        $a['app']['languages_code'] = $this->languages_code;

        Session::set($a);
    }

    protected function getUrl($id)
    {
        $f = new \system\models\Front();
        return $f->getUrlById($id);
    }

    public function e404()
    {
        $id = $this->settings['page_404'];

        if(empty($id)){
            throw new Exception("Неможливо здійснити перенаправлення на 404 сторінку. Введіть ід сторінки в налаштуваннях");
        }

        $f = new \system\models\Front();

        $url = $f->getUrlById($id);

        $this->redirect( $url, 404);
    }

    private function technicalWorks()
    {
        $template_path = $this->settings['themes_path']
            . $this->settings['app_theme_current'] .'/'
            . $this->settings['app_views_path'];

        $ds = $this->template->fetch($template_path . 'technical_works');

        $this->response->body($ds);
    }

    /**
     * get translation by key
     * @param $key
     * @return string
     */
    protected function t($key=null)
    {
        return Lang::getInstance($this->settings['app_theme_current'], $this->languages_code)->t($key);
    }

    public function init(){}
}