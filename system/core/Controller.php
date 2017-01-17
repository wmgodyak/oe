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
abstract class Controller
{
    /**
     * system version
     */
    const VERSION = "7.2.4";
    /**
     * @var
     */
    protected $storage;
    /**
     * @var Request
     */
    protected $request;
    /**
     * @var Response
     */
    protected $response;
    /**
     * error handler
     * @var object
     */
    protected $error;

    public function __construct()
    {
        $this->request = Request::getInstance();
        // response
        $this->response = Response::getInstance();
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

    protected function validateToken()
    {
        if($this->request->isPost()) {
            $token = $this->request->post('token');
            if($token != TOKEN){
                die('#1201. Invalid token.');
            }
        }
    }
} 
