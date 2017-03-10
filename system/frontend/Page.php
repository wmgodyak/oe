<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.03.17 : 17:09
 */

namespace system\frontend;

defined("CPATH") or die();

use system\core\Request;
use system\core\Session;
use system\models\Modules;
use system\core\DataFilter;
use system\core\EventsHandler;

/**
 * Class Page
 */
class Page extends \system\Frontend
{
    protected $languages_id;
    protected $languages_code;

    protected $page;
    private   $theme;
    protected $app;

    public function index()
    {
        if($this->request->isXhr()) return;

        if ( preg_match('!/{2,}!', $_SERVER['REQUEST_URI']) ){
            $url = preg_replace('!/{2,}!', '/', $_SERVER['REQUEST_URI']);
            header('Location: ' . $url , false, 301);
            exit;
        }

        $lowerURI = strtolower($_SERVER['REQUEST_URI']);
        if($_SERVER['REQUEST_URI'] != $lowerURI){
            if(mb_substr($lowerURI, 0, 1) == '/') {
                $lowerURI = mb_substr($lowerURI, 1);
            }
            $uri = APPURL . $lowerURI;
            header("HTTP/1.1 301 Moved Permanently");
            header("Location: $uri");
            exit();
        }

        $this->template->assign('base_url',    APPURL );

        $events = EventsHandler::getInstance();
        $this->template->assign('events', $events);

        $this->template->assign('settings', $this->settings);

        if($this->settings->get('active') == 0) {
            $a = Session::get('backend.admin');
            if( ! $a) {
                $this->technicalWorks();
            }
        }

        // завантаження сторінки
        $page = $this->getPageInfoFromRequest();

        if (!$page) {
            $page = $this->e404();
        }

        $page['content'] = $this->template->fetchString($page['content']);

        Request::getInstance()->param('page', $page);

        if ($page['status'] != 'published') {
            $a = Session::get('engine.admin');
            if (!$a) {
                $page = $this->e404();
            }
        }

        $this->languages_id   = $page['languages_id'];
        $this->languages_code = $page['languages_code'];

        $_SESSION['app'] = [
          'languages_id' => $page['languages_id'],
          'languages_code' => $page['languages_code']
        ];

        $this->request->param('languages_id', $page['languages_id']);

        Request::getInstance()->param('languages_id', $this->languages_id);
        Request::getInstance()->param('languages_code', $this->languages_code);

        // make meta
        $page = $this->makeMeta($page);

        //assign page to template
        $this->template->assign('page', $page);
        $this->page = $page;

        // init modules
        $m = new Modules($this->template->theme, $page['languages_code']);
        $this->app->module = $m->init();;

        // changed to function t($key);
//        $this->template->assign('t', $this->t());


        $this->template->assign('app', $this->app);
        $this->template->assign('modules_scripts', $this->template->getScripts());

        if ($page['id'] == $this->settings->get('page_404')) {
            $this->response->sendError(404);
        }

        // fetch template
        $template_path = $this->settings->get('themes_path')
            . $this->settings->get('app_theme_current') . '/'
            . 'layouts/';

        $ds = $this->template->fetch($template_path . $page['template']);
        $this->template->assign('body', $ds);
        $ds = $this->template->fetch($template_path . 'index');

        $ds = DataFilter::apply('documentSource', $ds);

        $this->response->body($ds);
    }

    private function getPageInfoFromRequest()
    {
        $args = $this->request->param();

        if(empty($this->languages_id) && !isset($args['url']) && isset($args['lang'])){
            // короткий url
            $args['url'] = $args['lang'];
        }

        if(empty($args['url']) && !empty($args['lang'])){
            $def_lang_id = $this->languages->getDefault('id');
            $lang_id = $this->languages->getDataByCode($args['lang'], 'id');
            if($def_lang_id == $lang_id){
                $uri = APPURL;
                header("HTTP/1.1 301 Moved Permanently");
                header("Location: $uri");
                die;
            }
        }

        $url = isset($args['url']) ? $args['url'] : '';
        $url = rtrim($url, '/');

        if(empty($url)){
            $id = $this->settings->get('home_id');
        } else {
            // page info
            $id = $this->app->page->getIdByUrl($url, $this->languages_id);
        }

        if(empty($id)) return null;

        return $this->app->page->fullInfo($id);
    }

    /**
     *
    {title} - заголовок сторінки,
    {keywords} - ключові слова сторінки,
    {h1} - заголовок першого рвіня сторінки,
    {description} - опис сторінки,
    {company_name} - Назва компанії,
    {company_phone} - телефон,
    {category} - категорія,
    {categories} - список категорій,
    {delimiter} - розділювач, напр "/"
     * @param $page
     * @return mixed
     */
    private function makeMeta($page)
    {
        $delimiter = '/';
        $company_name  = $this->settings->get('company_name');
        $company_phone = $this->settings->get('company_phone');

        if(empty($page['title'])) {
            $page['title'] = $page['name'];
        }
        if(empty($page['h1'])) {
            $page['h1'] = $page['name'];
        }

        $meta = ['title', 'keywords', 'description', 'h1'];

        foreach ($meta as $k=>$mk) {
            if(!isset($s[$page['type']][$this->languages_id][$mk])) continue;

            $tpl = $s[$page['type']][$this->languages_id][$mk];
            $page[$mk] = str_replace
            (
                [
                    '{title}',
                    '{keywords}',
                    '{description}',
                    '{h1}',
                    '{delimiter}',
                    '{company_name}',
                    '{company_phone}',
                ],
                [
                    $page['title'],
                    $page['keywords'],
                    $page['description'],
                    $page['h1'],
                    $delimiter,
                    $company_name,
                    $company_phone
                ],
                $tpl
            );

            if(strpos($page[$mk], '{category}') !== false){
                if($page['parent_id'] > 0){
                    $page[$mk] = str_replace('{category}', $this->app->page->info($page['parent_id'], $mk), $page[$mk]);
                } else {
                    $categories_id = $this->app->page->getRelationMainCategoryID($page['id']);
                    if($categories_id > 0){
                        $page[$mk] = str_replace('{category}', $this->app->page->info($categories_id, $mk), $page[$mk]);
                    }
                }
            }
        }

        return $page;
    }

    /**
     * todo fix it
     */
    private function technicalWorks()
    {
        echo '<!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Technikal works</title>
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
                        </style>
        </head>
        <body id="error-page">
            <h2>Technical work on the site</h2>
            <div class="code-wrapper">
                <code>Technical work on the site. Please visit page later</code>
            </div>
        </body>
        </html>';
        die();
    }

    public function init(){}
}