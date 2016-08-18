<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.08.16
 * Time: 23:19
 */

namespace system\models\cache;

/**
 * Class Files
 * @package system\models\cache
 */
class Files
{
    private $path;

    public function __construct($config)
    {
        $this->path = $config['path'];

        if( ! is_dir(DOCROOT . $this->path)) mkdir(DOCROOT . $this->path, 0777, true);
    }

    /**
     * @param $key
     * @return mixed|null
     */
    public function get($key)
    {
        if( ! file_exists(DOCROOT . $this->path . $key)) return null;

        $value = file(DOCROOT . $this->path . $key);

        if(empty($value)){
//            unlink(DOCROOT . $this->path . $key);
            return null;
        }

        $expired = array_shift($value);

        if($expired > 0 && $expired < time()) {
//            unlink(DOCROOT . $this->path . $key);
            return null;
        }

        $value = base64_decode($value[0]);

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
    public function set($key, $value, $expired)
    {
        if($expired > 0) {
            $expired = strtotime("+$expired seconds");
        }

        if(is_array($value)) $value = serialize($value);

        $value = base64_encode($value);

        file_put_contents(DOCROOT . $this->path . $key, "$expired\n$value");
    }

    /**
     * @param $key
     * @return mixed
     */
    public function exists($key)
    {
        if( ! file_exists(DOCROOT . $this->path . $key)) return false;

        $value = file(DOCROOT . $this->path . $key);

        if(empty($value)) return false;

        $expired = array_shift($value);

        if($expired > 0 && $expired < time()) return false;

        return true;
    }

    public function flush()
    {
        if ($handle = opendir(DOCROOT . $this->path)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".."){
                    unlink(DOCROOT . $this->path . $entry);
                }
            }
            closedir($handle);
        }
    }
}