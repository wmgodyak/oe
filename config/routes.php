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
$route->any('/backend/{alpha}', 'component');
$route->any('/backend/{alpha}/{alpha}', 'component');
$route->any('/backend/{alpha}/{alpha}/{any}', 'component');
$route->any('/backend/{alpha}/{alpha}/{any}/{any}', 'component');

$route->any('/backend/module/run/(.*)', '\system\components\module\controllers\Module::run');

// dashboard
$route->get('/backend', '\system\components\dashboard\controllers\Dashboard');


//        $route->get('/', function(){return '/home closure';});
//        $route->get('/post/{id}', function($id){return "/home closure $id";});
//        $route->get('/post/{post}/comments/{comment}', function($post, $comment){return "/home closure $post $comment";});
//        $route->get('/post/{url}', function($url){return "/home closure $url";});
//        $route->get('/{any}', function($url){return "/home closure $url";});
//        $route->get('/rest', 'Rest::index');
//        $route->get('/system/cron', '\system\Cron');
//        $route->get('/route/{alpha}/{alpha}', 'module');

//        $route->get('/{url}/tag/{url}', 'Rest::index');
//        $route->get('/{lang}', 'Rest::index');
//        $route->get('/rest/{url}', 'Rest');
//        $route->get('/rest/{url}', 'Rest::show');
//        $route->get('/rest/{id}/edit', 'Rest::edit');
//        $route->post('/rest', 'Rest::store');
//        $route->put('/rest/{id}', 'Rest::update');
//        $route->delete('/rest/{id}', 'Rest::delete');