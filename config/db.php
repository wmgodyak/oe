<?php

defined("CPATH") or die();

$db = [
    'type'     => 'mysql',
    'host'     => 'localhost',
    'db'       => 'rg',
    'prefix'   => 'x_',
    'user'     => 'root',
    'pass'     => 'dell',
    'port'     => 3306,
    'charset'  => 'utf8',
    'debug'    => true
];

return $db;
