<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 22:04
 */
namespace system\core;

defined('CPATH') or die();

class Theme {

    private static $instance;
    private $vars;
    private static $theme;

    public static function instance()
    {
        if(self::$instance == null){
            self::$instance = new Theme();
        }
        self::switchTo();
        return self::$instance;
    }

    public static function switchTo($app='engine')
    {
        self::$theme = Config::getInstance()->get("themes.$app");
    }


    /**
     * function current
     * get current theme path
     * return string
     */
    public function current()
    {
        return self::$theme;
    }

    /**
     *	Setter method
     *	@param string $index
     *	@param mixed $value
     */
    public function __set($index, $value)
    {
        $this->vars[$index] = $value;
    }

    /**
     *	Getter method
     *	@param string $index
     */
    public function __get($index)
    {
        return isset($this->vars[$index]) ? $this->vars[$index] : null;
    }
}