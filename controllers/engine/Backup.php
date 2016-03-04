<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wg.
 * Date: 31.05.14 18:36
 */
namespace controllers\engine;

use controllers\Engine;

defined('CPATH') or die();
/**
 * Class Backup
 * @name Бекап БД
 * @icon fa-file-code-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Backup extends Engine
{
    public function index()
    {
        $url = APPURL ."vendor/sxd/";
        $body = "<div style='margin: 0 auto;width:600px;'><iframe src=\"{$url}\" width=\"586\" height=\"462\" frameborder=\"0\" style=\"margin:0;\"></iframe></div>";
        $this->output($body);
    }

    public function edit($id){}
    public function create(){}
    public function delete($id){}
    public function process($id){}
    public function install()
    {
        return 1;
    }
    public function uninstall()
    {
        return 1;
    }


}
