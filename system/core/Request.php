<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 04.05.14 1:36
 */

namespace system\core;

defined('CPATH') or die();

class Request
{
    private $storage = [];
    private static $instance;

    const METHOD_HEAD     = 'HEAD';
    const METHOD_GET      = 'GET';
    const METHOD_POST     = 'POST';
    const METHOD_PUT      = 'PUT';
    const METHOD_PATCH    = 'PATCH';
    const METHOD_DELETE   = 'DELETE';
    const METHOD_OPTIONS  = 'OPTIONS';
    const METHOD_OVERRIDE = '_METHOD';

    private function __construct(){}
    private function __clone(){}

    public static function getInstance()
    {
        if(!self::$instance instanceof self){
            self::$instance = new Request();
        }

        return self::$instance;
    }

    /**
     * @deprecated
     * @return mixed
     */
    public function getMode()
    {
        return $this->__get('mode');
    }

    /**
     * @deprecated
     * @return mixed
     */
    public function setMode($mode)
    {
        $this->__set('mode', $mode);

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

        if($type == 's')
            return strval(preg_replace('/[^\p{L}\p{Nd}\d\s_\-\.\%\s]/ui', '', $val));

        if($type == 'i')
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
     * @deprecated
     * Управління доступом до $_REQUEST $param
     * @param $key
     * @param null $val
     * @return null
     */
    public function param($key = '*', $val = null)
    {
        if($val !== null) {

            $this->storage[$key] = $val;

            return $this;
        }

        if($key == '*') {
            return $this->storage;
        }

        return isset($this->storage[$key]) ? $this->storage[$key] : null;
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

    public function __set($key, $val)
    {
        if(empty($key)){
            throw new \InvalidArgumentException("Invalid key");
        }

        $this->storage = dots_set($this->storage, $key, $val);
    }

    public function __get($key)
    {
        if(!isset($this->storage[$key])){
            throw new \InvalidArgumentException("Invalid key");
        }

        return dots_get($this->storage, $key);
    }



}
