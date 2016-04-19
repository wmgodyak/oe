<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 21:47
 */

namespace controllers\core;

defined('CPATH') or die();

/**
 * Base controller
 */
abstract class Controller {

    protected $storage;

    protected $load;
    protected $request;
    /**
     * error handler
     * @var object
     */
    protected $error;

    protected $sys_name = '';
    protected $version = 7.01;

    public function __construct()
    {
        $this->sys_name = base64_decode('T1lpLkVuZ2luZSA2');
        $this->load = Load::instance();
        $this->request = Request::getInstance();

        if($this->request->isPost()){
            $token = $this->request->post('token');
            if($token != TOKEN){
                die('#1201. Invalid token.');
            }
        }
    }
    abstract public function before();
    /**
     * @return mixed
     */
    abstract public function index();

    /**
     *	Setter method
     *	@param string $index
     *	@param mixed $value
     */
    final public function __set($index, $value)
    {
        $this->storage[$index] = $value;
    }

    /**
     *	Getter method
     *	@param string $index
     *  @return array
     */
    final public function __get($index)
    {
        return isset($this->storage[$index]) ? $this->storage[$index] : null;
    }

    /**
     * @param $var
     * @param bool|false $use_var_dump
     */
    final public static function dump($var, $use_var_dump = false)
    {
        $func = $use_var_dump ? 'var_dump' : 'print_r';
        echo '<pre>'; $func($var); echo '</pre>';
    }

    /**
     * @param $var
     * @param bool|false $use_var_dump
     */
    final public static function dDump($var, $use_var_dump = false)
    {
        self::dump($var, $use_var_dump); die;
    }

    public function redirect($uri, $header = null)
    {
        switch($uri){
            case 404:
                $uri = 'NotFound';
                break;
        }
        switch($header){
            case 404:
                header("HTTP/1.0 404 Not Found");
                break;
            default:
                break;
        }

        header('Location: ' . $uri);die;
    }
} 