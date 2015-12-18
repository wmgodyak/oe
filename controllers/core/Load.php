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
    public function view($name, array $vars = null)
    {
        $mode = Request::instance()->mode;

        $themes_path = Settings::instance()->get('themes_path');
        $views_path = Settings::instance()->get('app_views_path');

        if($mode == 'engine')
        {
            $current = Settings::instance()->get('engine_theme_current');
//            $base = $themes_path . $current . '/';
            // load translation
            $lang = Languages::instance()->getTranslations();
        } else {
            return " <pre>this method is deprecated on app mode.\r\n Use this->template->assign('key', 'value');\r\n return this->template->fetch('path/to/file')</pre>";
            // App
//            $current = Settings::instance()->get('app_theme_current');
//            $base = $themes_path . $current.'/';
//            $t = $this->translations;
        }
        $template_url = APPURL . $themes_path . $current . '/';
        $base_url = APPURL;
        $file = $themes_path . $current . '/' . $views_path .'/'. $name .'.php';

        if(is_readable($file)){

            ob_start();

            if(isset($vars)){
                extract($vars);
            }

            require($file);

            return ob_get_clean();
        }
        throw new Exceptions("View: <b>{$file}</b> issues");
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
        $themes_path = Settings::instance()->get('themes_path');

        $current = Settings::instance()->get('app_theme_current');
        $chunks_path = Settings::instance()->get('app_chunks_path');
        $base = $themes_path . $current.'/';
        $t = $this->translations;

        $template_url = APPURL . $themes_path . $current . '/';
        $base_url = APPURL;

        // дані про сторінку
        if(!isset($vars['page'])){
            $request = Request::instance();
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

    public function model($name, $newName ='')
    {
        $name = MPATH . $name;
//        echo $name,'<br>';
        $className = ltrim($name, '\\');
        $fileName  = ''; $namespace='';
        if ($lastNsPos = strrpos($className, '\\')) {
            $namespace = substr($className, 0, $lastNsPos);
            $className = substr($className, $lastNsPos + 1);
            $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
        }
        $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
        $fileName = DOCROOT .'/'. $fileName;
        if (is_readable($fileName)){

            require_once($fileName);

            $c = $namespace .'\\'. $className;

            if(class_exists($c)){
                $className = empty($newName) ? $className : $newName;

                $this->$className =  new $c;
                return $this->$className;
            }
        }

        throw new Exceptions("Model '$name' issues.");
    }

    public function plugin($name)
    {
        $className = ltrim($name, '\\');
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
                $className = empty($newName) ? $className : $newName;

                $this->$className =  new $c;
                return $this->$className;
            }
        }

        throw new Exceptions("plugin '$name' issues.");
    }

    public function module($controller , $action = 'index' , $params = array())
    {
        $mod_path = Settings::instance()->get('mod_path');
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

    /**
     * load component structure
     * @param $controller
     * @return mixed
     * @throws Exceptions
     */
    public function component($controller)
    {
        $controller = str_replace('/','\\',$controller);
        $className = ltrim($controller, '\\');
        $fileName  = ''; $namespace='';
        if ($lastNsPos = strrpos($className, '\\')) {
            $namespace = substr($className, 0, $lastNsPos);
            $className = substr($className, $lastNsPos + 1);
            $className = ucfirst($className);
            $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
        }
        $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
        $fileName = DOCROOT . $fileName;
        if (is_readable($fileName)){

            require_once($fileName);

            $c = $namespace .'\\'. $className;

            if(class_exists($c)){

                return new $c;
            }
        }

        throw new Exceptions("Component {$controller} issues.");
    }

    /**
     * Load helper from /helpers
     * @param $fileName
     */
    public function helper($fileName)
    {
        $path = DOCROOT . "helpers/$fileName.php";
        if (is_readable($path)){

            require_once($path);
        }
    }
}
