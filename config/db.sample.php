<?php

defined("CPATH") or die();

$db = [
    'type'     => 'mysql',
    'host'     => 'localhost',
    'db'       => '',
    'prefix'   => 'e_',
    'user'     => '',
    'pass'     => '',
    'port'     => 3306,
    'charset'  => 'utf8',
    'debug'    => true
];

if(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] == '127.0.0.1'){
    $db = [
        'type'     => '{$type}',
        'host'     => '{host}',
        'db'       => '{db}',
        'prefix'   => '{prefix}',
        'user'     => '{user}',
        'pass'     => '{pass}',
        'port'     => 3306,
        'charset'  => 'utf8',
        'debug'    => true
    ];
}
return $db;
