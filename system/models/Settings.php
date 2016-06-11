<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 05.07.14 20:34
 */

namespace system\models;

use system\core\DB;

defined('CPATH') or die();

class Settings
{
    /**
     * get settings
     * @return array|mixed
     */
    public function get()
    {
        return DB::getInstance()->select("select name, value from __settings order by id asc")->all();
    }

    /**
     * @param $name
     * @param $value
     * @return bool
     */
    public function set($name, $value)
    {
        return DB::getInstance()->update("settings", array('value' => $value), " name = '{$name}' limit 1");
    }

    /**
     * @param $name
     * @param $value
     * @param $title
     * @param $description
     * @return bool|string
     */
    public function create($name, $value, $title, $description = '')
    {
        return DB::getInstance()->insert
            (
                'settings',
                array(
                    'name'        => $name,
                    'value'       => $value,
                    'title'       => $title,
                    'description' => $description
                )
            );
    }


} 