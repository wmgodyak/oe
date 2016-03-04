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

defined('SYSPATH') or die();

class Themes extends Engine {
    private $path = '';

    public function __construct()
    {
        parent::__construct();

        $this->tm = $this->load->model('engine\Themes');

        $this->path = Settings::instance()->get('themes_path');
    }



    /**
     * @return mixed
     */
    public function index(){
        $current = Settings::instance()->get('app_theme_current');
//        var_dump($current);
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

        $content = $this->load->view(
            'themes',
            array(
                'themes' => $themes
            )
        );

        $this->setContent($content);

        return $this->output();
    }

    /**
     * Активація обраної теми
     * @param $theme
     * @return int
     */
    public function activate($theme)
    {
        if(empty($theme)) return 0;

        return Settings::instance()->set('app_theme_current', $theme);
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