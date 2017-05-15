<?php
namespace modules\rest\controllers;
use system\core\Route;
use system\Frontend;

/**
 * Created by PhpStorm.
 * User: wg
 * Date: 06.05.17
 * Time: 20:49
 */
class Rest extends Frontend
{
    public function index(){echo "Called rest::index";}
    public function create(){}
    public function edit($id){}
    public function update($id){}
    public function delete($id){}


    public function boot()
    {
//        filter_add('backend.login.logo', 'http://otakoyi.com/themes/engine/images/logo.png.pagespeed.ce.djnBt5SiNy.png');
//        filter_add('backend.sidebar.logo', 'http://otakoyi.com/themes/engine/images/logo.png.pagespeed.ce.djnBt5SiNy.png');
        Route::getInstance()->get('my-custom-route', function(){return 'callback';});
        Route::getInstance()->get('my-custom-route-2', 'MyModuleName::action');
    }
}