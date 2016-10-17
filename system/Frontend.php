<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\components\install\controllers\Install;
use system\core\Config;
use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\core\Lang;
use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Template;
use system\models\App;
use system\models\Images;
use system\models\Languages;
use system\models\Modules;
use system\models\Settings;

if ( !defined("CPATH") ) die();

/**
 * Class App
 * @package controllers
 */
class Frontend extends core\Controller
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
    private static $initLangs = false;

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

        $config = Config::getInstance();
        if($config->get('db') == null){
            $installer = new Install();
            $installer->index();
            die;
        }

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['app_theme_current'];
        $this->theme= $theme;
        $this->template = Template::getInstance($theme);

        if(!self::$initLangs){
            $this->initLangs();
        }

        $this->images   = new Images();

        $this->languages_id   = Session::get('app.languages_id');

        $this->languages_code = Session::get('app.languages_code');

        // to access custom modules

        $this->page = $this->template->getVars('page');

        $events = EventsHandler::getInstance();

        $this->template->assign('events', $events);
        $this->template->assign('settings', $this->settings);

        if($this->request->param('controller') != '' &&  ! $this->request->param('doInit')){
            $this->doInit();
        }
    }

    public function index()
    {
        $this->template->assign('base_url',    APPURL );

        if(! $this->request->isXhr()){

            if($this->settings['active'] == 0){
                $a = Session::get('backend.admin');
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
                $a = Session::get('backend.admin');
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
            $this->page = $page;

            if(! $this->request->param('doInit')){
                $this->doInit();
            }

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

    private function doInit()
    {
//        echo '<<<< doInit >>>>';
        $this->request->param('doInit', 1);
        // assign translations to template


        // init modules
        $m = new Modules($this->theme, $this->languages_code);
        $modules = $m->init();
        $this->template->assign('mod', $modules);

        $this->template->assign('t', $this->t());

        // assign app
        $app = new App();
        $this->template->assign('app', $app);

        $this->template->assign('languages_id', $this->languages_id);
        $this->template->assign('settings', $this->settings);

        $this->template->assign('modules_scripts', $this->template->getScripts());
    }

    private function initLangs()
    {
        self::$initLangs = true;
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