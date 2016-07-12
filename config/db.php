<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 11:54
 */

/*
 * otakoyi_e7 та пароль для tnkjt27r
*/

$db = [
    'type'     => 'mysql',
    'host'     => 'otakoyi.mysql.ukraine.com.ua',
    'db'       => 'otakoyi_e7',
    'prefix'   => 'e_',
    'user'     => 'otakoyi_e7',
    'pass'     => 'tnkjt27r',
    'port'     => 3306,
    'charset'  => 'utf8',
    'debug'    => true
];

if($_SERVER['REMOTE_ADDR'] == '127.0.0.1'){
    $db = [
        'type'     => 'mysql',
        'host'     => 'localhost',
        'db'       => 'engine',
        'prefix'   => 'e_',
        'user'     => 'root',
        'pass'     => 'dell',
        'port'     => 3306,
        'charset'  => 'utf8',
        'debug'    => true
    ];
}
return $db;
