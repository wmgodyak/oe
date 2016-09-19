<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 11.06.16
 * Time: 23:49
 */

namespace system\models;

use system\core\Request;
use system\core\Response;

defined("CPATH") or die();

class Permissions
{
    /**
     * @var
     */
    private static $permissions;

    /**
     * @param $permissions
     */
    public static function set($permissions)
    {
//        d($permissions);die;
        self::$permissions = $permissions;
    }

    /**
     * @param $controller
     * @param $action
     * @param string $type
     * @return bool
     */
    public static function check($controller, $action, $type = 'components')
    {
        if(self::$permissions['full_access']) return true;

        if(!isset(self::$permissions[$type][$controller])) return false;

        if(in_array($action, self::$permissions[$type][$controller])) return true;

        return false;
    }

    public static function canComponent($controller, $action)
    {
        return self::check($controller, $action, 'components');
    }

    public static function canModule($controller, $action)
    {
        return self::check($controller, $action, 'modules');
    }

    public static function denied()
    {
        Response::getInstance()->sendError(401);
        if(Request::getInstance()->isXhr()){
            die;
        }
        echo '<!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Permission denied</title>
        <style type="text/css">
                html{background:#f9f9f9}
                body{
                    background:#fff;
                    color:#333;
                    font-family:sans-serif;
                margin:2em auto;
                padding:1em 2em 2em;
                -webkit-border-radius:3px;
                border-radius:3px;
                border:1px solid #dfdfdf;
                max-width:750px;
                text-align:left;
            }
            #error-page{margin-top:50px}
            #error-page h2{border-bottom:1px dotted #ccc;}
            #error-page p{font-size:16px; line-height:1.5; margin:2px 0 15px}
            #error-page .code-wrapper{color:#400; background-color:#f1f2f3; padding:5px; border:1px dashed #ddd}
            #error-page code{font-size:15px; font-family:Consolas,Monaco,monospace;}
            a{color:#21759B; text-decoration:none}
                    a:hover{color:#D54E21}
                        </style>
        </head>
        <body id="error-page">
            <h2>Отакої! У вас недостатньо прав :(</h2>
            <div class="code-wrapper">
                <code><p>Зверніться до адміністратора, щоб отримати доступ.</p> <p><a href="/engine/dashboard">Повернутись на головну</a></p></code>
            </div>
        </body>
        </html>';
//        d(Request::getInstance());
        die;
    }

}