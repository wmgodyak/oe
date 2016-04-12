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
    public function edit($id)
    {
        $this->template->assign('theme', $id);
        $this->template->assign('sidebar', $this->template->fetch('themes/tree'));
        $this->response->body($this->template->fetch('themes/edit'));
    }

    public function tree($theme)
    {
        if(! $this->request->isXhr()) die;

//        $this->dump($_GET);

        $dir = Settings::getInstance()->get('themes_path');

        $dir = DOCROOT .'/'. $dir . '/' . $theme . '/';
        $path = $this->request->get('id', 's');
        $path = str_replace('#', '', $path);
        $items = array();
        if ($handle = opendir($dir . $path)) {
            while (false !== ($fn = readdir($handle))) {
                if ($fn == "." || $fn == "..")  continue;

                $items[] = [
                    'text' => $fn,
                    'type' => is_dir($dir . $path . '/' . $fn) ? 'folder' : 'file',
                    'children' => is_dir($dir . $path . '/' . $fn) ,
                    'a_attr' => ['id'=> $path . '/' . $fn, 'href' => './themes/edit/'. $theme.'?path=' . $path . '/' . $fn],
                    'li_attr' => ['id'=> $path . '/' . $fn]
                ];
            }
            closedir($handle);

        }
        $this->response->body($items)->asJSON();
//        $items = array();
//        $parent_id = $this->request->get('id','i');
//        foreach ($this->tree->getItems($parent_id) as $item) {
//            $item['children'] = $item['isfolder'] == 1;
//            if( $parent_id > 0 ){
//                $item['parent'] = $parent_id;
//            }
//            $item['text'] .= " #{$item['id']}";
//            $item['a_attr'] = ['id'=> $item['id'], 'href' => './content/pages/edit/' . $item['id']];
//            $item['li_attr'] = [
//                'id'=> 'li_'.$item['id'],
//                'class' => 'status-' . $item['status'],
//                'title' => ($item['status'] == 'published' ? 'Опублікоавно' : 'Приховано')
//
//            ];
//            $item['type'] = $item['isfolder'] ? 'folder': 'file';
////            $item['icon'] = 'fa fa-file icon-state-info icon-md';
//
//            $items[] = $item;
//        }
//
//        $this->response->body($items)->asJSON();
    }


    /**
     * @param $id
     * @return mixed
     */
    public function delete($id){}
    public function process($id){}
}