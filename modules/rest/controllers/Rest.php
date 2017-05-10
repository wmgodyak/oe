<?php
namespace modules\rest\controllers;
use system\core\Route;

/**
 * Created by PhpStorm.
 * User: wg
 * Date: 06.05.17
 * Time: 20:49
 */
class Rest
{
    public function index(){echo "Called rest::index";}
    public function create(){}
    public function edit($id){}
    public function update($id){}
    public function delete($id){}


    public function boot()
    {
        Route::getInstance()->get('my-custom-route', function(){return 'callback';});
        Route::getInstance()->get('my-custom-route-2', 'MyModuleName::action');
    }
}