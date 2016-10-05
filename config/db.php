<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 11:54
 */

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

if($_SERVER['REMOTE_ADDR'] == '127.0.0.1'){
    $db = [
        'type'     => 'mysql',
        'host'     => 'localhost',
        'db'       => '',
        'prefix'   => 'e_',
        'user'     => 'root',
        'pass'     => '',
        'port'     => 3306,
        'charset'  => 'utf8',
        'debug'    => true
    ];
}
return $db;
