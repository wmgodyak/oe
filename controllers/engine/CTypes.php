<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.02.16 : 16:58
 */


namespace controllers\engine;

use controllers\core\exceptions\FileNotFoundException;
use controllers\Engine;
use models\engine\Content;

defined("CPATH") or die();

/**
 * Class CTypes
 * @package controllers\engine
 */
class CTypes extends Engine
{
    const NS = 'controllers\engine\ctypes\\';
    protected $mContent;

    public function __construct()
    {
        parent::__construct();
        $this->mContent =  new Content();
    }

    public final function run()
    {
        $args       = func_get_args();
        if(empty($args)) return '';

        $controller = ucfirst($args[0]);
        $action     = isset($args[1]) ? $args[1] : 'index';
        $params = isset($args[2]) ? array_slice($args, 2) : null;

        $path = str_replace('\\', DIRECTORY_SEPARATOR, self::NS) . DIRECTORY_SEPARATOR;
        if(! file_exists(DOCROOT . $path . ucfirst($controller) . '.php')) {
            throw new FileNotFoundException("Контроллер типу {$controller} не знайдено.");
        }

        $cl = self::NS.  ucfirst($controller);

        $controller = new $cl;

        if(!empty($params)){
            $res = call_user_func_array(array($controller, $action), $params);
        } else{
            $res = call_user_func(array($controller, $action));
        }

        return $res;
    }

    public function index()
    {
    }

    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function delete($id)
    {
    }

    public function process($id)
    {
    }

}