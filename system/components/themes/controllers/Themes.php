<?php
namespace system\components\themes\controllers;

use system\Backend;
use helpers\bootstrap\Button;
use helpers\bootstrap\Link;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Themes
 * @package system\components\themes\controllers
 */
class Themes extends Backend
{
    private $path = '';

    public function __construct()
    {
        parent::__construct();

        $this->path = Settings::getInstance()->get('themes_path');
    }

    public function init()
    {
        $this->assignToNav('Теми', 'themes', 'puzzle-piece', 'settings', 100);
    }

    /**
     * @return mixed
     */
    public function index(){

        $this->appendToPanel
        (
            (string)Button::create
            (
                'Завантажити .zip',
                ['class' => 'btn-md b-themes-upload']
            )
        );

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
        $content = $this->template->fetch('system/themes/index');
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

        return Settings::getInstance()->set('app_theme_current', $theme);
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
        $not_allowed = ['php'];
        $img_ext = ['png','gif', 'jpeg', 'jpg'];
        $path = $this->request->get('path');
        $path = str_replace('../', '', $path);

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
            $_dir = $dir . '/' . $theme . '/';
            $dir = DOCROOT . $dir . '/' . $theme . '/';
            if(file_exists($dir . $path) && !is_dir($dir . $path)){
                $fileinfo = pathinfo($path);
                if (in_array(mb_strtolower($fileinfo['extension']), $not_allowed)){
                    $this->template->assign('error', "wrong file extension. Not allowed: " . implode(', ', $not_allowed));
                } else if(in_array(mb_strtolower($fileinfo['extension']), $img_ext)){
                    $img =  '/'.$_dir . $path;
                    $this->template->assign('img', $img);
                } else {
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
        $this->template->assign('sidebar', $this->template->fetch('system/themes/tree'));
        $this->output($this->template->fetch('system/themes/edit'));
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

        $dir = Settings::getInstance()->get('themes_path');

        $dir = DOCROOT .'/'. $dir . '/' . $theme . '/';
        $path = $this->request->get('id');
        $path = str_replace('#', '', $path);
        $items = array();
        if ($handle = opendir($dir . $path)) {
            while (false !== ($fn = readdir($handle))) {
                if ($fn == "." || $fn == "..")  continue;

                $href = !is_dir($dir . $path . '/' . $fn) ? './themes/edit/'. $theme.'?path=' . $path . '/' . $fn : '#';

                $items[] = [
                    'text' => $fn,
                    'type' => is_dir($dir . $path . '/' . $fn) ? 'folder' : 'file',
                    'children' => is_dir($dir . $path . '/' . $fn) ,
                    'a_attr' => ['id'=> $path . '/' . $fn, 'href' => $href],
                    'li_attr' => ['id'=> $path . '/' . $fn]
                ];
            }
            closedir($handle);

        }
        $this->response->body($items)->asJSON();
    }
    public function download($theme)
    {
        $dir = Settings::getInstance()->get('themes_path');
        $path = DOCROOT . $dir . $theme;

        $zip = new \ZipArchive();

        $zip_name="$theme.zip";

        if(file_exists(DOCROOT."tmp/".$zip_name)) {
            unlink (DOCROOT."tmp/".$zip_name);
        }
        if ($zip->open(DOCROOT."tmp/".$zip_name, \ZIPARCHIVE::CREATE) != TRUE) {
            die ("Could not open archive");
        }
//

        $files = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($path),
            \RecursiveIteratorIterator::LEAVES_ONLY
        );

        foreach ($files as $name => $file){
            if (!$file->isDir()){
                $filePath = $file->getRealPath();
                $relativePath = substr($filePath, strlen($path) + 1);

                $zip->addFile($filePath, $relativePath);
            }
        }

        $zip->close();
        header('Content-Type: application/zip');
        header('Content-disposition: attachment; filename='.$zip_name);
        header('Content-Length: ' . filesize($zip_name));
        readfile(DOCROOT."tmp/".$zip_name);
    }

    public function upload()
    {
        $s=0;$m=null;
        $dir = Settings::getInstance()->get('themes_path');
        $tmp_dir  = DOCROOT . 'tmp/';
        $dir      = DOCROOT . $dir .'/';
//        $this->dump($_FILES);die;
        $theme = $_FILES['theme'];
        if($theme['type'] != 'application/zip'){
            $m = 'Wrong file extension: ' . $theme['type'];
        } else {
            if(!  move_uploaded_file($theme['tmp_name'], "$tmp_dir/{$theme['name']}")){
                $m = 'Can not upload theme.';
            } else {

            }
            $zip = new \ZipArchive;
            $res = $zip->open( "$tmp_dir/{$theme['name']}" );
            if ($res === TRUE) {
                $zip->extractTo($dir);
                $zip->close();
                $s=1;
            }
        }

        $this->response->body(['s' => $s, 'm' => $m])->asJSON();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id){}
    public function process($id){}
}