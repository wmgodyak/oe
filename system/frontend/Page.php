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
        $page = $this->app->page->fullInfo($id);

        return $this->display($page);
    }

    public function displayLang($code)
    {
        if(empty($this->languages->id) && !isset($args['url']) && isset($code)){
            // short url
            $args['url'] = $code;
        }

        $def_lang_id = $this->languages->languages->getDefault('id');
        $lang_id = $this->languages->languages->getDataByCode($code, 'id');

        if(empty($lang_id)){
            return $this->e404();
        }

        if($def_lang_id == $lang_id){

            $uri = APPURL;
            header("HTTP/1.1 301 Moved Permanently");
            header("Location: $uri");
            die;

        }

        $id = $this->settings->get('home_id');
        $page = $this->app->page->fullInfo($id, $lang_id);

        return $this->display($page);
    }

    public function displayLangAndUrl($code, $url)
    {
        $lang_id = $this->languages->languages->getDataByCode($code, 'id');
        $id = $this->app->page->getIdByUrl($url, $lang_id);
        if(empty($id)){
           return $this->e404();
        }

        $page = $this->app->page->fullInfo($id, $lang_id);
        return $this->display($page);
    }

    public function displayUrl($url)
    {

        $id = $this->app->page->getIdByUrl($url, $this->languages->id);

        if(empty($id)){
            return $this->e404();
        }

        $page = $this->app->page->fullInfo($id);

        return $this->display($page);
    }

    public function index(){}
    public function init(){}
}