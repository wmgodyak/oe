<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Template;
use system\models\ContentImages;
use system\models\Languages;
use system\models\Settings;

if ( !defined("CPATH") ) die();

/**
 * Class App
 * @package controllers
 */
class App extends core\Controller
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

    public function __construct()
    {
        // todo апп має бути проміжним, а може й ні, просто прописати роут на нього і все

       /* parent::__construct();

        $this->request = Request::getInstance();

        // response
        $this->response = Response::getInstance();

        // settings
        $this->settings = Settings::getInstance()->get();

        // template settings
        $theme = $this->settings['app_theme_current'];
        $this->template = Template::getInstance($theme);

        $this->images   = new ContentImages();

        $this->languages_id   = Session::get('app.languages_id');
        $this->languages_code = Session::get('app.languages_code');

        if(!self::$initialized){
            $this->_init();
        }

        // to access custom modules
        $this->page = $this->template->getVars('page');

        $this->template->assign('user', Session::get('user'));*/
    }

    private function _init()
    {
//        echo "App::init()\r\n"; $this->dump($_SESSION);
        self::$initialized = true;

        $this->template->assign('base_url',    APPURL );

        // init page
        $args = $this->request->param();
        $this->dump($args);
        if(
            $this->request->isXhr() ||
            (isset($args['controller']) && $args['namespace'] != 'controllers\App' && $args['controller'] != 'App')
        ){
            if( ! $this->languages_id){
                $l = new Languages();
                $lang = $l->getDefault();
                $this->languages_id   = $lang['id'];
                $this->languages_code = $lang['code'];

                $a = [];
                $a['app']['languages_id']   = $this->languages_id;
                $a['app']['languages_code'] = $this->languages_code;

                Session::set($a, $this->languages_id);
            }

            $app = new \models\App(null, $this->languages_id);
            Request::getInstance()->param('languages_id', $this->languages_id);
            Request::getInstance()->param('languages_code', $this->languages_code);

            // assign translations to template
            $this->template->assign('t', $this->t());
        } else {

            if($this->settings['active'] == 0){
                $a = Session::get('engine.admin');
                if( ! $a) {
                    $this->eTechnicalWorks();
                }
            }

                // завантаження сторінки
                $app  = new \models\App($args);
                $page = $app->getPage();

                Request::getInstance()->param('page', $page);

                if (!$page) {
                    $this->e404();
                }

                if ($page['status'] != 'published') {
                    $a = Session::get('engine.admin');
                    if (!$a) {
                        $this->e404();
                    }
                }

                $this->languages_id = $page['languages_id'];
                $this->languages_code = $page['languages_code'];
                $a = [];
                $a['app']['languages_id'] = $this->languages_id;
                $a['app']['languages_code'] = $this->languages_code;
                Session::set($a, $this->languages_id);
                Request::getInstance()->param('languages_id', $this->languages_id);
                Request::getInstance()->param('languages_code', $this->languages_code);
                //assign page to template
                $this->template->assign('page', $page);

                if (!empty($page['settings']['modules'])) {
                    foreach ($page['settings']['modules'] as $k => $module) {
                        $app->callModule($module);
                    }
                }

                // assign translations to template
                $this->template->assign('t', $this->t());

                $template_path = $this->settings['themes_path']
                    . $this->settings['app_theme_current'] . '/'
                    . $this->settings['app_views_path']
                    . 'layouts/';

                $ds = $this->template->fetch($template_path . $page['template']);

                $this->response->body($ds);

                if ($page['id'] == $this->settings['page_404']) {
                    $this->response->sendError(404);
                }
        }
    }

    protected function getUrl($id)
    {
        $content = new Content();
        return $content->getUrlById($id);
    }

    public function e404()
    {
        $id = $this->settings['page_404'];
        if(empty($id)){
            throw new Exception("Неможливо здійснити перенаправлення на 404 сторінку. Введіть ід сторінки в налаштуваннях");
        }

        $content = new Content();

        $url = $content->getUrlById($id);

        $this->redirect( $url, 404);
    }

    private function eTechnicalWorks()
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
        return Lang::getInstance($this->languages_code)->get($key);
    }

    public function init(){}
    public function index(){}
}