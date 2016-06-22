<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\exceptions\Exception;
use system\core\Lang;
use system\core\Request;
use system\core\Response;
use system\core\Session;
use system\core\Template;
use system\models\App;
use system\models\Content;
use system\models\ContentImages;
use system\models\Languages;
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

    private $modules_dir = "modules";

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
        $this->template = Template::getInstance($theme);

        if(!self::$initialized){
//            $this->_init();
        }

        $this->images   = new ContentImages();

        $this->languages_id   = Session::get('app.languages_id');
        $this->languages_code = Session::get('app.languages_code');


        // to access custom modules
        $this->page = $this->template->getVars('page');
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
            /*if( ! $this->languages_id){
                $l = new Languages();
                $lang = $l->getDefault();
                $this->languages_id   = $lang['id'];
                $this->languages_code = $lang['code'];

                $a = [];
                $a['app']['languages_id']   = $this->languages_id;
                $a['app']['languages_code'] = $this->languages_code;

                Session::set($a, $this->languages_id);
            }

            new \models\App(null, $this->languages_id);
            Request::getInstance()->param('languages_id', $this->languages_id);
            Request::getInstance()->param('languages_code', $this->languages_code);

            // assign translations to template
            $this->template->assign('t', $this->t());
            */
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

            // assign translations to template
            $this->template->assign('t', $this->t());

            // init modules
            $this->initModules();


            // assign app
            $app = new App();
//                echo '<pre>'; var_dump($app->languages->get());die;
            $this->template->assign('app', $app);

            $this->template->assign('settings', $this->settings);

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

    /**
     * @throws Exception
     */
    private function initModules()
    {
        if ($handle = opendir(DOCROOT . $this->modules_dir)) {
            while (false !== ($module = readdir($handle))) {
                if ($module == "." || $module == "..")  continue;

                $c  = $this->modules_dir .'\\'. $module . '\controllers\\' . ucfirst($module);

                $path = str_replace("\\", "/", $c);

                if(!file_exists(DOCROOT . $path . '.php')) {
                    throw new Exception("Module $module issue.");
                }

                $this->assignModuleLang($module);
                $controller = new $c;
                call_user_func(array($controller, 'init'));
            }
            closedir($handle);
        }
    }

    private function assignModuleLang($module)
    {
        $dir =  $this->modules_dir .'/'. $module . '/lang/';
        if ($handle = opendir(DOCROOT . $dir)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != "..") {
                    $path = $dir . $entry . '/';
//                    die($path);
                    Lang::getInstance()->setTranslations($path);
                }
            }
            closedir($handle);
        }
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