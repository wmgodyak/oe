<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:vh@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 */
$route = \system\core\Route::getInstance();

/**
 * FRONTEND
 */
// cron
$route->get('/system/cron', '\system\Cron');
// some module
$route->any('/route/{alpha}/{alpha}', 'module');
$route->any('/route/{alpha}/{alpha}/{any}', 'module');

// only lang
$route->get('/{lang}', '\system\frontend\Page::displayLang');

// lang/url
$route->get('/{lang}/{url}', '\system\frontend\Page::displayLangAndUrl');

// only url
$route->get('/{url}', '\system\frontend\Page::displayUrl');
$route->get('/', '\system\frontend\Page::displayHome');

/**
 * BACKEND
 */
// some component
$route->any('/backend/{alpha}/{alpha}/{any}', 'component');
$route->any('/backend/{alpha}/{alpha}', 'component');
$route->any('/backend/{alpha}', 'component');
// dashboard
$route->get('/backend', '\system\components\Dashboard');

//        $this->get('/', function(){return '/home closure';});
//        $this->get('/post/{id}', function($id){return "/home closure $id";});
//        $this->get('/post/{post}/comments/{comment}', function($post, $comment){return "/home closure $post $comment";});
//        $this->get('/post/{url}', function($url){return "/home closure $url";});
//        $this->get('/{any}', function($url){return "/home closure $url";});
//        $this->get('/rest', 'Rest::index');
//        $this->get('/system/cron', '\system\Cron');
//        $this->get('/route/{alpha}/{alpha}', 'module');

//        $this->get('/{url}/tag/{url}', 'Rest::index');
//        $this->get('/{lang}', 'Rest::index');
//        $this->get('/rest/{url}', 'Rest');
//        $this->get('/rest/{url}', 'Rest::show');
//        $this->get('/rest/{id}/edit', 'Rest::edit');
//        $this->post('/rest', 'Rest::store');
//        $this->put('/rest/{id}', 'Rest::update');
//        $this->delete('/rest/{id}', 'Rest::delete');