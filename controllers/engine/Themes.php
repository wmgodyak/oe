<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 26.06.14 12:58
 */

namespace controllers\engine;

use controllers\Engine;
use controllers\core\Settings;

defined('CPATH') or die();

/**
 * Class Themes
 * @name Теми
 * @icon fa-television
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Themes extends Engine {

    private $path = '';
    private $themes;

    public function __construct()
    {
        parent::__construct();

        $this->themes = new \models\engine\Themes();

        $this->path = Settings::getInstance()->get('themes_path');
    }



    /**
     * @return mixed
     */
    public function index(){
        $current = Settings::getInstance()->get('app_theme_current');
        // зчитую теми з папки
        $path = DOCROOT .'/'. $this->path;
        $path_url = APPURL .'/'. $this->path;


        $themes = array();
        if ($handle = opendir($path)) {
            while (false !== ($theme = readdir($handle))) {
                if ($theme != "." && $theme != "..") {
                    if(!file_exists($path . '/' . $theme . '/config.php'))
                        continue;

                    $config = include($path . '/' . $theme . '/config.php');
                    if($config['type'] == 'backend') continue;

                    $config['path']    = $path . $theme . '/';
                    $config['urlpath'] = $path_url . $theme . '/';
                    $config['theme']   = $theme;

                    // set current theme
                    $config['current'] = ($theme == $current ? 'current' : '');

                    $themes[] = $config;
                }
            }
            closedir($handle);
        }
        $this->template->assign('items', $themes);
        $content = $this->template->fetch('themes/index');
        $this->output($content);
    }

    /**
     * Активація обраної теми
     * @param $theme
     * @return int
     */
    public function activate($theme)
    {
        if(empty($theme)) return 0;
        return $this->themes->activate($theme);
    }

    /**
     * @return mixed|void
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
    public function delete($id){}
    public function process($id){}
}