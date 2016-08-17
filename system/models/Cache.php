<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.08.16
 * Time: 23:09
 */

namespace system\models;

use system\core\Config;
use system\core\exceptions\Exception;

/**
 * Class Cache
 * @package system\models
 */
class Cache
{
    private $id_prefix;
    private $driver;
    private $ns = '\system\models\cache\\';
    private $key;
    private $expired;

    public function __construct()
    {
        $this->id_prefix = md5($_SERVER['HTTP_HOST']);

        $config = Config::getInstance()->get('cache');

        if(empty($config['driver'])){
            throw new Exception("You must setup cache in config");
        }

        $driver = $config['driver'];

        $c  = $this->ns . ucfirst($driver);

        $path = str_replace("\\", "/", $c);

        if(!file_exists(DOCROOT . $path . '.php')) {
            throw new Exception("Driver $driver issue.");
        }

        include_once(DOCROOT . $path . '.php');

        $this->driver = new $c($config);
    }

    /**
     * @param $key
     * @return mixed|null
     */
    public function get($key)
    {
        $key = md5($this->id_prefix . $key);

        $value = $this->driver->get($key);

        if(empty($value)) return  null;

        if(isSerialized($value)){
            return unserialize($value);
        }

        return $value;
    }

    /**
     * @param $key
     * @param $value
     * @param $expired
     * @return mixed
     */
    public function set($key, $value, $expired = 0)
    {
        $key = md5($this->id_prefix . $key);

        if(is_array($value)) $value = serialize($value);

        return $this->driver->set($key, $value, $expired);
    }

    /**
     * @param $key
     * @return mixed
     */
    public function exists($key)
    {
        $key = md5($this->id_prefix . $key);

        return $this->driver->exists($key);
    }

    /**
     * @return mixed
     */
    public function flush()
    {
        return $this->driver->flush();
    }

    /**
     * @param $key
     * @param int $expired
     * @return mixed|null
     */
    public function begin($key, $expired = 0)
    {
        $cached = $this->get($key);

        if($cached) return $cached;

        $this->key = $key;
        $this->expired = $expired;

        ob_start();
    }

    /**
     * save buffer to cache
     */
    public function end()
    {
        $value = ob_get_contents();
        $this->set($this->key, $value, $this->expired);
        ob_end_flush();
    }
}