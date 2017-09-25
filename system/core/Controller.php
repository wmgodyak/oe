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
    const VERSION = "7.2.7";

    /**
     * @var Request
     */
    protected $request;
    /**
     * @var Response
     */
    protected $response;

    /**
     * @var null|Route
     */
    protected $route;

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

        $this->route = Route::getInstance();
    }

    /**
     * @return mixed
     */
    abstract public function index();

    /**
     * Initialize
     */
    public function init()
    {
        // here you can add callbacks for events
        // on system boot
//        events()->add('boot', function(){});

        // on page init
//        events()->add('init', function(){});
    }

    public function __toString()
    {
        return get_called_class();
    }
} 
