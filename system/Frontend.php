<?php
/**
 * OYiEngine
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 06.05.14 22:34
 */
namespace system;

use system\core\exceptions\Exception;
use system\core\Lang;
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
    public $page;

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
        return $this->app->page->fullInfo($id);
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