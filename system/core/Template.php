<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 18.01.15 15:59
 */

namespace system\core;

use system\core\exceptions\Exception;
use system\models\Settings;

defined("CPATH") or die();

require_once DOCROOT. "vendor/smarty/smarty/libs/Autoloader.php";

/**
 * Class Template
 * @package controllers\core
 */
class Template
{
    private static $instance;
    public $theme;
    public $theme_url;
    public $theme_path;
    private $smarty;

    /**
     * list of attached scripts
     * @var array
     */
    private $scripts = [];
    /**
     * list of attached styles
     * @var array
     */
    private $styles  = [];

    private function __construct($theme)
    {
        if(!$theme) throw new \Exception('Wrong theme path');

        $this->theme = $theme;

        // load config
        $config = Config::getInstance()->get('smarty');
//        $settings = Settings::getInstance()->get();

        // init smarty
        $this->smarty = new \Smarty();
        $this->smarty->compile_check = $config['compile_check'];
        $this->smarty->caching = $config['caching'];
        $this->smarty->cache_lifetime = $config['cache_lifetime'];
        $this->smarty->debugging = $config['debugging'];
        $this->smarty->muteExpectedErrors();
        $this->smarty->error_reporting = E_ALL & ~E_NOTICE;

        // get theme
        $theme = "themes/{$theme}/";

        $this->smarty->setCompileDir(DOCROOT . '/tmp/' . $theme . '/');
        $this->smarty->setTemplateDir(DOCROOT . $theme. '/');

        if(!is_dir($this->smarty->getCompileDir()))
            mkdir($this->smarty->getCompileDir(), 0777, true);

        $this->smarty->setCacheDir(DOCROOT . '/tmp/cache/');

        // custom vars
        $theme_path = $theme;
        
        if(is_dir($theme_path)) {

            $theme_url = APPURL . $theme ;
            $this->smarty->assign('theme_url', $theme_url);
            $this->smarty->assign('base_url', APPURL);
            $this->smarty->assign('appurl',   APPURL);
            $this->smarty->assign('token',    TOKEN);

            $this->theme_url = $theme_url;
            $this->theme_path = $theme_path;
            
        } else {
            echo self::fatalErrorTemplateContent(array(
                'description' => 'No topic is set by default. Please go to content management system and activate the current theme. Or check the current theme folder in the system',
                'code' => 'Not found theme - '. $theme_path
            ));
            die();

        }
    }

    /**
     * @param $theme
     * @return Template
     */
    public static function getInstance($theme = null)
    {
        static $last_theme;
        if($theme) $last_theme = $theme;

        if(!isset(self::$instance[$last_theme]) || self::$instance[$last_theme] == null){
            self::$instance[$last_theme] = new self($theme);
        }

        return self::$instance[$last_theme];
    }

    public function getThemeUrl()
    {
        return $this->theme_url;
    }
    
    public function getThemePath()
    {
        return $this->theme_path;
    }
    /**
     * @param $tpl_var
     * @param null $value
     * @param bool $nocache
     * @return $this
     */
    public function assign($tpl_var, $value = null, $nocache = false)
    {
        $this->smarty->assign($tpl_var, $value, $nocache);

        return $this;
    }

    /**
     * @param null $varname
     * @param null $_ptr
     * @param bool $search_parents
     * @return string
     */
    public function getVars($varname = null, $_ptr = null, $search_parents = true)
    {
        return $this->smarty->getTemplateVars($varname, $_ptr, $search_parents);
    }

    /**
     * @param $varname
     * @param $value
     * @return $this
     * @throws Exception
     */
    public function assignToVar($varname, $name, $value)
    {
        $var = $this->getVars($varname);
        if(! $var) {
            throw new Exception("Variable $varname not found!");
        }
        $var[$name] = $value;
        $this->assign($varname, $var);
        return $this;
    }

    /**
     * @param null $template
     * @param null $cache_id
     * @param null $compile_id
     * @param null $parent
     * @return string
     */
    public function fetch($template = null, $cache_id = null, $compile_id = null, $parent = null)
    {

        if(!empty($template) && strpos($template, '.tpl') === false){
            $template .= '.tpl';
        }

        return $this->smarty->fetch($template, $cache_id, $compile_id, $parent);
    }

    /**
     * @param null $string
     * @param null $cache_id
     * @param null $compile_id
     * @param null $parent
     * @return string
     */
    public function fetchString($string = null, $cache_id = null, $compile_id = null, $parent = null)
    {
        return $this->smarty->fetch('string:' . $string, $cache_id, $compile_id, $parent);
    }


    /**
     * displays a Smarty template
     *
     * @param string $template   the resource handle of the template file or template object
     * @param mixed  $cache_id   cache id to be used with this template
     * @param mixed  $compile_id compile id to be used with this template
     * @param object $parent     next higher level of Smarty variables
     */
    public function display($template = null, $cache_id = null, $compile_id = null, $parent = null)
    {

        if(!empty($template) && strpos($template, '.tpl') === false){
            $template .= '.tpl';
        }

        $this->smarty->display($template, $cache_id, $compile_id, $parent);
        die;
    }

    /**
     * test if cache is valid
     *
     * @api  Smarty::isCached()
     * @link http://www.smarty.net/docs/en/api.is.cached.tpl
     *
     * @param  null|string|\Smarty_Internal_Template $template   the resource handle of the template file or template object
     * @param  mixed                                 $cache_id   cache id to be used with this template
     * @param  mixed                                 $compile_id compile id to be used with this template
     * @param  object                                $parent     next higher level of Smarty variables
     *
     * @return boolean       cache status
     */
    public function isCached($template = null, $cache_id = null, $compile_id = null, $parent = null)
    {
        return $this->smarty->isCached($template, $cache_id, $compile_id, $parent);
    }



    /**
     * @param $src
     * @param null $priority
     * @return $this
     * @throws Exception
     */
    public function assignStyle($src, $priority = null)
    {
        if(! $priority) {
            $priority = count($this->styles);
            $priority ++;
        }

        if( $priority && isset($this->styles[$priority]) ){
            throw new Exception("In this position assigned {$this->styles[$priority]}. Change priority.");
        }

        $this->styles[$priority] = $src;

        return $this;
    }

    /**
     * @param $src
     * @param null $priority
     * @return $this
     * @throws Exception
     */
    public function assignScript($src, $priority = null)
    {
        $src = '/'. str_replace(['controllers/', DOCROOT],[], $src);
        if(! $priority) {
            $priority = count($this->scripts);
            $priority ++;
        }

        if( $priority && isset($this->scripts[$priority]) ){
            throw new Exception("In this position assigned {$this->scripts[$priority]}. Change priority.");
        }

        $this->scripts[$priority] = $src;

        return $this;
    }

    /**
     * @return array
     */
    public function getStyles()
    {
        return $this->styles;
    }

    /**
     * @return array
     */
    public function getScripts()
    {
        return $this->scripts;
    }

    public static function fatalErrorTemplateContent($array)
    {
        return '<!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Template error</title>
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
            .description{padding-bottom: 20px}
        </style>
        </head>
        <body id="error-page">
            <h2>Template error!</h2>
            <div class="description">'.$array['description'].'</div>
            <div class="code-wrapper">
            <code>'.$array['code'].'</code>
            </div>
        </body>
        </html>';
    }
} 