<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 18.01.15 15:59
 */

namespace controllers\core;

defined("CPATH") or die();

require_once DOCROOT. "vendor/smarty/Smarty.class.php";

/**
 * Class Template
 * @package controllers\core
 */
class Template
{
    private static $instance;
    private $settings;
    private $smarty;
    private $theme = null;
    private $theme_url;
    private $theme_path;

    private function __construct($theme)
    {
        if(!$theme) throw new \Exception('Wrong theme path');

        $this->theme = $theme;

        // load config
        $config = Config::getInstance()->get('smarty');
        $this->settings = Settings::getInstance()->get();

        // init smarty
        $this->smarty = new \Smarty();
        $this->smarty->compile_check = $config['compile_check'];
        $this->smarty->caching = $config['caching'];
        $this->smarty->cache_lifetime = $config['cache_lifetime'];
        $this->smarty->debugging = $config['debugging'];

        $this->smarty->error_reporting = E_ALL & ~E_NOTICE;

        // get theme
        $theme = $this->settings['themes_path'] . $theme . '/';

        $this->smarty->setCompileDir(DOCROOT . '/tmp/' . $theme . $this->settings['app_views_path'] .'/');
        $this->smarty->setTemplateDir(DOCROOT . $theme. $this->settings['app_views_path'] .'/');

        if(!is_dir($this->smarty->getCompileDir()))
            mkdir($this->smarty->getCompileDir(), 0777, true);

        $this->smarty->setCacheDir(DOCROOT . '/tmp/cache/');

        // custom vars
        $theme_path = DOCROOT. $theme;
        
        if(is_dir($theme_path)) {

            $theme_url = APPURL . $theme ;
            $this->smarty->assign('theme_url', $theme_url);
            $this->smarty->assign('base_url', APPURL);
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
        if(self::$instance == null){
            self::$instance = new self($theme);
        }

        return self::$instance;
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
     * @param null $template
     * @param null $cache_id
     * @param null $compile_id
     * @param null $parent
     * @param bool $display
     * @param bool $merge_tpl_vars
     * @param bool $no_output_filter
     * @return string
     */
    public function fetch($template = null, $cache_id = null, $compile_id = null, $parent = null, $display = false, $merge_tpl_vars = true, $no_output_filter = false)
    {

        if(!empty($template) && strpos($template, '.tpl') === false){
            $template .= '.tpl';
        }

        return $this->smarty->fetch($template, $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
    }



    /**
     * @param null $string
     * @param null $cache_id
     * @param null $compile_id
     * @param null $parent
     * @param bool $display
     * @param bool $merge_tpl_vars
     * @param bool $no_output_filter
     * @return string
     */
    public function fetchString($string = null, $cache_id = null, $compile_id = null, $parent = null, $display = false, $merge_tpl_vars = true, $no_output_filter = false)
    {
        return $this->smarty->fetch('string:' . $string, $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
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