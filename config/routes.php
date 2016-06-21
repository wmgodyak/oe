<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 14:32
 */

$routes = array();

//$routes[] = array('/engine/content/images/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'system\components\content\images\:controller:action');

    //http://engine_6x.loc/engine/content/group/edit/3
//    $routes[]  = array('/engine/plugins/([a-zA-Z_]+)/([a-zA-Z_0-9]+)/?(.*)', 'system\components\plugins\:controller:action');
//    $routes[]  = array('/engine/content/([a-zA-Z_]+)/?', 'system\components\content\:controller:action');
//    $routes[]  = array('/engine/content/([a-zA-Z_]+)/([a-zA-Z_0-9]+)/?(.*)', 'system\components\content\:controller:action');
    //http://engine_6x.loc/engine/users/group/edit/3
//    $routes[]  = array('/engine/users/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'system\components\users\:controller:action');
    //http://engine_6x.loc/engine/structure/edit/3
    $routes[]  = array('/engine/([a-zA-Z_0-9]+)/([a-zA-Z_0-9]+)/?(.*)', 'system\components\:controller:action');
    //http://engine_6x.loc/engine/structure/edit
    $routes[]  = array('/engine/([a-zA-Z_0-9]+)/([a-zA-Z_0-9]+)/?', 'system\components\:controller:action');
    //http://engine_6x.loc/engine/structure
    $routes[]  = array('/engine/([a-zA-Z_0-9]+)/?', 'system\components\:controller');
    //http://engine_6x.loc/engine/
    $routes[]  = array('/engine/?', 'system\components\Dashboard');

/**
 * FRONTEND
 */
/*
// коли чітко задано які змінні мають бути
    $routes[]  = array('/install/?', 'controllers\Install');
    $routes[]  = array('/route/([a-zA-Z0-9-_]+)/([a-zA-Z0-9-_]+)/?(.*)', 'modules\:controller:action');
    $routes[]  = array('/ajax/([a-zA-Z0-9-_]+)/([a-zA-Z0-9-_]+)/?(.*)', 'modules\:controller:action');

    //http://engine.loc/uk/oplata-ta-dostavka/filter/vendor=acer;display=14;ram=ddr3;/page/4
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/filter/([=,;a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'lang/url/filter/p');
    $routes[]  = array('/([a-z0-9-_/]+)/filter/([=,;a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'url/filter/p');
    //http://engine.loc/uk/oplata-ta-dostavka/filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/filter/([=,;a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'lang/url/filter');
    $routes[]  = array('/([a-z0-9-_/]+)/filter/([=,;a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'url/filter');


    // http://engine.loc/oplata-ta-dostavka/author=wg
    $routes[]  = array('/([a-z0-9-_/]+)/author=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'url/author/p');
    // http://engine.loc/uk/oplata-ta-dostavka/author=wg
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/author=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'lang/url/author/p');

    // http://engine.loc/oplata-ta-dostavka/author=wg
    $routes[]  = array('/([a-z0-9-_/]+)/author=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'url/author');
    // http://engine.loc/uk/oplata-ta-dostavka/author=wg
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/author=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'lang/url/author');

    // http://engine.loc/uk/oplata-ta-dostavka/tag=seo/page/2
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/tag=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'lang/url/tag/p');
    $routes[]  = array('/([a-z0-9-_/]+)/tag=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'url/tag/p');

    // http://engine.loc/uk/oplata-ta-dostavka/tag=seo
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/tag=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'lang/url/tag');
    $routes[]  = array('/([a-z0-9-_/]+)/tag=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'url/tag');

    // http://engine.loc/uk/novyny/q=asdjkl%D1%84%D1%96%D0%B23/page/4
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/q=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'lang/url/q/p');

    // http://engine.loc/novyny/q=asdjkl%D1%84%D1%96%D0%B23/page/4
    $routes[]  = array('/([a-z0-9-_/]+)/q=([a-z0-9а-яА-ЯіїЇІ_\-]+)/page/([0-9]+)', 'system\App', 'url/q/p');

    //http://engine.loc/uk/novyny/q=asdjkl%D1%84%D1%96%D0%B23
    $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/q=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'lang/url/q');
    //http://engine.loc/novyny/q=asdjkl%D1%84%D1%96%D0%B23
    $routes[]  = array('/([a-z0-9-_/]+)/q=([a-z0-9а-яА-ЯіїЇІ_\-]+)', 'system\App', 'url/q');


    //http://engine.loc/uk/pro-nas/page/2
    $routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/page/([0-9]+)/?', 'system\App', 'lang/url/p');

    //http://engine.loc/pro-nas/page/2
    $routes[]  = array('/([a-zA-Z0-9-_/]+)/page/([0-9]+)/?', 'system\App', 'url/p');

    $routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/?', 'system\App', 'lang/url');
    $routes[]  = array('/([a-z]{2})/?', 'system\App', 'lang');

    $routes[]  = array('/([a-zA-Z0-9-_/]*)/?', 'system\App', 'url');

    $routes[]  = array('/([^0-9A-Za-zА-Яа-яЁё]+)/?(.*)', 'system\App', 'url');

    $routes[]  = array('/?', 'system\App');
*/
$routes[]  = array('/?', 'system\Front');

return $routes;