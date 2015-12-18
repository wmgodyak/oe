<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 04.05.14 1:36
 */

namespace controllers\core;

defined('CPATH') or die();

class Request {

    private $storage=array(); // local storage
    private static $instance;

    const METHOD_HEAD = 'HEAD';
    const METHOD_GET = 'GET';
    const METHOD_POST = 'POST';
    const METHOD_PUT = 'PUT';
    const METHOD_PATCH = 'PATCH';
    const METHOD_DELETE = 'DELETE';
    const METHOD_OPTIONS = 'OPTIONS';
    const METHOD_OVERRIDE = '_METHOD';

    /**
     * сюди записуєм всі дані для шаблонів: title, keywords, content
     * @var array
     */
    private $content = array();
    /**
     * містить в собі GET паратмери, які ключі яких мають назви
     * @var array
     */
    private $param = array();

    public $mode;

    public static function instance()
    {
        if(!self::$instance instanceof self){
            self::$instance = new Request;
        }
        return self::$instance;
    }

    public function get($name='', $type = null)
    {
        $val = null;
        if(isset($this->param[$name])){
            $val = $this->param[$name];
        }
        // all
        if($name ==''){
            $val = $this->param;
        }

        if(!empty($type) && is_array($val))
            $val = reset($val);

        if($type == 'str')
            return strval(preg_replace('/[^\p{L}\p{Nd}\d\s_\-\.\%\s]/ui', '', $val));

        if($type == 'int')
            return intval($val);

        if($type == 'bool')
            return !empty($val);

        return $val;
    }

    public function set($key, $val)
    {
        $this->param[$key] = $val;

        return $this;
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

        if($type == 'str')
            return strval(preg_replace('/[^\p{L}\p{Nd}\d\s_\-\.\%\s]/ui', '', $val));

        if($type == 'int')
            return intval($val);

        if($type == 'bool')
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
        if($val !== null) $this->param[$key] = $val;

        if($key == '*') return $this->param;
        else {
            return isset($this->param[$key]) ? $this->param[$key] : null;
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
        return false;
    }

    /**
     * Заповнюю дані про сторінку з БД
     * @param $data
     */
    public function setContentData($data)
    {
        $this->content = $data;
    }

    /**
     * вертає / записує дані про сторінку
     * @param $key
     * @param $value
     * @return string
     */
    public function content($key = null, $value = null )
    {
        if($value) {
            $this->content[$key] = $value;
        }

        if($key) {
            return isset($this->content[$key]) ? $this->content[$key] : '';
        } else {
            return $this->content;
        }
    }

}
