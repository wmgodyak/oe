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
        $id = $this->app->page->getIdByUrl($url, $this->languages->id);

        if(empty($id)){
            return $this->e404();
        }

        $page = $this->app->page->fullInfo($id);

        return $this->display($page);
    }

    public function index(){}
}