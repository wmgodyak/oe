<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 14:32
 */

$routes = array();

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
$routes[]  = array('/route/([a-zA-Z0-9-_]+)/([a-zA-Z0-9-_]+)/?(.*)', 'modules\:controller:action');
$routes[]  = array('/system/cron/run/?(.*)', 'system\Cron', 'action');

//http://engine.loc/uk/oplata-ta-dostavka/filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3
$routes[]  = array('/([a-z]{2})/?', 'system\Front', 'lang');
$routes[]  = array('/([a-z0-9-_/]+)/filter/(.*)', 'system\Front', 'url/filter/filter');

$routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/?', 'system\Front', 'lang/url');
$routes[]  = array('/([a-zA-Z0-9-_/]+)/page/([0-9]+)/?', 'system\Front', 'url/p');
$routes[]  = array('/(.*)', 'system\Front', 'url');

return $routes;