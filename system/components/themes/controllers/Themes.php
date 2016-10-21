<?php
namespace system\components\themes\controllers;

use helpers\bootstrap\Icon;
use system\Backend;
use helpers\bootstrap\Button;
use helpers\bootstrap\Link;
use system\core\DataTables2;
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

        Settings::getInstance()->set('app_theme_current', $theme);
    }

    /**
     * @return mixed|void
     */
    public function create(){}

    /**
     * @param $theme
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
        } else {
            $dir = $this->request->get('dir');
            $path = $theme . (empty($dir) ? '' : '/'.$dir);
            $this->appendToPanel
            (
                (string)Button::create
                (
                    "Create folder",
                    ['class' => 'btn-md b-themes-create-dir', 'data-path' => $path]
                )
            );


            $this->appendToPanel
            (
                (string)Button::create
                (
                    "Create file",
                    ['class' => 'btn-md b-themes-create-file',  'data-path' => $path]
                )
            );

            $this->appendToPanel
            (
                (string)Button::create
                (
                    "Upload File",
                    ['class' => 'btn-md b-themes-upload-file',  'data-path' => $path]
                )
            );

            $t = new DataTables2('themes');

            $t->ajax('themes/view/' . $theme, ['g' => $_GET])
                ->th('Name', null, 0, 0)
                ->th('Size', null, 0, 0)
                ->th('Modified', null, 0, 0)
                ->th('Permissions', null, 0, 0)
                ->th($this->t('common.tbl_func'), null, 0, 0, 'width: 200px');

            $this->template->assign('table', $t->init());
        }

        $this->template->assign('theme', $theme);
        $this->template->assign('sidebar', $this->template->fetch('system/themes/tree'));
        $this->output($this->template->fetch('system/themes/edit'));
    }

    public function view($theme)
    {
        $dir = Settings::getInstance()->get('themes_path');
        $dir = DOCROOT . $dir . '/' . $theme . '/';

        $t = new DataTables2('themes');

        $res = [];
        $g = $this->request->post('g');
        $q_dir = isset($g['dir'] ) ? $g['dir'] . '/' : null;
        $dir .= $q_dir;
        if(is_dir($dir)){
            $files = array_diff(scandir($dir), array('.','..'));
            $i=0;
            foreach ($files as $item) {
                $abs_src = $dir . $item;
                $is_img = false;
                $stat = stat($abs_src);

                if(is_dir($abs_src)){
                    $href =  './themes/edit/'. $theme.'?dir=' . $q_dir . $item;
                    $res[$i][] = "<span style='line-height: 25px; display: inline-block'><i class='fa fa-folder-o'></i></span> <a href='$href'>{$item}</a>";

                    $res[$i][] = "--";
                } else {
                    $span = "<span style='line-height: 25px; display: inline-block'><i class='fa fa-file-o'></i></span> ";

                    $info = pathinfo($item);
                    if(in_array($info['extension'], ['png', 'jpg', 'jpeg'])){
                        $is_img = true;
                        $src = "/themes/{$theme}{$q_dir}{$item}";
                        $span = "<img src='{$src}' style='max-width: 40px; max-height:40px; margin-right: 1em;float: left;'>";
                    }

                    $res[$i][] = $span . $item ;
                    $res[$i][] = $this->formatBytes($stat['size']);
                }

                $res[$i][] = date('d.m.Y H:i:s', $stat['mtime']);
                $res[$i][] = $this->getPermissions($abs_src);

                $b = [];
                if(!is_dir($abs_src)){
                    $href =  './themes/edit/'. $theme.'?path=' . $q_dir . $item;
                    $b[] = (string)Link::create
                    (
                        Icon::create('fa fa-download'),
                        ['class' => '', 'href' => "./themes/downloadFile/?path=" . '/themes/'.$theme. $q_dir . $item, 'title' => "Download"]
                    );
                    if(! $is_img){
                        $b[] = (string)Link::create
                        (
                            Icon::create(Icon::TYPE_EDIT),
                            ['class' => '', 'href' => $href, 'title' => "Edit"]
                        );
                    }

                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-themes-delete-file btn-danger', 'data-path' => '/themes/'.$theme. $q_dir . $item, 'title' => "Delete"]
                    );
                }

                $res[$i][] = implode('', $b);

                $i++;
            }
        }
        echo $t->render($res, $t->getTotal());
    }

    public function downloadFile()
    {
        $path = $this->request->get('path');
        if(empty($path)) die;

        $file = DOCROOT.$path;
        $filename = basename($file);
        header('Content-Type: ' . mime_content_type($file));
        header('Content-Length: '. filesize($file));
        header(sprintf('Content-Disposition: attachment; filename=%s',
            strpos('MSIE',$_SERVER['HTTP_REFERER']) ? rawurlencode($filename) : "\"$filename\"" ));
        ob_flush();
        readfile($file);
        exit;
    }

    public function deleteFile()
    {
        $path = $this->request->post('path');
        if(empty($path)) die('empty path');

        $file = DOCROOT.$path;

        if(!file_exists($file)) die('File not exists');

        $s = unlink($file);

        echo $s ? 1 : 0;
    }

    /**
     *
     */
    public function createDir()
    {
        $path = $this->request->post('path');

        if($this->request->post('action') == 'create'){
            $s=0; $i=[];
            $themes_path = Settings::getInstance()->get('themes_path');
            $root = DOCROOT . $themes_path;
            $data = $this->request->post('data');
            $dir = $root . $path . '/' . $data['name'];
            if(is_dir($dir)){
                $i[] = ['data[name]' => 'Directory exists'];
            } else{
                $s = mkdir($dir, 0777, true);
            }

            $this->response->body(['s' =>$s, 'i' => $i])->asJSON();
            return ;
        }

        $this->template->assign('path', $path);
        echo $this->template->fetch('system/themes/createDir');
    }


    /**
     *
     */
    public function createFile()
    {
        $path = $this->request->post('path');

        if($this->request->post('action') == 'create'){
            $s=0; $i=[];
            $themes_path = Settings::getInstance()->get('themes_path');
            $root = DOCROOT . $themes_path;
            $data = $this->request->post('data');
            $dir = $root . $path . '/' . $data['name'];
            $info = pathinfo($data['name']);
            if(file_exists($dir)){
                $i[] = ['data[name]' => 'File exists'];
            } elseif(!in_array($info['extension'], ['ini', 'txt', 'tpl'])){
                $i[] = ['data[name]' => 'File extension not allowed'];
            } else {
                file_put_contents($dir, null);
                $s=1;
            }

            $this->response->body(['s' =>$s, 'i' => $i])->asJSON();
            return ;
        }

        $this->template->assign('path', $path);
        echo $this->template->fetch('system/themes/createFile');
    }

    /**
     *
     */
    public function uploadFile()
    {
        $s=0; $i=[];

        $allowed = [
            'image/png',
            'image/jpg',
            'image/jpeg',
            'text/plain',
            'application/x-wine-extension-ini',
            'application/octet-stream',
            'application/javascript',
            'text/css',
        ];

        $path = $this->request->post('path');

        if($this->request->post('action') == 'create'){

           foreach ($_FILES['file']['name'] as $k=> $v) {
               $type = $_FILES['file']['type'][$k];
               if(!in_array($type, $allowed)){
                   $i[] = ['file'=> 'Not Allowed'];
               }
           }

           $themes_path = Settings::getInstance()->get('themes_path');
           $dir         = DOCROOT . $themes_path . $path .'/';

            if(!is_dir($dir)){
                $i[] = ['file'=> 'Wrong directory'];
            }

            if(empty($i)) {

                foreach ($_FILES['file']['name'] as $k => $v) {
                    $name = $_FILES['file']['name'][$k];
                    $tmp_name = $_FILES['file']['tmp_name'][$k];
//                    echo $dir . $name, "\r\n";
                    $s = move_uploaded_file($tmp_name, $dir . $name);
                }
            }
            $this->response->body(['s' =>$s, 'i' => $i])->asJSON();
            return ;
        }

        $this->template->assign('path', $path);
        echo $this->template->fetch('system/themes/upload');
    }

    private function getPermissions($item)
    {
        $perms = fileperms($item);

        switch ($perms & 0xF000) {
            case 0xC000: // сокет
                $info = 's';
                break;
            case 0xA000: // символическая ссылка
                $info = 'l';
                break;
            case 0x8000: // обычный
                $info = 'r';
                break;
            case 0x6000: // файл блочного устройства
                $info = 'b';
                break;
            case 0x4000: // каталог
                $info = 'd';
                break;
            case 0x2000: // файл символьного устройства
                $info = 'c';
                break;
            case 0x1000: // FIFO канал
                $info = 'p';
                break;
            default: // неизвестный
                $info = 'u';
        }

// Владелец
        $info .= (($perms & 0x0100) ? 'r' : '-');
        $info .= (($perms & 0x0080) ? 'w' : '-');
        $info .= (($perms & 0x0040) ?
            (($perms & 0x0800) ? 's' : 'x' ) :
            (($perms & 0x0800) ? 'S' : '-'));

// Группа
        $info .= (($perms & 0x0020) ? 'r' : '-');
        $info .= (($perms & 0x0010) ? 'w' : '-');
        $info .= (($perms & 0x0008) ?
            (($perms & 0x0400) ? 's' : 'x' ) :
            (($perms & 0x0400) ? 'S' : '-'));

// Мир
        $info .= (($perms & 0x0004) ? 'r' : '-');
        $info .= (($perms & 0x0002) ? 'w' : '-');
        $info .= (($perms & 0x0001) ?
            (($perms & 0x0200) ? 't' : 'x' ) :
            (($perms & 0x0200) ? 'T' : '-'));

        return $info;
    }
    private function formatBytes($bytes, $precision = 2) {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');

        $bytes = max($bytes, 0);
        $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
        $pow = min($pow, count($units) - 1);

        // Uncomment one of the following alternatives
        // $bytes /= pow(1024, $pow);
        // $bytes /= (1 << (10 * $pow));

        return round($bytes, $precision) . ' ' . $units[$pow];
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

                $href = !is_dir($dir . $path . '/' . $fn) ?
                    './themes/edit/'. $theme.'?path=' . $path . '/' . $fn :
                    "./themes/edit/{$theme}?dir={$path}";

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