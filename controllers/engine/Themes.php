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
use helpers\bootstrap\Button;
use helpers\bootstrap\Link;

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
                    if(!file_exists($path . '/' . $theme . '/config.ini'))
                        continue;

                    $config = parse_ini_file($path . '/' . $theme . '/config.ini');

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
    public function edit($theme)
    {
        $not_allowed = ['png','gif', 'jpeg', 'php','jpg'];
        $path = $this->request->get('path');
        $path = str_replace('../','',$path);
        if($path){

            $this->appendToPanel
            (
                (string)Link::create
                (
                    $this->t('common.back'),
                    ['class' => 'btn-md', 'href'=> 'themes']
                )
            );

            $this->appendToPanel
            (
                (string)Button::create
                (
                    $this->t('common.button_save'),
                    ['class' => 'btn-md b-form-save']
                )
            );

            $dir = Settings::getInstance()->get('themes_path');
            $dir = DOCROOT .'/'. $dir . '/' . $theme . '/';
            if(file_exists($dir . $path) && !is_dir($dir . $path)){
                $fileinfo = pathinfo($path);
                if (in_array(mb_strtolower($fileinfo['extension']), $not_allowed)){
                    $this->template->assign('error', "wrong file extension. Not allowed: " . implode(', ', $not_allowed));
                } else{

                    $source = file_get_contents($dir.$path);
                    $source = htmlentities($source);
                    $this->template->assign('source', $source);
                    $this->template->assign('path', $path);
                }
            } else {
                $this->template->assign('error', "wrong path");
            }
        }
        $this->template->assign('theme', $theme);
        $this->template->assign('sidebar', $this->template->fetch('themes/tree'));
        $this->output($this->template->fetch('themes/edit'));
    }

    public function updateSource()
    {
        $source = $this->request->post('source');
        $path   = $this->request->post('path');
        $path = str_replace('../','',$path);
        $theme  = $this->request->post('theme');
        $dir = Settings::getInstance()->get('themes_path');
        $dir = DOCROOT .'/'. $dir . '/' . $theme . '/';
        $s = 0; $m = null;
        if(!file_exists($dir . $path)){
            $m = "wrong path";
        } else {
            $s = file_put_contents($dir.$path, $source);
            $m = 'Source Updated';
        }
        $this->response->body(['s' => $s, 'm' => $m])->asJSON();
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