<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 14:32
 */

$routes = array();

//$routes[] = array('/engine/content/images/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'controllers\engine\content\images\:controller:action');

    //http://engine_6x.loc/engine/content/group/edit/3
    $routes[]  = array('/engine/plugins/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'controllers\engine\plugins\:controller:action');
//    $routes[]  = array('/engine/content/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'controllers\engine\content\:controller:action');
    //http://engine_6x.loc/engine/users/group/edit/3
//    $routes[]  = array('/engine/users/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'controllers\engine\users\:controller:action');
    //http://engine_6x.loc/engine/structure/edit/3
    $routes[]  = array('/engine/([a-zA-Z_]+)/([a-zA-Z_]+)/?(.*)', 'controllers\engine\:controller:action');
    //http://engine_6x.loc/engine/structure/edit
    $routes[]  = array('/engine/([a-zA-Z_]+)/([a-zA-Z_]+)/?', 'controllers\engine\:controller:action');
    //http://engine_6x.loc/engine/structure
    $routes[]  = array('/engine/([a-zA-Z_]+)/?', 'controllers\engine\:controller');
    //http://engine_6x.loc/engine/
    $routes[]  = array('/engine/?', 'controllers\engine\Dashboard');

/**
 * FRONTEND
 */

// коли чітко задано які змінні мають бути
    $routes[]  = array('/install/?', 'controllers\Install');
    $routes[]  = array('/ajax/([a-zA-Z0-9-_/]+)/([a-zA-Z0-9-_/]+)/?', 'controllers\modules\:controller:action');

//    $routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/tag/([0-9a-zA-Z]+)?', 'controllers\App', 'lang/alias/tag/tag');
//    $routes[]  = array('/([a-zA-Z0-9-_/]+)/tag/([0-9a-zA-Z]+)?', 'controllers\App', 'alias/tag/tag');
//    $routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/([0-9]+)/?', 'controllers\App', 'lang/alias/p');
    $routes[]  = array('/([a-zA-Z0-9-_/]+)/([0-9]+)/?', 'controllers\App', 'alias/p');
    $routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/?', 'controllers\App', 'lang/alias');
    $routes[]  = array('/([a-z]{2})/?', 'controllers\App', 'lang');
    $routes[]  = array('/([a-zA-Z0-9-_/]*)/?', 'controllers\App', 'alias');
    $routes[]  = array('/?', 'controllers\App');

return $routes;