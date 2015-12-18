<?php
/**
 * Company Otakoyi.com
 * Author: wmgodyak
 * Date: 18.01.15 12:58
 */
session_name('oyiengine');
session_start();
if(!empty($_SESSION['admin'])){
    define('SYSPATH', 1);
    $path =  '../../system/config.php';
    $conf= include($path);

    if($this->connect($conf['db']['host'], $conf['db']['port'], $conf['db']['user'], $conf['db']['pass'])){
        $this->CFG['my_db'] = $conf['db']['db'];
        $this->CFG['exitURL'] = './auth/logout';
        $auth = 1;
    }
}
