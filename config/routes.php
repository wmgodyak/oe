<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 14:32
 */

$routes = array();

/**
 * FRONTEND
 */
$routes[]  = array('/route/([a-zA-Z0-9-_]+)/([a-zA-Z0-9-_]+)/?(.*)', 'modules\:controller:action');
$routes[]  = array('/system/cron/run/?(.*)', 'system\Cron', 'action');

// blog
$routes[]  = array('/([a-z0-9-_/]+)/tag/(.*)', 'system\Frontend', 'url/tag/tag');

$routes[]  = array('/([a-z]{2})/?', 'system\Frontend', 'lang');
$routes[]  = array('/([a-z0-9-_/]+)/filter/(.*)', 'system\Frontend', 'url/filter/filter');

$routes[]  = array('/([a-z]{2})/([a-zA-Z0-9-_/]+)/?', 'system\Frontend', 'lang/url');
$routes[]  = array('/([a-zA-Z0-9-_/]+)/page/([0-9]+)/?', 'system\Frontend', 'url/p');
$routes[]  = array('/(.*)', 'system\Frontend', 'url');

return $routes;