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

    public function __construct()
    {
        $this->sys_name = base64_decode('T1lpLkVuZ2luZSA2');
        $this->load = Load::instance();
        $this->request = Request::instance();

        if($this->request->isPost()){
            $token = $this->request->post('token');
            if($token != TOKEN){
                die('#1201. Invalid token.');
            }
        }
    }

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

    public function redirect($uri)
    {
        header('Location: ' . $uri);die;
    }
} 