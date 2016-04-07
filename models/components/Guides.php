<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.04.16 : 14:15
 */

namespace models\components;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class Guides
 * @package models\components
 */
class Guides extends Model
{
    /**
     * @param $parent_id
     * @return mixed
     */
    public static function get($parent_id)
    {
        $l = self::$language_id;
        return self::$db
            ->select("
                  select g.id, i.name
                  from guides g
                  join guides_info i on i.guides_id=g.id and i.languages_id={$l}
                  where g.parent_id={$parent_id}
              ")
            ->all();
    }

    /**
     * @param $code
     * @return mixed
     */
    public static function getByCode($code)
    {
        $parent_id = self::getIdByCode($code);
        if(empty($parent_id)) return false;

        return self::get($parent_id);
    }

    /**
     * @param $code
     * @return array|mixed
     */
    public static function getIdByCode($code)
    {
        return self::$db->select("select id from guides where code='$code' limit 1")->row('id');
    }

}