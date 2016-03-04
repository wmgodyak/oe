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
    $path =  '../../config/db.php';
    $conf= include($path);

    if($this->connect($conf['host'], $conf['port'], $conf['user'], $conf['pass'])){
        $this->CFG['my_db'] = $conf['db'];
        $this->CFG['exitURL'] = './admin/logout';
        $auth = 1;
    }
}
