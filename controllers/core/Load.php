<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 21:52
 */
namespace controllers\core;

defined('CPATH') or die();

/**
 * Load Class
 */
class Load
{
    private static $instance;
    private $storage;

    public static function instance()
    {
        if(!self::$instance instanceof self){
            self::$instance = new self;
        }
        return self::$instance;
    }

    public function set($key, $value)
    {
        $this->storage[$key] = $value;
    }

    /**
     * вертає дані по ключу зі сховища
     * @param $key
     * @return mixed
     * @throws \Exception
     */
    public function __get($key)
    {
        if(!$this->storage[$key]) throw new \Exception("Key {$key} issues in Load storage");
        return $this->storage[$key];
    }

     /**
     * @param $name
     * @param array $vars
     * @return string
     * @throws Exceptions
     */
    public function chunk($name, array $vars = null)
    {
        return 'this method is depredated';
        $themes_path = Settings::getInstance()->get('themes_path');

        $current = Settings::getInstance()->get('app_theme_current');
        $chunks_path = Settings::getInstance()->get('app_chunks_path');
        $base = $themes_path . $current.'/';
        $t = $this->translations;

        $template_url = APPURL . $themes_path . $current . '/';
        $base_url = APPURL;

        // дані про сторінку
        if(!isset($vars['page'])){
            $request = Request::getInstance();
            $vars['page'] = $request->param();
        }

        $file = $base . $chunks_path . $name . '.php';

        if(is_readable($file)){

            ob_start();

            if(isset($vars)){
                extract($vars);
            }

            require($file);

            return ob_get_clean();
        }

        throw new Exceptions("Chunk: <b>{$file}</b> issues");
    }

    public function module($controller , $action = 'index' , $params = array())
    {
        $mod_path = Settings::getInstance()->get('mod_path');
        $controller= $mod_path . $controller;

        $className = ltrim($controller, '\\');
        $fileName  = ''; $namespace='';
        if ($lastNsPos = strrpos($className, '\\')) {
            $namespace = substr($className, 0, $lastNsPos);
            $className = substr($className, $lastNsPos + 1);
            $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
        }
        $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
        $fileName = $_SERVER['DOCUMENT_ROOT'] .'/'. $fileName;
        if (is_readable($fileName)){

            require_once($fileName);

            $c = $namespace .'\\'. $className;

            if(class_exists($c)){
                ob_start();

                $controller = new $c;

                $action = (is_callable(array($controller,$action))) ? $action : 'index';

                if(!empty($params)){
                    echo call_user_func_array(array($controller,$action),$params);
                } else{
                    echo call_user_func(array($controller,$action));
                }

                return ob_get_clean();
            }
        }

        throw new Exceptions("Module {$controller} :: {$action} issues.");
    }
}
