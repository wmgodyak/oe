<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 21:47
 */

namespace system\core;

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

//        if($this->request->isPost() && !isset($_SERVER['PHP_AUTH_USER'])) {
//            $token = $this->request->post('token');
//            if($token != TOKEN){
//                die('#1201. Invalid token.');
//            }
//        }
    }

    /**
     * @return mixed
     */
    abstract public function index();
    abstract public function init();

    /**
     *	Setter method
     *	@param string $index
     *	@param mixed $value
     */
    final public function __set($index, $value)
    {
        $this->storage[$index] = $value;
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