<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.03.17 : 17:09
 */

namespace system\frontend;

defined("CPATH") or die();

/**
 * Class Page
 */
class Page extends \system\Frontend
{
    public function displayHome()
    {
        if($this->request->isXhr()) return null;

        $id = $this->settings->get('home_id');
        $page = $this->app->page->fullInfo($id, $this->languages->id);

        return $this->display($page);
    }

    public function displayUrl($url)
    {
        $this->seoRules($url);

        $id = $this->app->page->getIdByUrl($url, $this->languages->id);

        if(empty($id)){
            return $this->e404();
        }

        $page = $this->app->page->fullInfo($id);

        return $this->display($page);
    }

    public function index(){}

    private function seoRules()
    {
        // redirect from url to url/
        if(strlen($_SERVER['REQUEST_URI']) > 1 && mb_substr($_SERVER['REQUEST_URI'], -1, 1) != '/') {
//            $uri = mb_substr($_SERVER['REQUEST_URI'], 0, -1);
//            $uri = mb_substr($uri, 1);
            $uri = APPURL . ltrim($_SERVER['REQUEST_URI'], '/') . '/';
            header("HTTP/1.1 301 Moved Permanently");
            header("Location: $uri");
            exit();
        }

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
    }
}