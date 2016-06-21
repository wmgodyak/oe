<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 04.05.14 1:36
 */

namespace system\core;

defined('CPATH') or die();

class Request {

    private $storage = array();
    private static $instance;

    const METHOD_HEAD     = 'HEAD';
    const METHOD_GET      = 'GET';
    const METHOD_POST     = 'POST';
    const METHOD_PUT      = 'PUT';
    const METHOD_PATCH    = 'PATCH';
    const METHOD_DELETE   = 'DELETE';
    const METHOD_OPTIONS  = 'OPTIONS';
    const METHOD_OVERRIDE = '_METHOD';

    private $params = array();

    private $mode;

    private function __construct($mode)
    {
        if(!$mode) {
            throw new \system\core\exceptions\Exception('Wrong request mode');
        }

        $this->mode = $mode;
    }

    private function __clone(){}

    /**
     * @param null $mode
     * @return Request
     */
    public static function getInstance($mode = null)
    {
        if(!self::$instance instanceof self){
            self::$instance = new Request($mode);
        }

        return self::$instance;
    }

    /**
     * @return mixed
     */
    public function getMode()
    {
        return $this->mode;
    }

    public function setMode($mode)
    {
        $this->mode = $mode;

        return $this;
    }

    public function get($name='', $type = null)
    {
        $val = null;
        if(isset($_GET[$name])){
            $val = $_GET[$name];
        }
        // all
        if($name ==''){
            $val = $_GET;
        }

        if(!empty($type) && is_array($val))
            $val = reset($val);

        if($type == 'i')
            return strval(preg_replace('/[^\p{L}\p{Nd}\d\s_\-\.\%\s]/ui', '', $val));

        if($type == 's')
            return intval($val);

        if($type == 'b')
            return !empty($val);

        return $val;
    }

    /**
     * @param null $name
     * @param null $type
     * @return bool|int|null|string
     */
    public function post($name = null, $type = null)
    {
        $val = null;
        if(!empty($name) && isset($_POST[$name]))
            $val = $_POST[$name];
        elseif(empty($name))
            $val = file_get_contents('php://input');

        if($type == 's')
            return strval(preg_replace('/[^\p{L}\p{Nd}\d\s_\-\.\%\s]/ui', '', $val));

        if($type == 'i')
            return intval($val);

        if($type == 'b')
            return !empty($val);

        return $val;
    }

    /**
     * Управління доступом до $_REQUEST $param
     * @param $key
     * @param null $val
     * @return null
     */
    public function param($key='*', $val=null)
    {
        if($val !== null) {
            $this->params[$key] = $val;
            return $this;
        }

        if($key == '*') return $this->params;
        else {
            return isset($this->params[$key]) ? $this->params[$key] : null;
        }
    }

    /**
     * Get HTTP method
     * @return string
     */
    public function getMethod()
    {
        return $_SERVER['REQUEST_METHOD'];
    }

    /**
     * Is this a GET request?
     * @return bool
     */
    public function isGet()
    {
        return $this->getMethod() === self::METHOD_GET;
    }

    /**
     * Is this a POST request?
     * @return bool
     */
    public function isPost()
    {
        return $this->getMethod() === self::METHOD_POST;
    }

    /**
     * Is this a PUT request?
     * @return bool
     */
    public function isPut()
    {
        return $this->getMethod() === self::METHOD_PUT;
    }

    /**
     * Is this a PATCH request?
     * @return bool
     */
    public function isPatch()
    {
        return $this->getMethod() === self::METHOD_PATCH;
    }

    /**
     * Is this a DELETE request?
     * @return bool
     */
    public function isDelete()
    {
        return $this->getMethod() === self::METHOD_DELETE;
    }

    /**
     * Is this a HEAD request?
     * @return bool
     */
    public function isHead()
    {
        return $this->getMethod() === self::METHOD_HEAD;
    }

    /**
     * Is this a OPTIONS request?
     * @return bool
     */
    public function isOptions()
    {
        return $this->getMethod() === self::METHOD_OPTIONS;
    }

    public function isXhr()
    {
        return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest';
    }

    public function setStorage($data)
    {
        if(!empty($data)){
            $this->storage = array_merge($this->storage, $data);
        }

        return $this;
    }

    public function __set($key,$val)
    {
        $this->storage[$key] = $val;
    }

    public function __get($key)
    {
        if(isset($this->storage[$key])){
            return $this->storage[$key];
        }
        return null;
    }
}
